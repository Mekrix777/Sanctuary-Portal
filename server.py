import http.server
import socketserver
import json
import subprocess
import os
import time
import hashlib

PORT = 8080
VAULT_FILE = "sanctuary_vault.log"
NOSQL_DB = "nosql_store.json"
SYSTEM_PIN = "199407"

def init_nosql_db():
    if not os.path.exists(NOSQL_DB):
        initial_data = {
            "_meta": {"system": "Mekrix Sanctuary Portal", "version": "8.3"},
            "files": {},
            "exorixpo": [
                {"id": 1, "title": "Mega Poland Wetr'vi Core", "tag": "#WszystkoTwoje", "status": "AKTYWNY"},
                {"id": 2, "title": "Exorixpo Digital Sanctuary", "tag": "#JestMoje", "status": "WDRAŻANY"}
            ],
            "ai_books": [
                {"id": 1, "title": "Architektura C# & C++", "content": "C# imports C++ via native interop and shared .so libraries."}
            ],
            "vault": []
        }
        with open(NOSQL_DB, "w", encoding="utf-8") as f:
            json.dump(initial_data, f, indent=4, ensure_ascii=False)

def read_nosql():
    init_nosql_db()
    try:
        with open(NOSQL_DB, "r", encoding="utf-8") as f:
            return json.load(f)
    except Exception:
        return {"_meta": {}, "files": {}, "exorixpo": [], "ai_books": [], "vault": []}

def write_nosql(data):
    with open(NOSQL_DB, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=4, ensure_ascii=False)

class SanctuaryHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        if self.path == '/api/stats':
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            
            uname = subprocess.getoutput("uname -m 2>/dev/null || echo 'ARM'")
            uptime = subprocess.getoutput("uptime -p 2>/dev/null || echo 'Nieznany'")
            disk = subprocess.getoutput("df -h /data 2>/dev/null | tail -n 1")
            mem = subprocess.getoutput("free -h 2>/dev/null || echo 'Brak danych RAM'")
            
            db = read_nosql()
            file_count = len(db.get("files", {}))
            exo_count = len(db.get("exorixpo", []))
            book_count = len(db.get("ai_books", []))
            
            data = {
                "arch": uname, "uptime": uptime, "disk": disk, "mem": mem, 
                "nosql_files": file_count, "exorixpo_projects": exo_count, "ai_books": book_count
            }
            self.wfile.write(json.dumps(data).encode('utf-8'))
            
        elif self.path == '/api/vault/read':
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            
            logs = "[VAULT SECURE] System zabezpieczony.\n"
            if os.path.exists(VAULT_FILE):
                with open(VAULT_FILE, "r", encoding="utf-8", errors="ignore") as f:
                    logs = f.read()
            self.wfile.write(json.dumps({"logs": logs}).encode('utf-8'))

        elif self.path == '/api/exorixpo/list':
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            db = read_nosql()
            self.wfile.write(json.dumps({"projects": db.get("exorixpo", [])}).encode('utf-8'))

        elif self.path == '/api/books/list':
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            db = read_nosql()
            self.wfile.write(json.dumps({"books": db.get("ai_books", [])}).encode('utf-8'))
            
        elif self.path.startswith('/api/file/read'):
            try:
                filename = self.path.split('=')[1]
                filename = os.path.basename(filename)
                content = ""
                if os.path.exists(filename):
                    with open(filename, "r", encoding="utf-8", errors="ignore") as f:
                        content = f.read()
                self.send_response(200)
                self.send_header('Content-type', 'application/json')
                self.send_header('Access-Control-Allow-Origin', '*')
                self.end_headers()
                self.wfile.write(json.dumps({"filename": filename, "content": content}).encode('utf-8'))
            except Exception as e:
                self.send_response(500)
                self.end_headers()
                self.wfile.write(str(e).encode())

        elif self.path.startswith('/api/nosql/history'):
            try:
                filename = self.path.split('=')[1] if '=' in self.path else ''
                filename = os.path.basename(filename)
                db = read_nosql()
                history = db.get("files", {}).get(filename, [])
                self.send_response(200)
                self.send_header('Content-type', 'application/json')
                self.send_header('Access-Control-Allow-Origin', '*')
                self.end_headers()
                self.wfile.write(json.dumps({"filename": filename, "history": history}).encode('utf-8'))
            except Exception as e:
                self.send_response(500)
                self.end_headers()
                self.wfile.write(str(e).encode())
        else:
            super().do_GET()

    def do_POST(self):
        content_length = int(self.headers.get('Content-Length', 0))
        post_data = self.rfile.read(content_length)
        req = json.loads(post_data.decode('utf-8')) if content_length > 0 else {}
        
        if self.path == '/api/exec':
            cmd = req.get('cmd', '').strip()
            try:
                process = subprocess.run(cmd, shell=True, capture_output=True, timeout=10)
                output = process.stdout.decode('utf-8', errors='replace') + process.stderr.decode('utf-8', errors='replace')
            except Exception as e:
                output = f"[BLAD WYKONANIA]: {str(e)}"
            
            with open(VAULT_FILE, "a", encoding="utf-8", errors="ignore") as f:
                f.write(f"[SECURE EXEC] {cmd}\nWynik:\n{output}\n----------------------------------------\n")
            
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            self.wfile.write(json.dumps({"status": "ok", "output": output}).encode('utf-8'))
            
        elif self.path == '/api/file/save':
            filename = req.get('filename', '').strip()
            content = req.get('content', '')
            filename = os.path.basename(filename)
            
            try:
                with open(filename, "w", encoding="utf-8") as f:
                    f.write(content)
                
                db = read_nosql()
                if "files" not in db:
                    db["files"] = {}
                if filename not in db["files"]:
                    db["files"][filename] = []
                
                version_doc = {
                    "v_id": len(db["files"][filename]) + 1,
                    "timestamp": time.strftime("%Y-%m-%d %H:%M:%S"),
                    "bytes": len(content.encode('utf-8')),
                    "hash": hashlib.md5(content.encode('utf-8')).hexdigest()[:8],
                    "content": content
                }
                
                db["files"][filename].append(version_doc)
                write_nosql(db)
                status = f"saved (NoSQL v{version_doc['v_id']})"
            except Exception as e:
                status = str(e)
                
            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            self.wfile.write(json.dumps({"status": status}).encode('utf-8'))

        elif self.path == '/api/exorixpo/add':
            title = req.get('title', '').strip()
            tag = req.get('tag', '#JestMoje').strip()
            try:
                db = read_nosql()
                if "exorixpo" not in db:
                    db["exorixpo"] = []
                new_proj = {
                    "id": len(db["exorixpo"]) + 1,
                    "title": title,
                    "tag": tag,
                    "status": "AKTYWNY"
                }
                db["exorixpo"].append(new_proj)
                write_nosql(db)
                status = "added"
            except Exception as e:
                status = str(e)

            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            self.wfile.write(json.dumps({"status": status}).encode('utf-8'))

        elif self.path == '/api/books/add':
            title = req.get('title', '').strip()
            content = req.get('content', '').strip()
            try:
                db = read_nosql()
                if "ai_books" not in db:
                    db["ai_books"] = []
                new_book = {
                    "id": len(db["ai_books"]) + 1,
                    "title": title,
                    "content": content
                }
                db["ai_books"].append(new_book)
                write_nosql(db)
                status = "added"
            except Exception as e:
                status = str(e)

            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            self.wfile.write(json.dumps({"status": status}).encode('utf-8'))

        elif self.path == '/api/nosql/restore':
            filename = req.get('filename', '').strip()
            v_id = req.get('v_id', 0)
            filename = os.path.basename(filename)
            
            try:
                db = read_nosql()
                versions = db.get("files", {}).get(filename, [])
                target_ver = next((v for v in versions if v.get("v_id") == v_id), None)
                
                if target_ver:
                    content = target_ver["content"]
                    with open(filename, "w", encoding="utf-8") as f:
                        f.write(content)
                    res_status = f"przywrócono v{v_id}"
                else:
                    res_status = "nie znaleziono wersji"
            except Exception as e:
                res_status = str(e)

            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            self.wfile.write(json.dumps({"status": res_status}).encode('utf-8'))
            
        elif self.path == '/api/cpp/compile':
            try:
                compile_cmd = "g++ -shared -fPIC -o libcore.so core.cpp"
                process = subprocess.run(compile_cmd, shell=True, capture_output=True, timeout=10)
                output = process.stdout.decode('utf-8', errors='replace') + process.stderr.decode('utf-8', errors='replace')
                success = process.returncode == 0
                res_status = "SUCCESS" if success else "COMPILATION_ERROR"
            except Exception as e:
                output = str(e)
                res_status = "ERROR"

            self.send_response(200)
            self.send_header('Content-type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            self.wfile.write(json.dumps({"status": res_status, "output": output}).encode('utf-8'))

print(f"[SANCTUARY CORE v8.3 Mekrix] Aktywny na porcie {PORT}...")
init_nosql_db()
with socketserver.TCPServer(("", PORT), SanctuaryHandler) as httpd:
    httpd.serve_forever()
