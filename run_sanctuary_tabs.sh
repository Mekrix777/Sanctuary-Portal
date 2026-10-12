#!/bin/bash
cat << 'HTMLEOF' > index.html
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mr.Mekrix | Sanctuary Core v4.0 (Tabs)</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background-color: #030508; color: #e2e8f0; font-family: monospace; padding: 12px; max-width: 900px; margin: auto; }
        header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #1e293b; padding-bottom: 10px; margin-bottom: 12px; }
        h1 { color: #38bdf8; font-size: 1.1rem; text-shadow: 0 0 10px rgba(56,189,248,0.3); }
        .badge { background: #065f46; color: #34d399; padding: 4px 8px; border-radius: 4px; font-size: 0.75rem; border: 1px solid #10b981; }
        .tabs { display: flex; gap: 6px; margin-bottom: 15px; overflow-x: auto; padding-bottom: 4px; }
        .tab-btn { background: #0b0f19; color: #94a3b8; border: 1px solid #1e293b; padding: 8px 14px; border-radius: 4px; cursor: pointer; font-family: monospace; font-size: 0.75rem; white-space: nowrap; transition: all 0.2s ease; }
        .tab-btn:hover { color: #38bdf8; border-color: #334155; }
        .tab-btn.active { background: #0f172a; color: #38bdf8; border-color: #38bdf8; box-shadow: inset 0 0 8px rgba(56,189,248,0.2); }
        .panel-card { display: none; background: #0b0f19; border: 1px solid #1e293b; border-radius: 8px; padding: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.5); position: relative; }
        .panel-card.active { display: block; }
        .panel-card::before { content: ''; position: absolute; top: 0; left: 0; width: 4px; height: 100%; background: #38bdf8; border-radius: 4px 0 0 4px; }
        h3 { color: #93c5fd; font-size: 0.9rem; margin-bottom: 12px; border-bottom: 1px dashed #1e293b; padding-bottom: 6px; }
        label { font-size: 0.8rem; color: #94a3b8; display: block; margin-bottom: 5px; }
        input, textarea { width: 100%; background: #020408; color: #38bdf8; border: 1px solid #334155; border-radius: 4px; padding: 8px; font-family: monospace; font-size: 0.8rem; outline: none; margin-bottom: 10px; }
        button { background: #2563eb; color: #ffffff; border: none; padding: 10px; border-radius: 4px; cursor: pointer; font-weight: bold; font-family: monospace; width: 100%; font-size: 0.8rem; margin-bottom: 8px; }
        button:hover { opacity: 0.9; }
        button.secondary { background: #334155; }
        button.special { background: #7c3aed; }
        pre { background: #020408; color: #34d399; padding: 10px; border-radius: 4px; border: 1px solid #334155; overflow-y: auto; white-space: pre-wrap; font-size: 0.75rem; height: 200px; }
        .stats-row { display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 8px; border-bottom: 1px dotted #1e293b; padding-bottom: 4px; }
        .stats-val { color: #facc15; }
        .time { color: #64748b; }
    </style>
</head>
<body>
    <header>
        <h1>🛡️ Mega Poland Wetr'vi</h1>
        <div class="badge">Mr.Mekrix Sanctuary v4.0</div>
    </header>
    <div class="tabs">
        <button class="tab-btn active" onclick="switchTab(event, 'tab-console')">⚙️ Konsola</button>
        <button class="tab-btn" onclick="switchTab(event, 'tab-telemetry')">📊 Telemetria</button>
        <button class="tab-btn" onclick="switchTab(event, 'tab-threads')">🧵 Wątki</button>
        <button class="tab-btn" onclick="switchTab(event, 'tab-exorpero')">⚛️ Exorpero</button>
        <button class="tab-btn" onclick="switchTab(event, 'tab-vault')">🗄️ Vault</button>
    </div>
    <div id="tab-console" class="panel-card active">
        <h3>Konsola Główna Rozkazów</h3>
        <label>Pakiet / Payload:</label>
        <textarea id="consoleInp" rows="3">{"modul": "Sanctuary Core", "status": "Aktywny"}</textarea>
        <button onclick="sendConsoleCmd()">WYŚLIJ ROZKAZ DO RDZENIA</button>
        <pre id="consoleLog"><span class="time">[INIT]</span> Konsola gotowa do nadawania...</pre>
    </div>
    <div id="tab-telemetry" class="panel-card">
        <h3>Telemetria i Związki Systemowe</h3>
        <div class="stats-row"><span>Architekt:</span> <span class="stats-val">Mr.Mekrix</span></div>
        <div class="stats-row"><span>Przepustowość magistrali:</span> <span class="stats-val">100% (Optymalna)</span></div>
        <div class="stats-row"><span>Średni czas reakcji:</span> <span class="stats-val">0.4 ms</span></div>
        <div class="stats-row"><span>Stan portu:</span> <span style="color: #34d399;">ZSYNCHRONIZOWANY</span></div>
    </div>
    <div id="tab-threads" class="panel-card">
        <h3>Symulator Kolejki Wątków (Background Workers)</h3>
        <button onclick="toggleThreads()" id="threadBtn" class="secondary">URUCHOM KOLEJKĘ WĄTKÓW</button>
        <pre id="threadLog"><span class="time">[INIT]</span> Kolejka oczekuje na start...</pre>
    </div>
    <div id="tab-exorpero" class="panel-card" style="border-left-color: #c084fc;">
        <h3 style="color: #c084fc;">Koniunktura Bezdystrybucyjna (Exorpero + Rixim)</h3>
        <button onclick="triggerExorpero()" class="special">WYWOŁAJ IMPULS EXORPERO</button>
        <button onclick="triggerRixim()" style="background: #0d9488;">SYNCHRONIZACJA RIXIM (0-DIST)</button>
        <pre id="exorperoLog"><span class="time">[INIT]</span> Obwody bezdystrybucyjne w gotowości...</pre>
    </div>
    <div id="tab-vault" class="panel-card" style="border-left-color: #34d399;">
        <h3 style="color: #34d399;">Magazyn Danych Trwałych (Vault)</h3>
        <label>Zapisz w pamięci:</label>
        <input type="text" id="vaultText" value="Zbieżność systemowa #Mr.Mekrix">
        <button onclick="saveVault()" style="background: #059669;">ZAPISZ W VAULT</button>
        <pre id="vaultLog"><span class="time">[INIT]</span> Magazyn lokalny aktywny...</pre>
    </div>
    <script>
        function switchTab(evt, tabId) {
            document.querySelectorAll('.panel-card').forEach(c => c.classList.remove('active'));
            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
            document.getElementById(tabId).classList.add('active');
            evt.currentTarget.classList.add('active');
        }
        function sendConsoleCmd() {
            const log = document.getElementById('consoleLog');
            const time = new Date().toLocaleTimeString();
            log.innerHTML += `\n<span class="time">[${time}]</span> [ACK] Rozkaz przetworzony pomyślnie.`;
            log.scrollTop = log.scrollHeight;
        }
        let tInterval = null;
        function toggleThreads() {
            const btn = document.getElementById('threadBtn');
            const log = document.getElementById('threadLog');
            if(tInterval) {
                clearInterval(tInterval);
                tInterval = null;
                btn.textContent = "URUCHOM KOLEJKĘ WĄTKÓW";
                btn.className = "secondary";
                log.innerHTML += `\n<span class="time">[${new Date().toLocaleTimeString()}]</span> [STOP] Kolejka zatrzymana.`;
            } else {
                btn.textContent = "ZATRZYMAJ KOLEJKĘ";
                btn.className = "";
                log.innerHTML += `\n<span class="time">[${new Date().toLocaleTimeString()}]</span> [START] Kolejka aktywna.`;
                tInterval = setInterval(() => {
                    const time = new Date().toLocaleTimeString();
                    const wId = Math.floor(Math.random() * 3) + 1;
                    log.innerHTML += `\n<span class="time">[${time}]</span> [W_${wId}] Pakiet zbuforowany pomyślnie.`;
                    log.scrollTop = log.scrollHeight;
                }, 1500);
            }
        }
        function triggerExorpero() {
            const log = document.getElementById('exorperoLog');
            const time = new Date().toLocaleTimeString();
            log.innerHTML += `\n<span class="time">[${time}]</span> [EXORPERO] Impuls 99.95% bez dystrybucji.`;
            log.scrollTop = log.scrollHeight;
        }
        function triggerRixim() {
            const log = document.getElementById('exorperoLog');
            const time = new Date().toLocaleTimeString();
            log.innerHTML += `\n<span class="time">[${time}]</span> [RIXIM] Zamknięcie obwodu 0.0ms.`;
            log.scrollTop = log.scrollHeight;
        }
        function saveVault() {
            const log = document.getElementById('vaultLog');
            const val = document.getElementById('vaultText').value;
            const time = new Date().toLocaleTimeString();
            log.innerHTML += `\n<span class="time">[${time}]</span> [VAULT] Zapisano: "${val}"`;
            log.scrollTop = log.scrollHeight;
        }
    </script>
</body>
</html>
HTMLEOF
termux-open index.html
