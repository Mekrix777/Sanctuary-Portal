#!/bin/bash

cat << 'HTMLEOF' > index.html
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mr.Mekrix | Sanctuary Core v3.0</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { 
            background-color: #030508; 
            color: #e2e8f0; 
            font-family: monospace; 
            padding: 12px; 
            max-width: 900px; 
            margin: auto; 
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #1e293b;
            padding-bottom: 10px;
            margin-bottom: 15px;
        }
        h1 { color: #38bdf8; font-size: 1.1rem; }
        .badge { background: #065f46; color: #34d399; padding: 4px 8px; border-radius: 4px; font-size: 0.75rem; }
        
        .grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 15px;
        }
        @media(min-width: 600px) {
            .grid { grid-template-columns: 1fr 1fr; }
        }
        
        .card { 
            background: #0b0f19; 
            border: 1px solid #1e293b; 
            border-radius: 8px; 
            padding: 14px; 
        }
        .card.full { grid-column: 1 / -1; }
        
        h3 { color: #93c5fd; font-size: 0.9rem; margin-bottom: 10px; border-bottom: 1px dashed #1e293b; padding-bottom: 5px; }
        
        label { font-size: 0.8rem; color: #94a3b8; display: block; margin-bottom: 5px; }
        textarea { 
            width: 100%; 
            background: #020408; 
            color: #38bdf8; 
            border: 1px solid #334155; 
            border-radius: 4px; 
            padding: 8px; 
            font-family: monospace; 
            font-size: 0.8rem;
            outline: none;
            margin-bottom: 10px;
        }
        
        .btn-group { display: flex; gap: 8px; }
        button { 
            background: #2563eb; 
            color: #ffffff; 
            border: none; 
            padding: 10px; 
            border-radius: 4px; 
            cursor: pointer; 
            font-weight: bold; 
            font-family: monospace;
            flex: 1;
            font-size: 0.8rem;
        }
        button.clear { background: #334155; }
        button:hover { opacity: 0.9; }
        
        pre { 
            background: #020408; 
            color: #34d399; 
            padding: 10px; 
            border-radius: 4px; 
            border: 1px solid #334155; 
            overflow-y: auto; 
            white-space: pre-wrap; 
            font-size: 0.75rem;
            height: 260px;
        }
        
        .stats-row { display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 6px; }
        .stats-val { color: #facc15; }
        .log-entry { margin-bottom: 6px; border-bottom: 1px dotted #1e293b; padding-bottom: 4px; }
        .time { color: #64748b; }
    </style>
</head>
<body>
    <header>
        <h1>🛡️ Mega Poland Wetr'vi</h1>
        <div class="badge">Mr.Mekrix Core Active</div>
    </header>
    
    <div class="grid">
        <!-- Panel 1: Nadawanie komunikatów -->
        <div class="card">
            <h3>⚙️ Konsola Nadawcza</h3>
            <label>Pakiet JSON / Rozkaz:</label>
            <textarea id="inp" rows="4">{"

cat << 'EOF' > run_sanctuary_v3.sh
#!/bin/bash

cat << 'HTMLEOF' > index.html
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mr.Mekrix | Sanctuary Core v3.0</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { 
            background-color: #030508; 
            color: #e2e8f0; 
            font-family: monospace; 
            padding: 12px; 
            max-width: 900px; 
            margin: auto; 
        }
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #1e293b;
            padding-bottom: 10px;
            margin-bottom: 15px;
        }
        h1 { color: #38bdf8; font-size: 1.1rem; }
        .badge { background: #065f46; color: #34d399; padding: 4px 8px; border-radius: 4px; font-size: 0.75rem; }
        
        .grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 15px;
        }
        @media(min-width: 600px) {
            .grid { grid-template-columns: 1fr 1fr; }
        }
        
        .card { 
            background: #0b0f19; 
            border: 1px solid #1e293b; 
            border-radius: 8px; 
            padding: 14px; 
        }
        .card.full { grid-column: 1 / -1; }
        
        h3 { color: #93c5fd; font-size: 0.9rem; margin-bottom: 10px; border-bottom: 1px dashed #1e293b; padding-bottom: 5px; }
        
        label { font-size: 0.8rem; color: #94a3b8; display: block; margin-bottom: 5px; }
        textarea { 
            width: 100%; 
            background: #020408; 
            color: #38bdf8; 
            border: 1px solid #334155; 
            border-radius: 4px; 
            padding: 8px; 
            font-family: monospace; 
            font-size: 0.8rem;
            outline: none;
            margin-bottom: 10px;
        }
        
        .btn-group { display: flex; gap: 8px; }
        button { 
            background: #2563eb; 
            color: #ffffff; 
            border: none; 
            padding: 10px; 
            border-radius: 4px; 
            cursor: pointer; 
            font-weight: bold; 
            font-family: monospace;
            flex: 1;
            font-size: 0.8rem;
        }
        button.clear { background: #334155; }
        button:hover { opacity: 0.9; }
        
        pre { 
            background: #020408; 
            color: #34d399; 
            padding: 10px; 
            border-radius: 4px; 
            border: 1px solid #334155; 
            overflow-y: auto; 
            white-space: pre-wrap; 
            font-size: 0.75rem;
            height: 260px;
        }
        
        .stats-row { display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 6px; }
        .stats-val { color: #facc15; }
        .log-entry { margin-bottom: 6px; border-bottom: 1px dotted #1e293b; padding-bottom: 4px; }
        .time { color: #64748b; }
    </style>
</head>
<body>
    <header>
        <h1>🛡️ Mega Poland Wetr'vi</h1>
        <div class="badge">Mr.Mekrix Core Active</div>
    </header>
    
    <div class="grid">
        <div class="card">
            <h3>⚙️ Konsola Nadawcza</h3>
            <label>Pakiet JSON / Rozkaz:</label>
            <textarea id="inp" rows="4">{"rozkaz": "Rejestracja nowej zdarzeniowej pętli", "priorytet": 1}</textarea>
            <div class="btn-group">
                <button id="btn">WYŚLIJ ROZKAZ</button>
                <button id="btnClear" class="clear">CZYŚĆ REJESTR</button>
            </div>
        </div>

        <div class="card">
            <h3>📊 Telemetria i Statystyki</h3>
            <div class="stats-row"><span>Architekt:</span> <span class="stats-val">Mr.Mekrix</span></div>
            <div class="stats-row"><span>Przetworzone pakiety:</span> <span id="pktCount" class="stats-val">0</span></div>
            <div class="stats-row"><span>Czas ostatniego wykonania:</span> <span id="execTime" class="stats-val">0 ms</span></div>
            <div class="stats-row"><span>Status magistrali:</span> <span id="statusText" style="color: #34d399;">NASŁUCHIWANIE</span></div>
        </div>

        <div class="card full">
            <h3>📜 Rejestr Zdarzeń i Dziennik Logów (System Log)</h3>
            <pre id="out"><span class="time">[INIT]</span> System uruchomiony. Rejestr gotowy do zapisu...</pre>
        </div>
    </div>

    <script>
        const btn = document.getElementById('btn');
        const btnClear = document.getElementById('btnClear');
        const out = document.getElementById('out');
        const statusText = document.getElementById('statusText');
        const inp = document.getElementById('inp');
        const pktCount = document.getElementById('pktCount');
        const execTime = document.getElementById('execTime');

        let count = 0;

        function addLog(msg, type="INFO") {
            const time = new Date().toLocaleTimeString();
            const logLine = `\n<div class="log-entry"><span class="time">[${time}] [${type}]</span> ${msg}</div>`;
            out.innerHTML += logLine;
            out.scrollTop = out.scrollHeight;
        }

        btn.addEventListener('click', () => {
            const startTime = performance.now();
            statusText.textContent = "PRZETWARZANIE...";
            statusText.style.color = "#fbbf24";

            addLog("Wysyłanie pakietu danych do magistrali natywnej...", "BUS");

            setTimeout(() => {
                count++;
                const duration = (performance.now() - startTime).toFixed(1);
                
                pktCount.textContent = count;
                execTime.textContent = duration + " ms";

                const res = {
                    status: "REGISTERED",
                    id: "LOG_" + Math.floor(1000 + Math.random() * 9000),
                    payload: inp.value,
                    owner: "Mr.Mekrix"
                };

                addLog("Odpowiedź rdzenia: " + JSON.stringify(res), "SUCCESS");
                statusText.textContent = "NASŁUCHIWANIE";
                statusText.style.color = "#34d399";
            }, 250);
        });

        btnClear.addEventListener('click', () => {
            out.innerHTML = `<span class="time">[CLEARED]</span> Rejestr zresetowany. Widok wyczyszczony.`;
        });
    </script>
</body>
</html>
HTMLEOF

termux-open index.html
