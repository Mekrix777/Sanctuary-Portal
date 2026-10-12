            75% { transform: translate(4px, -3px) rotate(-0.5deg); }
            100% { transform: translate(-4px, 2px) rotate(1deg); }
        }

        .overload-flash {
            position: fixed; top: 0; left: 0; width: 100vw; height: 100vh;
            background: rgba(239, 68, 68, 0.4); pointer-events: none; z-index: 9999; display: none;
            animation: flashPulse 0.1s infinite alternate;
        }

        @keyframes flashPulse {
            0% { opacity: 0.3; }
            100% { opacity: 0.8; }
        }

        header {
            display: flex; justify-content: space-between; align-items: center;
            border-bottom: 2px solid #0284c7; padding-bottom: 10px; margin-bottom: 12px;
            background: rgba(3, 7, 18, 0.95); box-shadow: 0 0 15px rgba(2, 132, 199, 0.2);
            flex-wrap: wrap; gap: 8px; border-radius: 3px; padding: 10px;
        }

        h1 { color: #38bdf8; font-size: 1rem; text-shadow: 0 0 10px rgba(56,189,248,0.6); }
        .header-actions { display: flex; gap: 6px; }

        .overload-btn {
            background: #991b1b; color: #fef2f2; border: 1px solid #ef4444;
            padding: 5px 10px; border-radius: 2px; cursor: pointer; font-family: 'Share Tech Mono', monospace; font-weight: bold; font-size: 0.7rem;
            box-shadow: 0 0 8px rgba(239, 68, 68, 0.5);
        }

        .matrix-btn {
            background: #064e3b; color: #34d399; border: 1px solid #10b981;
            padding: 5px 10px; border-radius: 2px; cursor: pointer; font-family: 'Share Tech Mono', monospace; font-weight: bold; font-size: 0.7rem;
            box-shadow: 0 0 8px rgba(16, 185, 129, 0.4);
        }

        .tabs { display: flex; gap: 5px; margin-bottom: 12px; overflow-x: auto; padding-bottom: 4px; }
        .tab-btn { background: #070a12; color: #64748b; border: 1px solid #1e293b; padding: 8px 10px; border-radius: 2px; cursor: pointer; font-family: 'Share Tech Mono', monospace; font-size: 0.7rem; white-space: nowrap; transition: all 0.2s; }
        .tab-btn:hover { color: #38bdf8; border-color: #0284c7; }
        .tab-btn.active { background: #082f49; color: #38bdf8; border-color: #38bdf8; font-weight: bold; box-shadow: 0 0 10px rgba(2, 132, 199, 0.4); }

        .panel-card { display: none; background: rgba(5, 8, 15, 0.98); border: 1px solid #1e293b; border-radius: 3px; padding: 15px; box-shadow: 0 8px 32px rgba(0,0,0,0.9); }
        .panel-card.active { display: block; }

        h3 { color: #93c5fd; font-size: 0.9rem; margin-bottom: 8px; border-bottom: 1px dashed #1e293b; padding-bottom: 5px; }
        label { font-size: 0.75rem; color: #94a3b8; display: block; margin-bottom: 4px; }
        
        input, textarea, select { width: 100%; background: #020408; color: #38bdf8; border: 1px solid #334155; border-radius: 2px; padding: 8px; font-family: 'Share Tech Mono', monospace; font-size: 0.8rem; outline: none; margin-bottom: 8px; }
        button { background: #0284c7; color: #ffffff; border: none; padding: 9px; border-radius: 2px; cursor: pointer; font-weight: bold; font-family: 'Share Tech Mono', monospace; width: 100%; font-size: 0.8rem; margin-bottom: 6px; transition: background 0.2s; }
        button:hover { background: #0369a1; }

        pre { background: #020408; color: #34d399; padding: 10px; border-radius: 2px; border: 1px solid #1e293b; overflow-y: auto; white-space: pre-wrap; font-size: 0.75rem; height: 160px; }
        .stats-row { display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 6px; border-bottom: 1px dotted #1e293b; padding-bottom: 3px; }
        .stats-val { color: #facc15; }

        textarea.ide-editor { height: 160px; color: #34d399; resize: vertical; }

        .history-box, .exo-box, .book-box { background: #020408; border: 1px solid #1e293b; padding: 8px; margin-top: 8px; max-height: 140px; overflow-y: auto; font-size: 0.75rem; }
        .history-item { display: flex; justify-content: space-between; align-items: center; border-bottom: 1px dashed #1e293b; padding: 4px 0; }
        .history-item button { width: auto; padding: 2px 6px; font-size: 0.65rem; margin-bottom: 0; background: #0d9488; }

        .radar-container {
            width: 180px; height: 180px; margin: 10px auto; border-radius: 50%;
            border: 2px solid #0284c7; position: relative; background: radial-gradient(circle, rgba(2,132,199,0.1) 0%, rgba(1,3,7,0.9) 80%);
            box-shadow: 0 0 15px rgba(2, 132, 199, 0.4); overflow: hidden;
        }
        .radar-line {
            width: 50%; height: 50%; background: linear-gradient(45deg, rgba(56,189,248,0.6) 0%, transparent 100%);
            position: absolute; top: 0; left: 0; transform-origin: bottom right;
            animation: radarSweep 2s linear infinite; border-radius: 100% 0 0 0;
        }
        .radar-grid {
            position: absolute; width: 100%; height: 100%; top: 0; left: 0;
            border-radius: 50%; border: 1px dashed rgba(2, 132, 199, 0.3);
        }
        @keyframes radarSweep {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>

    <div id="authOverlay">
        <div class="auth-card">
            <h2>🛡️ ACCESS RESTRICTED</h2>
            <p>Podaj kod autoryzacji Architekta (PIN: <b>199407</b>)</p>
            <input type="password" id="pinInput" placeholder="••••••" maxlength="8">
            <button onclick="verifyPin()">ODBLOKUJ SYSTEM</button>
            <p id="authError" style="color: #ef4444; font-size: 0.7rem; margin-top: 6px; display: none;">Błędny kod autoryzacji! Wymagany PIN: 199407</p>
        </div>
    </div>

    <div id="mainApp">
        <canvas id="matrixCanvas"></canvas>
        <div id="flashLayer" class="overload-flash"></div>

        <header>
            <h1>🛡️ Sanctuary Portal v8.6 // Mekrix</h1>
            <div class="header-actions">
                <button class="matrix-btn" onclick="toggleMatrix()">🟢 MATRIX</button>
                <button class="overload-btn" onclick="triggerSystemOverload()">⚠️ CRASH</button>
            </div>
        </header>
        
        <div class="tabs">
            <button class="tab-btn active" onclick="switchTab(event, 'tab-shell')">💻 [01] Shell</button>
            <button class="tab-btn" onclick="switchTab(event, 'tab-book')">📖 [02] Księga AI</button>
            <button class="tab-btn" onclick="switchTab(event, 'tab-ide')">📝 [03] Web IDE & C++</button>
            <button class="tab-btn" onclick="switchTab(event, 'tab-exorixpo')">🌐 [04] Exorixpo Hub</button>
            <button class="tab-btn" onclick="switchTab(event, 'tab-system')">📊 [05] Monitor & Radar</button>
            <button class="tab-btn" onclick="switchTab(event, 'tab-vault')">🗄️ [06] Vault</button>
        </div>

        <div id="tab-shell" class="panel-card active">
            <h3>Interaktywna Konsola Systemowa</h3>
            <label>Komenda Linuxa:</label>
            <input type="text" id="sysCmd" value="ls -la">
            <button onclick="executeCmd('sysCmd', 'execLog')">WYŚLIJ ROZKAZ</button>
            <pre id="execLog">[SECURE INIT] Mekrix Sanctuary Portal v8.6 online...</pre>
        </div>

        <div id="tab-book" class="panel-card" style="border-left: 4px solid #ec4899;">
            <h3 style="color: #ec4899;">📖 Księga Architekta AI (Prompty & Dokumentacja)</h3>
            <label>Tytuł Notatki / Promptu:</label>
            <input type="text" id="bookTitle" placeholder="np. Koncepcja Syntezy C# i C++">
            <label>Treść Notatki / Architektura AI:</label>
            <textarea id="bookContent" class="ide-editor" placeholder="Wprowadź wytyczne dla silnika AI..."></textarea>
            <button onclick="addAiBook()" style="background: #be185d;">ZAPISZ NOTATKĘ W NOSQL</button>
            <label style="margin-top: 10px;">Zapisane Wpisy Księgi Architekta:</label>
            <div id="aiBookBox" class="book-box">Ładowanie wpisów...</div>
        </div>

        <div id="tab-ide" class="panel-card" style="border-left: 4px solid #38bdf8;">
            <h3 style="color: #38bdf8;">📝 Studio Kodowania + NoSQL Wersjonowanie</h3>
            <label>Wybierz plik z systemu:</label>
            <select id="ideFileSelect" onchange="loadIdeFile()">
                <option value="core.cpp">core.cpp (Natywne C++)</option>
                <option value="AiEngine.cs">AiEngine.cs (Zarządzany C#)</option>
                <option value="index.html">index.html (Interfejs HUD)</option>
                <option value="server.py">server.py (Backend Python)</option>
            </select>
            <textarea id="ideEditorContent" class="ide-editor" placeholder="Ładowanie kodu..."></textarea>
            
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 6px;">
                <button onclick="saveIdeFile()" style="background: #059669;">ZAPISZ (NOSQL)</button>
                <button onclick="compileCppModule()" style="background: #d97706;">KOMPILUJ C++ (.SO)</button>
            </div>
            <p id="ideStatus" style="font-size: 0.7rem; color: #34d399; margin-top: 4px;"></p>
            <pre id="cppCompileLog" style="margin-top: 6px; height: 90px;">[C++ BUILD LOG] Oczekiwanie...</pre>

            <label style="margin-top: 8px;">💾 Oś czasu NoSQL dla pliku:</label>
            <div id="nosqlHistoryBox" class="history-box">Brak wersji.</div>
        </div>

        <div id="tab-exorixpo" class="panel-card" style="border-left: 4px solid #a855f7;">
            <h3 style="color: #a855f7;">🌐 Exorixpo Hub (#WszystkoTwoje / #JestMoje)</h3>
            <label>Nazwa projektu:</label>
            <input type="text" id="exoTitle" placeholder="np. Portfel Mikrotransakcji">
            <label>Hashtag systemowy:</label>
            <select id="exoTag">
                <option value="#WszystkoTwoje">#WszystkoTwoje</option>
                <option value="#JestMoje">#JestMoje</option>
            </select>
            <button onclick="addExorixpoProject()" style="background: #7e22ce;">DODAJ PROJEKT</button>
            <label style="margin-top: 8px;">Rejestr Projektów:</label>
            <div id="exoProjectsBox" class="exo-box">Ładowanie...</div>
        </div>

        <div id="tab-system" class="panel-card" style="border-left: 4px solid #34d399;">
            <h3 style="color: #34d399;">📊 Telemetria & Skaner Taktyczny Radaru</h3>
            
            <div class="radar-container">
                <div class="radar-grid"></div>
                <div class="radar-line"></div>
            </div>

            <button onclick="fetchStats()">ODŚWIEŻ TELEMETRIĘ</button>
            <div class="stats-row" style="margin-top: 8px;"><span>Procesor:</span> <span class="stats-val" id="statArch">...</span></div>
            <div class="stats-row"><span>Uptime:</span> <span class="stats-val" id="statUptime">...</span></div>
            <div class="stats-row"><span>Pliki w NoSQL:</span> <span class="stats-val" id="statNosql">...</span></div>
            <div class="stats-row"><span>Wpisy Księgi AI:</span> <span class="stats-val" id="statBooks">...</span></div>
            <div class="stats-row"><span>Projekty Exorixpo:</span> <span class="stats-val" id="statExo">...</span></div>
            <div class="stats-row"><span>Dysk (/data):</span> <span class="stats-val" id="statDisk">...</span></div>
            <div class="stats-row"><span>Pamięć RAM:</span> <span class="stats-val" id="statMem">...</span></div>
        </div>

        <div id="tab-vault" class="panel-card" style="border-left: 4px solid #2dd4bf;">
            <h3 style="color: #2dd4bf;">🗄️ Vault (Szyfrowany Dziennik Zdarzeń)</h3>
            <button onclick="fetchVault()">ODŚWIEŻ HISTORIĘ</button>
            <pre id="vaultViewer" style="margin-top: 8px;">Ładowanie archiwum...</pre>
        </div>
    </div>

    <script>
        let audioCtx = null;

        function verifyPin() {
            const pin = document.getElementById('pinInput').value.trim();
            const error = document.getElementById('authError');
            if (pin === '199407') {
                document.getElementById('authOverlay').style.display = 'none';
                document.getElementById('mainApp').style.display = 'block';
                try { audioCtx = new (window.AudioContext || window.webkitAudioContext)(); } catch(e) {}
                fetchStats();
                fetchVault();
                loadIdeFile();
                loadExorixpoProjects();
                loadAiBooks();
            } else {
                error.style.display = 'block';
            }
        }

        document.getElementById('pinInput').addEventListener('keypress', function (e) {
            if (e.key === 'Enter') verifyPin();
        });

        function triggerSystemOverload() {
            const body = document.body;
            const flash = document.getElementById('flashLayer');
            body.classList.add('shake-active');
            flash.style.display = 'block';

            try {
                if(!audioCtx) audioCtx = new (window.AudioContext || window.webkitAudioContext)();
                if(audioCtx.state === 'suspended') audioCtx.resume();
                const osc = audioCtx.createOscillator();
                const gain = audioCtx.createGain();
                osc.type = 'sawtooth';
                osc.frequency.setValueAtTime(200, audioCtx.currentTime);
                osc.frequency.exponentialRampToValueAtTime(1200, audioCtx.currentTime + 0.2);
                osc.frequency.exponentialRampToValueAtTime(80, audioCtx.currentTime + 0.6);
                gain.gain.setValueAtTime(0.4, audioCtx.currentTime);
                gain.gain.exponentialRampToValueAtTime(0.01, audioCtx.currentTime + 1.8);
                osc.connect(gain);
                gain.connect(audioCtx.destination);
                osc.start();
                osc.stop(audioCtx.currentTime + 1.8);
            } catch(e) {}

            setTimeout(() => {
                body.classList.remove('shake-active');
                flash.style.display = 'none';
            }, 2500);
        }

        async function loadIdeFile() {
            const filename = document.getElementById('ideFileSelect').value;
            const editor = document.getElementById('ideEditorContent');
            const status = document.getElementById('ideStatus');
            try {
                const res = await fetch(`/api/file/read?file=${filename}`);
                const data = await res.json();
                editor.value = data.content;
                status.textContent = `Załadowano: ${data.filename}`;
                loadNoSqlHistory(filename);
            } catch(e) { editor.value = "Błąd."; }
        }

        async function saveIdeFile() {
            const filename = document.getElementById('ideFileSelect').value;
            const content = document.getElementById('ideEditorContent').value;
            const status = document.getElementById('ideStatus');
            try {
                const res = await fetch('/api/file/save', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ filename: filename, content: content })
                });
                const data = await res.json();
                status.textContent = `Zapisano w NoSQL: ${data.status}`;
                loadNoSqlHistory(filename);
            } catch(e) { status.textContent = `Błąd: ${e.message}`; }
        }

        async function compileCppModule() {
            const log = document.getElementById('cppCompileLog');
            log.textContent += "\n[BUILD] Kompilacja C++ -> libcore.so...";
            try {
                const res = await fetch('/api/cpp/compile', { method: 'POST' });
                const data = await res.json();
                log.textContent += `\nStatus: ${data.status}\n${data.output}\n---`;
            } catch(e) { log.textContent += `\n[BŁĄD]: ${e.message}`; }
            log.scrollTop = log.scrollHeight;
        }

        async function loadNoSqlHistory(filename) {
            const box = document.getElementById('nosqlHistoryBox');
            try {
                const res = await fetch(`/api/nosql/history?file=${filename}`);
                const data = await res.json();
                if(data.history && data.history.length > 0) {
                    box.innerHTML = data.history.slice().reverse().map(v => `
                        <div class="history-item">
                            <span><b>v${v.v_id}</b> | ${v.timestamp} | ${v.bytes}B</span>
                            <button onclick="restoreNoSqlVersion('${filename}', ${v.v_id})">PRZYWRÓĆ</button>
                        </div>
                    `).join('');
                } else { box.innerHTML = "Brak zarejestrowanych wersji w NoSQL."; }
            } catch(e) { box.innerHTML = "Błąd historii."; }
        }

        async function restoreNoSqlVersion(filename, v_id) {
            try {
                const res = await fetch('/api/nosql/restore', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ filename: filename, v_id: v_id })
                });
                const data = await res.json();
                alert(`Status: ${data.status}`);
                loadIdeFile();
            } catch(e) { alert(`Błąd: ${e.message}`); }
        }

        async function loadAiBooks() {
            const box = document.getElementById('aiBookBox');
            try {
                const res = await fetch('/api/books/list');
                const data = await res.json();
                if(data.books && data.books.length > 0) {
                    box.innerHTML = data.books.map(b => `
                        <div style="border-bottom: 1px dashed #1e293b; padding: 6px 0;">
                            <b style="color:#ec4899;">[#${b.id}] ${b.title}</b>
                            <p style="color:#94a3b8; font-size:0.7rem; margin-top:2px;">${b.content}</p>
                        </div>
                    `).join('');
                } else { box.innerHTML = "Brak wpisów."; }
            } catch(e) { box.innerHTML = "Błąd ładowania Księgi."; }
        }

        async function addAiBook() {
            const title = document.getElementById('bookTitle').value.trim();
            const content = document.getElementById('bookContent').value.trim();
            if(!title || !content) { alert("Wypełnij tytuł i treść notatki!"); return; }
            try {
                const res = await fetch('/api/books/add', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ title: title, content: content })
                });
                const data = await res.json();
                if(data.status === 'added') {
                    document.getElementById('bookTitle').value = '';
                    document.getElementById('bookContent').value = '';
                    loadAiBooks();
                    alert("Zapisano w Księdze Architekta!");
                }
            } catch(e) { alert(`Błąd: ${e.message}`); }
        }

        async function loadExorixpoProjects() {
            const box = document.getElementById('exoProjectsBox');
            try {
                const res = await fetch('/api/exorixpo/list');
                const data = await res.json();
                if(data.projects && data.projects.length > 0) {
                    box.innerHTML = data.projects.map(p => `
                        <div style="border-bottom: 1px dashed #1e293b; padding: 4px 0;">
                            <b>[#${p.id}] ${p.title}</b> <span style="color:#facc15">${p.tag}</span> (${p.status})
                        </div>
                    `).join('');
                } else { box.innerHTML = "Brak projektów."; }
            } catch(e) { box.innerHTML = "Błąd Exorixpo."; }
        }

        async function addExorixpoProject() {
            const title = document.getElementById('exoTitle').value.trim();
            const tag = document.getElementById('exoTag').value;
            if(!title) { alert("Wpisz nazwę!"); return; }
            try {
                const res = await fetch('/api/exorixpo/add', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ title: title, tag: tag })
                });
                const data = await res.json();
                if(data.status === 'added') {
                    document.getElementById('exoTitle').value = '';
                    loadExorixpoProjects();
                    alert("Dodano projekt!");
                }
            } catch(e) { alert(`Błąd: ${e.message}`); }
        }

        const canvas = document.getElementById('matrixCanvas');
        const ctx = canvas.getContext('2d');
        let matrixInterval = null;

        function initMatrix() {
            canvas.width = window.innerWidth;
            canvas.height = window.innerHeight;
            const katakana = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
            const fontSize = 16;
            const columns = canvas.width / fontSize;
            const rainDrops = Array.from({ length: columns }).fill(1);

            function draw() {
                ctx.fillStyle = 'rgba(0, 0, 0, 0.05)';
                ctx.fillRect(0, 0, canvas.width, canvas.height);
                ctx.fillStyle = '#0F0';
                ctx.font = fontSize + 'px monospace';
                for (let i = 0; i < rainDrops.length; i++) {
                    const text = katakana.charAt(Math.floor(Math.random() * katakana.length));
                    ctx.fillText(text, i * fontSize, rainDrops[i] * fontSize);
                    if (rainDrops[i] * fontSize > canvas.height && Math.random() > 0.975) { rainDrops[i] = 0; }
                    rainDrops[i]++;
                }
            }
            if(matrixInterval) clearInterval(matrixInterval);
            matrixInterval = setInterval(draw, 30);
        }

        function toggleMatrix() {
            if (canvas.style.display === 'block') {
                canvas.style.display = 'none';
                if(matrixInterval) clearInterval(matrixInterval);
            } else {
                canvas.style.display = 'block';
                initMatrix();
            }
        }

        function switchTab(evt, tabId) {
            document.querySelectorAll('.panel-card').forEach(c => c.classList.remove('active'));
            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
            document.getElementById(tabId).classList.add('active');
            evt.currentTarget.classList.add('active');
            if(tabId === 'tab-vault') fetchVault();
            if(tabId === 'tab-system') fetchStats();
            if(tabId === 'tab-exorixpo') loadExorixpoProjects();
            if(tabId === 'tab-book') loadAiBooks();
        }

        async function executeCmd(inputId, logId) {
            const cmd = document.getElementById(inputId).value.trim();
            const log = document.getElementById(logId);
            log.textContent += `\n$ ${cmd}\nPrzetwarzanie...`;
            try {
                const res = await fetch('/api/exec', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ cmd: cmd })
                });
                const data = await res.json();
                log.textContent += `\n${data.output}\n---`;
            } catch (err) { log.textContent += `\n[BŁĄD]: ${err.message}`; }
            log.scrollTop = log.scrollHeight;
        }

        async function fetchStats() {
            try {
                const res = await fetch('/api/stats');
                const data = await res.json();
                document.getElementById('statArch').textContent = data.arch;
                document.getElementById('statUptime').textContent = data.uptime;
                document.getElementById('statNosql').textContent = `${data.nosql_files} plików`;
                document.getElementById('statBooks').textContent = `${data.ai_books} notatek`;
                document.getElementById('statExo').textContent = `${data.exorixpo_projects} projektów`;
                document.getElementById('statDisk').textContent = data.disk;
                document.getElementById('statMem').textContent = data.mem;
            } catch(err) { console.error(err); }
        }

        async function fetchVault() {
            try {
                const res = await fetch('/api/vault/read');
                const data = await res.json();
                document.getElementById('vaultViewer').textContent = data.logs;
            } catch(err) { console.error(err); }
        }
    </script>
</body>
</html>
HTMLEOF

pkill -f python
sleep 1
python server.py &
sleep 1
termux-open-url http://localhost:8080
git init
git config --global user.name "Mekrix"
git config --global user.email "mekrix@sanctuary.local"
git add server.py index.html
git commit -m "Initial Sanctuary OS v8.6 setup by Mekrix #WszystkoTwoje"
git remote add origin https://github.com/TWOJA_NAZWA_UZYTKOWNIKA/Sanctuary-Portal.git
git branch -M main
git push -u origin main
git branch -M main
git push -u origin maingit remote add origin https://github.com/Mekrix777/Sanctuary-Portal.git
git branch -M main
git push -u origin main
git branch -M main
git push -u origin main
git remote set-url origin https://github.com/Mekrix777/Sanctuary-Portal.git
git config --system --unset credential.helper 2>/dev/null || true
git push -u origin main
