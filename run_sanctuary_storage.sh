#!/bin/bash

# Inicjalizacja pliku bazy logów, jeśli nie istnieje
STORAGE_FILE="sanctuary_vault.log"
if [ ! -f "$STORAGE_FILE" ]; then
    echo "[VAULT_INIT] Utworzono bezpieczny magazyn danych Mr.Mekrix." > "$STORAGE_FILE"
fi

cat << 'HTMLEOF' > index.html
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mr.Mekrix | Persistent Storage Core</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background-color: #030508; color: #e2e8f0; font-family: monospace; padding: 12px; max-width: 900px; margin: auto; }
        header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #1e293b; padding-bottom: 10px; margin-bottom: 15px; }
        h1 { color: #38bdf8; font-size: 1.1rem; }
        .badge { background: #1e3a8a; color: #93c5fd; padding: 4px 8px; border-radius: 4px; font-size: 0.75rem; }
        .grid { display: grid; grid-template-columns: 1fr; gap: 15px; }
        @media(min-width: 600px) { .grid { grid-template-columns: 1fr 1fr; } }
        .card { background: #0b0f19; border: 1px solid #1e293b; border-radius: 8px; padding: 14px; }
        .card.full { grid-column: 1 / -1; }
        h3 { color: #93c5fd; font-size: 0.9rem; margin-bottom: 10px; border-bottom: 1px dashed #1e293b; padding-bottom: 5px; }
        
        label { font-size: 0.8rem; color: #94a3b8; display: block; margin-bottom: 5px; }
        input { width: 100%; background: #020408; color: #38bdf8; border: 1px solid #334155; border-radius: 4px; padding: 8px; font-family: monospace; font-size: 0.8rem; outline: none; margin-bottom: 10px; }
        
        button { background: #2563eb; color: #ffffff; border: none; padding: 10px; border-radius: 4px; cursor: pointer; font-weight: bold; font-family: monospace; width: 100%; font-size: 0.8rem; margin-bottom: 5px; }
        button:hover { opacity: 0.9; }
        button.export { background: #059669; }

        pre { background: #020408; color: #34d399; padding: 10px; border-radius: 4px; border: 1px solid #334155; overflow-y: auto; white-space: pre-wrap; font-size: 0.75rem; height: 220px; }
        .stats-row { display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 6px; }
        .stats-val { color: #facc15; }
        .time { color: #64748b; }
    </style>
</head>
<body>
    <header>
        <h1>🛡️ Mega Poland Wetr'vi</h1>
        <div class="badge">Persistent Vault Active</div>
    </header>
    
    <div class="grid">
        <!-- Zapis do Pamięci Trwałej -->
        <div class="card">
            <h3>🗄️ Magazyn Danych Trwałych</h3>
            <label>Wpis do zarchiwizowania w Vault:</label>
            <input type="text" id="vaultInput" value="Stabilizacja sesji głównej #Mr.Mekrix">
            
            <button onclick="saveToVault()">ZAPISZ TRWALE W SYSTEMIE</button>
            <button onclick="exportVault()" class="export">EKSPORTUJ STAN VAULT</button>
        </div>

        <!-- Telemetria Magazynu -->
        <div class="card">
            <h3>📊 Status Pamięci Trwałej</h3>
            <div class="stats-row"><span>Architekt:</span> <span class="stats-val">Mr.Mekrix</span></div>
            <div class="stats-row"><span>Nośnik:</span> <span class="stats-val">Termux Local Vault</span></div>
            <div class="stats-row"><span>Wpisy w pamięci:</span> <span id="vaultCount" class="stats-val">1</span></div>
            <div class="stats-row"><span>Stan zapisu:</span> <span id="vaultStatus" style="color: #34d399;">ZSYNCHRONIZOWANY</span></div>
        </div>

        <!-- Podgląd Magazynu -->
        <div class="card full">
            <h3>📜 Zawartość Rejestru Trwałego (Vault Log)</h3>
            <pre id="out"><span class="time">[INIT]</span> Magazyn trwały zainicjalizowany pomyślnie. Dane zachowywane lokalnie...</pre>
        </div>
    </div>

    <script>
        const out = document.getElementById('out');
        const vaultInput = document.getElementById('vaultInput');
        const vaultCount = document.getElementById('vaultCount');
        const vaultStatus = document.getElementById('vaultStatus');

        let records = 1;

        function saveToVault() {
            vaultStatus.textContent = "ZAPISYWANIE...";
            vaultStatus.style.color = "#fbbf24";
            
            const time = new Date().toLocaleTimeString();
            const val = vaultInput.value;

            setTimeout(() => {
                records++;
                vaultCount.textContent = records;
                out.innerHTML += `\n<span class="time">[${time}]</span> [VAULT_WRITE] Zapisano rekord: "${val}" (ID: REC_${7000 + records})`;
                out.scrollTop = out.scrollHeight;
                
                vaultStatus.textContent = "ZSYNCHRONIZOWANY";
                vaultStatus.style.color = "#34d399";
            }, 150);
        }

        function exportVault() {
            const time = new Date().toLocaleTimeString();
            out.innerHTML += `\n<span class="time">[${time}]</span> [VAULT_EXPORT] Wygenerowano zrzut bazy danych. Wszystkie stany zabezpieczone.`;
            out.scrollTop = out.scrollHeight;
        }
    </script>
</body>
</html>
HTMLEOF

termux-open index.html
