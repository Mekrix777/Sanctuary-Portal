#!/bin/bash

cat << 'HTMLEOF' > index.html
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mr.Mekrix | Multi-Threaded Queue Core</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background-color: #030508; color: #e2e8f0; font-family: monospace; padding: 12px; max-width: 900px; margin: auto; }
        header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #1e293b; padding-bottom: 10px; margin-bottom: 15px; }
        h1 { color: #38bdf8; font-size: 1.1rem; }
        .badge { background: #065f46; color: #34d399; padding: 4px 8px; border-radius: 4px; font-size: 0.75rem; }
        .grid { display: grid; grid-template-columns: 1fr; gap: 15px; }
        @media(min-width: 600px) { .grid { grid-template-columns: 1fr 1fr; } }
        .card { background: #0b0f19; border: 1px solid #1e293b; border-radius: 8px; padding: 14px; }
        .card.full { grid-column: 1 / -1; }
        h3 { color: #93c5fd; font-size: 0.9rem; margin-bottom: 10px; border-bottom: 1px dashed #1e293b; padding-bottom: 5px; }
        
        button { background: #2563eb; color: #ffffff; border: none; padding: 10px; border-radius: 4px; cursor: pointer; font-weight: bold; font-family: monospace; width: 100%; font-size: 0.8rem; margin-top: 5px; }
        button:hover { opacity: 0.9; }
        button.stop { background: #dc2626; }

        pre { background: #020408; color: #34d399; padding: 10px; border-radius: 4px; border: 1px solid #334155; overflow-y: auto; white-space: pre-wrap; font-size: 0.75rem; height: 220px; }
        .stats-row { display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 6px; }
        .stats-val { color: #facc15; }
        .time { color: #64748b; }
    </style>
</head>
<body>
    <header>
        <h1>🛡️ Mega Poland Wetr'vi</h1>
        <div class="badge">Thread Queue Active</div>
    </header>
    
    <div class="grid">
        <!-- Panel Sterowania Wątkami -->
        <div class="card">
            <h3>⚙️ Symulator Kolejki Wątków</h3>
            <p style="font-size: 0.75rem; color: #94a3b8; margin-bottom: 10px;">Generowanie strumienia równoległych pakietów w tle:</p>
            
            <button onclick="startQueue()">URUCHOM STRUMIEŃ TŁA</button>
            <button onclick="stopQueue()" class="stop">ZATRZYMAJ KOLEJKĘ</button>
        </div>

        <!-- Telemetria Kolejki -->
        <div class="card">
            <h3>📊 Statystyka Wątków</h3>
            <div class="stats-row"><span>Architekt:</span> <span class="stats-val">Mr.Mekrix</span></div>
            <div class="stats-row"><span>Aktywne wątki:</span> <span id="activeThreads" class="stats-val">0</span></div>
            <div class="stats-row"><span>Przetworzone pakiety:</span> <span id="queueCount" class="stats-val">0</span></div>
            <div class="stats-row"><span>Stan kolejki:</span> <span id="queueStatus" style="color: #34d399;">BEZCZYNNY</span></div>
        </div>

        <!-- Rejestr Wątków -->
        <div class="card full">
            <h3>📜 Dziennik Przetwarzania Współbieżnego</h3>
            <pre id="out"><span class="time">[INIT]</span> Modulet wątków w tle gotowy do symulacji...</pre>
        </div>
    </div>

    <script>
        let interval = null;
        let count = 0;
        const out = document.getElementById('out');
        const queueStatus = document.getElementById('queueStatus');
        const activeThreads = document.getElementById('activeThreads');
        const queueCount = document.getElementById('queueCount');

        function startQueue() {
            if(interval) return;
            queueStatus.textContent = "PRETWARZANIE STRUMIENIA";
            queueStatus.style.color = "#fbbf24";
            activeThreads.textContent = "4 (Workers)";
            
            out.innerHTML += `\n<span class="time">[${new Date().toLocaleTimeString()}]</span> [SYSTEM] Uruchomiono wielowątkową kolejkę pakietów w tle.`;
            
            interval = setInterval(() => {
                count++;
                queueCount.textContent = count;
                const time = new Date().toLocaleTimeString();
                const threadId = Math.floor(Math.random() * 4) + 1;
                
                out.innerHTML += `\n<span class="time">[${time}]</span> [THREAD #${threadId}] Pakiet PKT_${1000 + count} pomyślnie zdekodowany i zbuforowany.`;
                out.scrollTop = out.scrollHeight;
            }, 1200);
        }

        function stopQueue() {
            if(!interval) return;
            clearInterval(interval);
            interval = null;
            queueStatus.textContent = "ZATRZYMANY";
            queueStatus.style.color = "#f87171";
            activeThreads.textContent = "0";
            out.innerHTML += `\n<span class="time">[${new Date().toLocaleTimeString()}]</span> [SYSTEM] Kolejka wątków została zatrzymana przez architekta.`;
            out.scrollTop = out.scrollHeight;
        }
    </script>
</body>
</html>
HTMLEOF

termux-open index.html
