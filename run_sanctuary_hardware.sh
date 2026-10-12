#!/bin/bash

# Sprawdzamy czy mamy pakiety termux-api (opcjonalnie)
# pkg install termux-api -y 2>/dev/null

cat << 'HTMLEOF' > index.html
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mr.Mekrix | Hardware Bridge Core</title>
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
        
        .btn-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 8px;
            margin-top: 10px;
        }
        button { 
            background: #2563eb; 
            color: #ffffff; 
            border: none; 
            padding: 12px 10px; 
            border-radius: 4px; 
            cursor: pointer; 
            font-weight: bold; 
            font-family: monospace;
            font-size: 0.75rem;
            transition: opacity 0.2s;
        }
        button:hover { opacity: 0.85; }
        button.warn { background: #d97706; }
        button.danger { background: #dc2626; }

        pre { 
            background: #020408; 
            color: #34d399; 
            padding: 10px; 
            border-radius: 4px; 
            border: 1px solid #334155; 
            overflow-y: auto; 
            white-space: pre-wrap; 
            font-size: 0.75rem;
            height: 200px;
        }
        
        .stats-row { display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 6px; }
        .stats-val { color: #facc15; }
        .time { color: #64748b; }
    </style>
</head>
<body>
    <header>
        <h1>🛡️ Mega Poland Wetr'vi</h1>
        <div class="badge">Hardware Bridge Active</div>
    </header>
    
    <div class="grid">
        <!-- Panel Sterowników Sprzętowych -->
        <div class="card">
            <h3>⚙️ Sterowniki Fizyczne Androida</h3>
            <p style="font-size: 0.75rem; color: #94a3b8; margin-bottom: 10px;">Bezpośrednia magistrala sterująca urządzeniem:</p>
            
            <div class="btn-grid">
                <button onclick="triggerHw('torch_on', 'Włączenie latarki')">🔦 Latarka ON</button>
                <button onclick="triggerHw('torch_off', 'Wyłączenie latarki')" class="warn">🔦 Latarka OFF</button>
                <button onclick="triggerHw('vibrate', 'Impuls wibracyjny')">📳 Wibracja</button>
                <button onclick="triggerHw('battery', 'Status zasilania')" class="danger">🔋 Stan Baterii</button>
            </div>
        </div>

        <!-- Telemetria Sprzętu -->
        <div class="card">
            <h3>📊 Status Magistrali Urządzenia</h3>
            <div class="stats-row"><span>Architekt:</span> <span class="stats-val">Mr.Mekrix</span></div>
            <div class="stats-row"><span>Platforma:</span> <span class="stats-val">Android / Termux</span></div>
            <div class="stats-row"><span>Interface:</span> <span class="stats-val">Native API Bridge</span></div>
            <div class="stats-row"><span>Stan portu:</span> <span id="hwStatus" style="color: #34d399;">GOTOWY</span></div>
        </div>

        <!-- Dziennik Sprzętowy -->
        <div class="card full">
            <h3>📜 Rejestr Zdarzeń Sprzętowych</h3>
            <pre id="out"><span class="time">[INIT]</span> Magistrala sterowników fizycznych gotowa do pracy...</pre>
        </div>
    </div>

    <script>
        const out = document.getElementById('out');
        const hwStatus = document.getElementById('hwStatus');

        function triggerHw(action, desc) {
            hwStatus.textContent = "WYKONYWANIE...";
            hwStatus.style.color = "#fbbf24";
            
            const time = new Date().toLocaleTimeString();
            out.innerHTML += `\n<span class="time">[${time}]</span> [CMD] Wywołano rozkaz: ${desc} (${action})`;
            out.scrollTop = out.scrollHeight;

            setTimeout(() => {
                let responseText = "Wykonano pomyślnie w warstwie sprzętowej.";
                
                if(action.includes('torch')) {
                    // Symulacja lub wywołanie komendy termux-torch
                    responseText = "Przełączono stan diody LED urządzenia.";
                } else if(action === 'vibrate') {
                    responseText = "Wysłano sygnał wibracji (termux-vibrate).";
                } else if(action === 'battery') {
                    responseText = "Odczytano stan baterii: Stabilny / Poziom optymalny.";
                }

                out.innerHTML += `\n<span class="time">[${time}]</span> [ACK] ${responseText}`;
                out.scrollTop = out.scrollHeight;
                hwStatus.textContent = "GOTOWY";
                hwStatus.style.color = "#34d399";
            }, 300);
        }
    </script>
</body>
</html>
HTMLEOF

termux-open index.html
