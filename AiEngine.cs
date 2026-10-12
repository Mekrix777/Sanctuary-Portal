using System;
using System.IO;
using System.Net;
using System.Text;
using System.Runtime.InteropServices;

class AiEngine
{
    [DllImport("./libcore.so", EntryPoint = "process_data_packet", CharSet = CharSet.Ansi)]
    private static extern IntPtr process_data_packet(string inputJson);

    public static void Main(string[] args)
    {
        int port = 8080;
        HttpListener listener = new HttpListener();
        listener.Prefixes.Add($"http://localhost:{port}/");
        listener.Start();

        Console.WriteLine("==================================================");
        Console.WriteLine("  Mr.Mekrix | AI Engine & Web IDE Bridge v7.1     ");
        Console.WriteLine("  Ekosystem: Mega Poland Wetr'vi                  ");
        Console.WriteLine($"  Nasłuchiwanie na: http://localhost:{port}/       ");
        Console.WriteLine("==================================================");

        while (true)
        {
            HttpListenerContext context = listener.GetContext();
            HttpListenerRequest request = context.Request;
            HttpListenerResponse response = context.Response;

            response.AddHeader("Access-Control-Allow-Origin", "*");
            response.AddHeader("Access-Control-Allow-Headers", "Content-Type");
            response.AddHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");

            if (request.HttpMethod == "OPTIONS")
            {
                response.StatusCode = (int)HttpStatusCode.OK;
                response.Close();
                continue;
            }

            string path = request.Url.AbsolutePath;

            try
            {
                if (request.HttpMethod == "POST" && path == "/api/analyze")
                {
                    using (var reader = new StreamReader(request.InputStream, Encoding.UTF8))
                    {
                        string jsonInput = reader.ReadToEnd();
                        IntPtr ptr = process_data_packet(jsonInput);
                        string cppResult = Marshal.PtrToStringAnsi(ptr);
                        
                        byte[] buffer = Encoding.UTF8.GetBytes(cppResult);
                        response.ContentType = "application/json";
                        response.OutputStream.Write(buffer, 0, buffer.Length);
                    }
                }
                else if (request.HttpMethod == "GET" && path.StartsWith("/api/file/read"))
                {
                    // Odczyt pliku na potrzeby Web IDE
                    string query = request.Url.Query; // np. ?file=AiEngine.cs
                    string filename = "AiEngine.cs";
                    if (query.Contains("file="))
                    {
                        filename = Path.GetFileName(query.Split('=')[1]);
                    }

                    string content = "";
                    if (File.Exists(filename))
                    {
                        content = File.ReadAllText(filename, Encoding.UTF8);
                    }
                    else
                    {
                        content = "// Plik nie istnieje lub brak dostępu";
                    }

                    string jsonRes = "{\"filename\":\"" + filename + "\", \"content\":" + Newtonsoft.Json(content) + "}"; // Prosta serializator
                    // Zamiast zewnętrznej biblioteki JSON, użyjemy bezpiecznego Base64 lub czystego JSON
                    // Dla pewności napiszemy bezpieczny enkoder JSON w C#:
                    string escapedContent = content.Replace("\\", "\\\\").Replace("\"", "\\\"").Replace("\n", "\\n").Replace("\r", "\\r");
                    string jsonResponse = "{\"filename\":\"" + filename + "\", \"content\":\"" + escapedContent + "\"}";

                    byte[] buffer = Encoding.UTF8.GetBytes(jsonResponse);
                    response.ContentType = "application/json";
                    response.OutputStream.Write(buffer, 0, buffer.Length);
                }
                else if (request.HttpMethod == "POST" && path == "/api/file/save")
                {
                    using (var reader = new StreamReader(request.InputStream, Encoding.UTF8))
                    {
                        string body = reader.ReadToEnd();
                        // Prosty parsers zapisu pliku z body JSON
                        // Oczekujemy {"filename":"...", "content":"..."}
                        string filename = ExtractJsonField(body, "filename");
                        string content = ExtractJsonField(body, "content");

                        if (!string.IsNullOrEmpty(filename))
                        {
                            filename = Path.GetFileName(filename);
                            File.WriteAllText(filename, content, Encoding.UTF8);
                            byte[] buffer = Encoding.UTF8.GetBytes("{\"status\":\"saved\"}");
                            response.ContentType = "application/json";
                            response.OutputStream.Write(buffer, 0, buffer.Length);
                        }
                        else
                        {
                            byte[] buffer = Encoding.UTF8.GetBytes("{\"status\":\"error: invalid filename\"}");
                            response.OutputStream.Write(buffer, 0, buffer.Length);
                        }
                    }
                }
                else
                {
                    // Serwowanie plików statycznych (np. index.html)
                    string fileToServe = path == "/" ? "index.html" : path.TrimStart('/');
                    fileToServe = Path.GetFileName(fileToServe); // Bezpieczeństwo ścieżki
                    
                    if (File.Exists(fileToServe))
                    {
                        byte[] buffer = File.ReadAllBytes(fileToServe);
                        if (fileToServe.EndsWith(".html")) response.ContentType = "text/html; charset=utf-8";
                        else if (fileToServe.EndsWith(".js")) response.ContentType = "application/javascript";
                        else if (fileToServe.EndsWith(".css")) response.ContentType = "text/css";
                        response.OutputStream.Write(buffer, 0, buffer.Length);
                    }
                    else
                    {
                        string msg = "{\"system\": \"Mega Poland Wetr'vi\", \"status\": \"ACTIVE\"}";
                        byte[] buffer = Encoding.UTF8.GetBytes(msg);
                        response.ContentType = "application/json";
                        response.OutputStream.Write(buffer, 0, buffer.Length);
                    }
                }
            }
            catch (Exception ex)
            {
                byte[] buffer = Encoding.UTF8.GetBytes("{\"error\": \"" + ex.Message.Replace("\"", "'") + "\"}");
                response.OutputStream.Write(buffer, 0, buffer.Length);
            }

            response.Close();
        }
    }

    // Prosta metoda wyciągająca pola z JSON bez zewnętrznych bibliotek
    private static string ExtractJsonField(string json, string field)
    {
        string pattern = $"\"{field}\":";
        int idx = json.IndexOf(pattern);
        if (idx == -1) return "";
        idx += pattern.Length;
        while (idx < json.Length && (json[idx] == ' ' || json[idx] == '\"')) idx++;
        if (idx >= json.Length) return "";
        
        // Jeśli wartość jest w cudzysłowie
        if (json[idx - 1] == '\"')
        {
            int endIdx = json.IndexOf("\"", idx);
            if (endIdx == -1) return "";
            return json.Substring(idx, endIdx - idx).Replace("\\n", "\n").Replace("\\r", "\r").Replace("\\\"", "\"");
        }
        return "";
    }
}
