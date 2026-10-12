#!/bin/bash

cat << 'HTMLEOF' > index.html
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mr.Mekrix | Exorpero + Rixim Core</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background-color: #030508; color: #e2e8f0; font-family: monospace; padding: 12px; max-width: 900px; margin: auto; }
        header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #1e293b; padding-bottom: 10px; margin-bottom: 15px; }
        h1 { color: #38bdf8; font-size: 1.1rem; }
        .badge { background: #581c87; color: #c084fc; padding: 4px 8px; border-radius: 4px; font-size: 0.75rem; }
        .grid { display: grid; grid-template-columns: 1fr; gap: 15px; }
        @media(min-width: 600px) { .grid { grid-template-columns: 1fr 1fr; } }
        .card { background: #0b0f19; border: 1px solid #1e293b; border-radius: 8px; padding: 14px; }
        .card.full { grid-column: 1 / -1; }
        h3 { color: #c084fc; font-size: 0.9rem; margin-bottom: 10px; border-bottom: 1px dashed #1e293b; padding-bottom: 5px; }
        
        button { background: #7c3aed; color: #ffffff; border: none; padding: 12px; border-radius: 4px; cursor: pointer; font-weight: bold; font-family: monospace; width: 100%; font-size: 0.8rem; margin-top: 5px; transition: background 0.2s; }
        button:hover { background: #6d28d9; }
        button.rixim { background: #0d9488; }
        button.rixim:hover { background: #0f766e; }

        pre { background: #020408; color: #34d399; padding: 10px; border-radius: 4px; border: 1px solid #334155; overflow-y: auto; white-space: pre-wrap; font-size: 0.75rem; height: 220px; }
        .stats-row { display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 6px; }
        .stats-val { color: #facc15; }
        .time { color: #64748b; }
    </style>
</head>
<body>
    <header>
        <h1>🛡️ Mega Poland Wetr'vi</h1>
        <div class="badge">Exorpero + Rixim Active</div>
    </header>
    
    <div class="grid">
        <!-- Sterowanie Ekosystemem Reakcji -->
        <div class="card">
            <h3>⚛️ Koniunktura Bezdystrybucyjna</h3>
            <p style="font-size: 0.75rem; color: #94a3b8; margin-bottom: 10px;">Bezpośrednia polaryzacja impulsów reakcyjnych:</p>
            
            <button onclick="triggerExorpero()">WYWOŁAJ IMPULS EXORPERO</button>
            <button onclick="triggerRixim()" class="rixim">SYNCHRONIZACJA RIXIM (0-Dystrybucja)</button>
        </div>

        <!-- Telemetria Koniunktury -->
        <div class="card">
            <h3>📊 Stan Polaryzacji Reakcji</h3>
            <div class="stats-row"><span>Architekt:</span> <span class="stats-val">Mr.Mekrix</span></div>
            <div class="stats-row"><span>Tryb struktury:</span> <span class="stats-val">Non-Distributive</span></div>
            <div class="stats-row"><span>Wskaźnik Exorpero:</span> <span id="exoMetric" class="stats-val">STABILNY</span></div>
            <div class="stats-row"><span>Stan Rixim:</span> <span id="rixStatus" style="color: #2dd4bf;">GOTOWY</span></div>
        </div>

        <!-- Dziennik Polaryzacji -->
        <div class="card full">
            <h3>📜 Rejestr Reakcji Bezpośrednich (Exorpero & Rixim)</h3>
            <pre id="out"><span class="time">[INIT]</span> Rdzenny moduł Exorpero+Rixim załadowany. Brak dystrybucji pośredniej...</pre>
        </div>
    </div>

    <script>
        const out = document.getElementById('out');
        const exoMetric = document.getElementById('exoMetric');
        const rixStatus = document.getElementById('rixStatus');

        function logMsg(msg, tag="EXORPERO") {
            const time = new Date().toLocaleTimeString();
            out.innerHTML += `\n<span class="time">[${time}]</span> [${tag}] ${msg}`;
            out.scrollTop = out.scrollHeight;
        }

        function triggerExorpero() {
            exoMetric.textContent = "POLARYZACJA...";
            exoMetric.style.color = "#fbbf24";
            logMsg("Inicjowanie bezdystrybucyjnego impulsu Exorpero w rdzeniu...", "CORE");

            setTimeout(() => {
                const efficiency = (Math.random() * 0.05 + 99.95).toFixed(3);
                logMsg(`Impuls przetworzony z pominięciem dystrybucji. Wydajność korelacji: ${efficiency}%`, "EXORPERO");
                exoMetric.textContent = "ZSYNCHRONIZOWANY";
                exoMetric.textContent = "STABILNY";
                exoMetric.style.color = "#34d399";
            }, 180);
        }

        function triggerRixim() {
            rixStatus.textContent = "BEZDYSTRYBUCYJNIE";
            rixStatus.style.color = "#facc15";
            logMsg("Wyzwalanie koniunktury Rixim – zamknięcie obwodu reakcji natychmiastowej...", "RIXIM");

            setTimeout(() => {
                logMsg("Obwód Rixim zamknięty. Brak buforów pośrednich. Reakcja w czasie rzeczywistym 0.0ms.", "RIXIM");
                rixStatus.textContent = " AKTYWNY (0-DIST)";
                rixStatus.style.color = "#2dd4bf";
            }, 220);
        }
    </script>
</body>
</html>
HTMLEOF

termux-open index.html
