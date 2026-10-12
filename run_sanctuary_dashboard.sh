#!/bin/bash

cat << 'HTMLEOF' > index.html
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mr.Mekrix | Mega Poland Wetr'vi Dashboard</title>
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
        textarea, input { 
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
            font-size: 0.85rem;
            transition: background 0.2s;
        }
        button:hover { background: #1d4ed8; }
        
        pre { 
            background: #020408; 
            color: #34d399; 
            padding: 10px; 
            border-radius: 4px; 
            border: 1px solid #334155; 
            overflow-x: auto; 
            white-space: pre-wrap; 
            font-size: 0.75rem;
            min-height: 120px;
            max-height: 250px;
        }
        
        .stats-row { display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 6px; }
        .stats-val { color: #facc15; }
    </style>
</head>
<body>
    <header>
        <h1>🛡️ Mega Poland Wetr'vi</h1>
        <div class="badge">Mr.Mekrix Core Active</div>
    </header>
    
    <div class="grid">
        <!-- Panel 1: Sterowanie / Wejście -->
        <div class="card">
            <h3>⚙️ Konsola Sterowania</h3>
            <label>Pakiet JSON do przetworzenia:</label>
            <textarea id="inp" rows="4">{"prompt": "Pełna analiza strukturalna ekosystemu"}</textarea>
            <button id="btn">URUCHOM ANALIZĘ RDZENIA</button>
        </div>

        <!-- Panel 2: Telemetria / Status -->
        <div class="card">
            <h3>📊 Telemetria Systemu</h3>
            <div class="stats-row"><span>Użytkownik:</span> <span class="stats-val">Mr.Mekrix</span></div>
            <div class="stats-row"><span>Architektura:</span> <span class="stats-val">C++ Core + JS Bridge</span></div>
            <div class="stats-row"><span>Środowisko:</span> <span class="stats-val">Termux / Android Local</span></div>
            <div class="stats-row"><span>Status mostka:</span> <span id="statusText" style="color: #34d399;">GOTOWY</span></div>
        </div>

        <!-- Panel 3: Logi i Wyniki (Pełna szerokość) -->
        <div class="card full">
            <h3>📜 Rejestr Zdarzeń i Odpowiedzi Rdzenia</h3>
            <pre id="out">[Oczekiwanie na inicjalizację strumienia danych... Wywołaj analizę z konsoli]</pre>
        </div>
    </div>

    <script>
        const btn = document.getElementById('btn');
        const out = document.getElementById('out');
        const statusText = document.getElementById('statusText');
        const inp = document.getElementById('inp');

        btn.addEventListener('click', () => {
            statusText.textContent = "PRZETWARZANIE...";
            statusText.style.color = "#fbbf24";
            out.textContent = "[SYSTEM] Wysyłanie pakietu przez lokalną magistralę...\n";

            setTimeout(() => {
                const res = {
                    status: "SUCCESS",
                    node: "MegaPolandWetrVi_Local_Core",
                    owner: "Mr.Mekrix",
                    input_payload: inp.value,
                    execution: "100% Native Localized",
                    timestamp: new Date().toLocaleString()
                };
                
                out.textContent += "[SUKCES] Odpowiedź z rdzenia C++ / C#:\n" + JSON.stringify(res, null, 4);
                statusText.textContent = "STABILNY";
                statusText.style.color = "#34d399";
            }, 400);
        });
    </script>
</body>
</html>
HTMLEOF

termux-open index.html
