#!/bin/bash

cat << 'HTMLEOF' > index.html
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mr.Mekrix | Integrated Core Puzzle</title>
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
        input, textarea { 
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
        
        button { 
            background: #2563eb; 
            color: #ffffff; 
            border: none; 
            padding: 10px; 
            border-radius: 4px; 
            cursor: pointer; 
            font-weight: bold; 
            font-family: monospace;
            width: 100%;
            font-size: 0.8rem;
        }
        button:hover { opacity: 0.9; }
        
        .chart-box {
            display: flex;
            align-items: flex-end;
            gap: 6px;
            height: 100px;
            background: #020408;
            border: 1px solid #334155;
            padding: 8px;
            border-radius: 4px;
            margin-top: 10px;
        }
        .bar {
            flex: 1;
            background: #38bdf8;
            border-top: 2px solid #60a5fa;
            border-radius: 2px 2px 0 0;
            transition: height 0.3s ease;
            min-height: 4px;
        }

        pre { 
            background: #020408; 
            color: #34d399; 
            padding: 10px; 
            border-radius: 4px; 
            border: 1px solid #334155; 
            overflow-y: auto; 
            white-space: pre-wrap; 
            font-size: 0.75rem;
            height: 180px;
        }
        
        .stats-row { display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 6px; }
        .stats-val { color: #facc15; }
        .time { color: #64748b; }
    </style>
</head>
<body>
    <header>
        <h1>🛡️ Mega Poland Wetr'vi</h1>
        <div class="badge">Mr.Mekrix Core Puzzle Active</div>
    </header>
    
    <div class="grid">
        <!-- Filar 3 + 1: Weryfikacja i Konsola -->
        <div class="card">
            <h3>🔑 [Filar 3 & 1] Weryfikacja & Rozkaz C#</h3>
            <label>Token Architekta:</label>
            <input type="password" id="authToken" value="MEKRIX_KEY_2026">
            
            <label>Payload JSON do Rdzenia C++:</label>
            <textarea id="inp" rows="3">{"rozkaz": "Analiza szyny danych", "klasa": "C++ Native"}</textarea>
            
            <button id="btn">PODPIŚ I WYKONAJ ROZPORZĄDZENIE</button>
        </div>

        <!-- Filar 2: Telemetria i Wykres Live -->
        <div class="card">
            <h3>📊 [Filar 2] Wykres Opóźnień (Live MS)</h3>
            <div class="stats-row"><span>Status Tokena:</span> <span id="authStatus" class="stats-val">ZAWERYFIKOWANY</span></div>
            <div class="stats-row"><span>Średnie opóźnienie:</span> <span id="avgLatency" class="stats-val">0 ms</span></div>
            
            <div class="chart-box" id="chart">
                <div class="bar" style="height: 10%;"></div>
                <div class="bar" style="height: 20%;"></div>
                <div class="bar" style="height: 15%;"></div>
                <div class="bar" style="height: 40%;"></div>
                <div class="bar" style="height: 25%;"></div>
            </div>
        </div>

        <!-- Zintegrowany Rejestr Zdarzeń -->
        <div class="card full">
            <h3>📜 Pełna Układanka Systemowa (Log & Response)</h3>
            <pre id="out"><span class="time">[INIT]</span> Układanka 3 filarów zainicjowana. Oczekiwanie na rozkaz...</pre>
        </div>
    </div>

    <script>
        const btn = document.getElementById('btn');
        const out = document.getElementById('out');
        const authToken = document.getElementById('authToken');
        const authStatus = document.getElementById('authStatus');
        const avgLatency = document.getElementById('avgLatency');
        const chart = document.getElementById('chart');
        const inp = document.getElementById('inp');

        let times = [];

        btn.addEventListener('click', () => {
            if(!authToken.value) {
                authStatus.textContent = "BRAK TOKENA!";
                authStatus.style.color = "#f87171";
                return;
            }

            authStatus.textContent = "PODPISYWANIE...";
            authStatus.style.color = "#fbbf24";

            const t0 = performance.now();

            setTimeout(() => {
                const latency = Math.floor(Math.random() * 80) + 120; // Reakcja szyny
                times.push(latency);
                if(times.length > 8) times.shift();

                // 1. Aktualizacja Wykresu
                chart.innerHTML = '';
                let total = 0;
                times.forEach(t => {
                    total += t;
                    const bar = document.createElement('div');
                    bar.className = 'bar';
                    bar.style.height = (t / 2) + '%';
                    chart.appendChild(bar);
                });

                avgLatency.textContent = (total / times.length).toFixed(1) + " ms";
                authStatus.textContent = "ZAAKCEPTOWANY";
                authStatus.style.color = "#34d399";

                // 2. Rejestracja Odpowiedzi
                const res = {
                    filar1_bridge: "C# / C++ Executed",
                    filar2_telemetry: latency + " ms",
                    filar3_auth: "PASSED (" + authToken.value.slice(0, 6) + "***)",
                    payload: inp.value,
                    timestamp: new Date().toLocaleTimeString()
                };

                out.innerHTML += `\n<span class="time">[${res.timestamp}]</span> [PUZZLE OK] ${JSON.stringify(res)}`;
                out.scrollTop = out.scrollHeight;
            }, 200);
        });
    </script>
</body>
</html>
HTMLEOF

termux-open index.html
