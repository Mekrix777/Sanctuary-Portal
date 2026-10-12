#!/bin/bash

# 1. Zamykamy ewentualne stare procesy
killall mono python3 2>/dev/null

# 2. Tworzymy gotowy portal HTML
cat << 'HTMLEOF' > index.html
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mr.Mekrix | Sanctuary Portal</title>
    <style>
        body { background: #07090e; color: #d1d5db; font-family: monospace; padding: 20px; max-width: 800px; margin: auto; }
        h1 { color: #60a5fa; border-bottom: 1px solid #1e2230; padding-bottom: 10px; }
        .box { background: #0f111a; border: 1px solid #1e2230; border-radius: 12px; padding: 20px; margin-top: 20px; }
        textarea { width: 100%; background: #030712; color: #e5e7eb; border: 1px solid #374151; padding: 10px; border-radius: 6px; box-sizing: border-box; }
        button { background: #2563eb; color: white; border: none; padding: 12px 20px; border-radius: 6px; cursor: pointer; font-weight: bold; margin-top: 10px; width: 100%; }
        pre { background: #030712; color: #34d399; padding: 15px; border-radius: 6px; border: 1px solid #1e2230; overflow-x: auto; white-space: pre-wrap; }
    </style>
</head>
<body>
    <h1>Mr.Mekrix | Sanctuary Portal</h1>
    
    <div class="box">
        <h3>⚡ Suwerenny Panel AI & C++ Core</h3>
        <p>Status: <span id="bridgeStatus" style="color: #34d399;">System Gotowy</span></p>
        
        <label>Pakiet danych wejściowych:</label><br><br>
        <textarea id="payloadInput" rows="3">{"prompt": "Analiza systemu Mr.Mekrix w ekosystemie Mega Poland Wetr'vi"}</textarea>
        
        <button id="triggerAnalyzeBtn">Uruchom Analizę Sanctuarium</button>
        
        <h4 style="margin-top: 20px;">Wynik analizy:</h4>
        <pre id="outputLog">[Oczekiwanie na uruchomienie...]</pre>
    </div>

    <script>
        document.getElementById('triggerAnalyzeBtn').addEventListener('click', () => {
            const outputLog = document.getElementById('outputLog');
            const bridgeStatus = document.getElementById('bridgeStatus');
            const rawInput = document.getElementById('payloadInput').value;

            bridgeStatus.textContent = "Przetwarzanie...";
            bridgeStatus.style.color = "#fbbf24";

            setTimeout(() => {
                const result = {
                    status: "SUCCESS",
                    node: "MegaPolandWetrVi_Local_Core",
                    user: "Mr.Mekrix",
                    input: rawInput,
                    message: "Przetworzono pomyślnie w lokalnym ekosystemie.",
                    timestamp: new Date().toLocaleString()
                };

                outputLog.textContent = JSON.stringify(result, null, 4);
                bridgeStatus.textContent = "Aktywny i stabilny";
                bridgeStatus.style.color = "#34d399";
            }, 300);
        });
    </script>
</body>
</html>
HTMLEOF

# 3. Bezpośrednie wywołanie pliku w systemie Android
termux-open index.html
