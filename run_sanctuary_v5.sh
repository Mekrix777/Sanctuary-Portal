#!/bin/bash
cat << 'HTMLEOF' > index.html
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mr.Mekrix | Sanctuary HUD v5.0</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Share+Tech+Mono&display=swap');

        * { box-sizing: border-box; margin: 0; padding: 0; }
        
        body { 
            background-color: #020408; 
            color: #38bdf8; 
            font-family: 'Share Tech Mono', monospace; 
            padding: 14px; 
            max-width: 950px; 
            margin: auto;
            position: relative;
            overflow-x: hidden;
        }

        /* Efekt siatki tła (Cyberpunk Grid) */
        body::before {
            content: " ";
            display: block;
            position: fixed;
            top: 0; left: 0; bottom: 0; right: 0;
            background: linear-gradient(rgba(18, 16, 16, 0) 50%, rgba(0, 0, 0, 0.25) 50%), linear-gradient(90deg, rgba(255, 0, 0, 0.03), rgba(0, 255, 0, 0.01), rgba(0, 0, 255, 0.03));
            z-index: 999;
            background-size: 100% 4px, 6px 100%;
            pointer-events: none;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #0284c7;
            padding-bottom: 12px;
            margin-bottom: 15px;
            background: rgba(3, 7, 18, 0.8);
            box-shadow: 0 0 15px rgba(2, 132, 199, 0.2);
        }

        h1 { 
            color: #38bdf8; 
            font-size: 1.2rem; 
            text-shadow: 0 0 10px rgba(56,189,248,0.6);
            letter-spacing: 1px;
        }

        .badge { 
            background: #042f2e; 
            color: #2dd4bf; 
            padding: 6px 10px; 
            border-radius: 2px; 
            font-size: 0.75rem; 
            border: 1px solid #14b8a6;
            box-shadow: 0 0 8px rgba(45, 212, 191, 0.3);
        }

        /* Pasek Zakładek (Tabs) */
        .tabs {
            display: flex;
            gap: 8px;
            margin-bottom: 15px;
            overflow-x: auto;
            padding-bottom: 6px;
        }

        .tab-btn {
            background: #090d16;
            color: #64748b;
            border: 1px solid #1e293b;
            padding: 10px 16px;
            border-radius: 3px;
            cursor: pointer;
            font-family: 'Share Tech Mono', monospace;
            font-size: 0.8rem;
            white-space: nowrap;
            transition: all 0.3s ease;
            letter-spacing: 0.5px;
        }

        .tab-btn:hover {
            color: #38bdf8;
            border-color: #0284c7;
            box-shadow: 0 0 8px rgba(2, 132, 199, 0.3);
        }

        .tab-btn.active {
            background: #082f49;
            color: #38bdf8;
            border-color: #38bdf8;
            box-shadow: 0 0 12px rgba(56,189,248,0.4);
            font-weight: bold;
        }

        /* Karty Główne */
        .panel-card {
            display: none;
            background: rgba(8, 12, 20, 0.95);
            border: 1px solid #1e293b;
            border-radius: 4px;
            padding: 18px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.8);
            position: relative;
        }

        .panel-card.active { display: block; }

        /* Neonowa krawędź karty */
        .panel-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 4px; height: 100%;
            background: #38bdf8;
            box-shadow: 0 0 10px #38bdf8;
        }

        h3 { 
            color: #93c5fd; 
            font-size: 1rem; 
            margin-bottom: 14px; 
            border-bottom: 1px dashed #1e293b; 
            padding-bottom: 8px; 
            letter-spacing: 0.5px;
        }
        
        label { font-size: 0.8rem; color: #94a3b8; display: block; margin-bottom: 6px; }
        
        input, textarea { 
            width: 100%; 
            background: #010306; 
            color: #38bdf8; 
            border: 1px solid #334155; 
            border-radius: 2px; 
            padding: 10px; 
            font-family: 'Share Tech Mono', monospace; 
            font-size: 0.85rem;
            outline: none;
            margin-bottom: 12px;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.6);
        }
        
        input:focus, textarea:focus {
            border-color: #38bdf8;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.6), 0 0 8px rgba(56,189,248,0.3);
        }

        button { 
            background: #0284c7; 
            color: #ffffff; 
            border: none; 
            padding: 11px; 
            border-radius: 2px; 
            cursor: pointer; 
            font-weight: bold; 
            font-family: 'Share Tech Mono', monospace;
            width: 100%;
            font-size: 0.85rem;
            margin-bottom: 10px;
            transition: all 0.2s;
            letter-spacing: 1px;
            box-shadow: 0 0 10px rgba(2, 132, 199, 0.4);
        }
        
        button:hover { 
            background: #0369a1; 
            box-shadow: 0 0 15px rgba(2, 132, 199, 0.7);
        }

        button.secondary { background: #1e293b; box-shadow: none; color: #cbd5e1; }
        button.secondary:hover { background: #334155; box-shadow: 0 0 10px rgba(100,116,139,0.4); }
        
        button.special { background: #7c3aed; box-shadow: 0 0 10px rgba(124, 58, 237, 0.5); }
        button.special:hover { background: #6d28d9; box-shadow: 0 0 15px rgba(124, 58, 237, 0.8); }

        pre { 
            background: #010306; 
            color: #34d399; 
            padding: 12px; 
            border-radius: 2px; 
            border: 1px solid #1e293b; 
            overflow-y: auto; 
            white-space: pre-wrap; 
            font-size: 0.8rem; 
            height: 210px;
            box-shadow: inset 0 2px 6px rgba(0,0,0,0.8);
        }

        .stats-row { 
            display: flex; 
            justify-content: space-between; 
            font-size: 0.85rem; 
            margin-bottom: 10px; 
            border-bottom: 1px dotted #1e293b; 
            padding-bottom: 6px; 
        }
        .stats-val { color: #facc15; text-shadow: 0 0 6px rgba(250,204,21,0.4); }
        .time { color: #64748b; }

        /* Paski postępu / obciążenia rdzenia */
        .load-bar-container {
            background: #010306;
            border: 1px solid #1e293b;
            height: 12px;
            border-radius: 2px;
            margin-bottom: 12px;
            overflow: hidden;
            position: relative;
        }
        .load-bar-fill {
            background: linear-gradient(90deg, #0284c7, #38bdf8);
            height: 100%;
            width: 42%;
            box-shadow: 0 0 8px #38bdf8;
            transition: width 0.4s ease;
        }
    </style>
</head>
<body>
    <header>
        <h1>🛡️ Mega Poland Wetr'vi</h1>
        <div class="badge">HUD v5.0 // ONLINE</div>
    </header>
    
    <div class="tabs">
        <button class="tab-btn active" onclick="switchTab(event, 'tab-console')">⚙️ [01] Konsola</button>
        <button class="tab-btn" onclick="switchTab(event, 'tab-telemetry')">📊 [02] Telemetria</button>
        <button class="tab-btn" onclick="switchTab(event, 'tab-threads')">🧵 [03] Wątki</button>
        <button class="tab-btn" onclick="switchTab(event, 'tab-exorpero')">⚛️ [04] Exorpero</button>
        <button class="tab-btn" onclick="switchTab(event, 'tab-vault')">🗄️ [05] Vault</button>
    </div>

    <!-- Karta 1 -->
    <div id="tab-console" class="panel-card active">
        <h3>Główny Terminal Rozkazów</h3>
        <label>Pakiet / Payload:</label>
        <textarea id="consoleInp" rows="3">{"modul": "Sanctuary HUD", "status": "Ready"}</textarea>
        <button onclick="sendConsoleCmd()">WYŚLIJ PAKIET DO RDZENIA</button>
        <pre id="consoleLog"><span class="time">[INIT]</span> Połączenie z terminalem nawiązane pomyślnie...</pre>
    </div>

    <!-- Karta 2 -->
    <div id="tab-telemetry" class="panel-card" style="border-left-color: #facc15;">
        <h3 style="color: #facc15;">Telemetria i Obciążenie Magistrali</h3>
        <div class="stats-row"><span>Architekt:</span> <span class="stats-val">Mr.Mekrix</span></div>
        <div class="stats-row"><span>Przepustowość szyny:</span> <span class="stats-val">99.9%</span></div>
        <div class="stats-row"><span>Opóźnienie bazowe:</span> <span class="stats-val">0.31 ms</span></div>
        
        <label style="margin-top: 15px;">Obciążenie rdzenia C# / C++:</label>
        <div class="load-bar-container"><div class="load-bar-fill" id="coreLoad"></div></div>
        
        <div class="stats-row"><span>Stan obwodu:</span> <span style="color: #34d399;">ZSYNCHRONIZOWANY</span></div>
    </div>

    <!-- Karta 3 -->
    <div id="tab-threads" class="panel-card" style="border-left-color: #34d399;">
        <h3 style="color: #34d399;">Symulator Kolejki Wątków (Background Workers)</h3>
        <button onclick="toggleThreads()" id="threadBtn" class="secondary">URUCHOM STRUMIEŃ WĄTKÓW</button>
        <pre id="threadLog"><span class="time">[INIT]</span> Kolejka w tle w gotowości...</pre>
    </div>

    <!-- Karta 4 -->
    <div id="tab-exorpero" class="panel-card" style="border-left-color: #c084fc;">
        <h3 style="color: #c084fc;">Koniunktura Bezdystrybucyjna (Exorpero + Rixim)</h3>
        <button onclick="triggerExorpero()" class="special">WYWOŁAJ IMPULS EXORPERO</button>
        <button onclick="triggerRixim()" style="background: #0d9488; box-shadow: 0 0 10px rgba(13,148,136,0.5);">SYNCHRONIZACJA RIXIM (0-DIST)</button>
        <pre id="exorperoLog"><span class="time">[INIT]</span> Obwody reakcji bezpośredniej włączone...</pre>
    </div>

    <!-- Karta 5 -->
    <div id="tab-vault" class="panel-card" style="border-left-color: #2dd4bf;">
        <h3 style="color: #2dd4bf;">Magazyn Danych Trwałych (Vault)</h3>
        <label>Z

cat << 'EOF' > run_sanctuary_v5.sh
#!/bin/bash
cat << 'HTMLEOF' > index.html
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mr.Mekrix | Sanctuary HUD v5.0</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Share+Tech+Mono&display=swap');

        * { box-sizing: border-box; margin: 0; padding: 0; }
        
        body { 
            background-color: #020408; 
            color: #38bdf8; 
            font-family: 'Share Tech Mono', monospace; 
            padding: 14px; 
            max-width: 950px; 
            margin: auto;
            position: relative;
            overflow-x: hidden;
        }

        /* Efekt siatki tła (Cyberpunk Grid) */
        body::before {
            content: " ";
            display: block;
            position: fixed;
            top: 0; left: 0; bottom: 0; right: 0;
            background: linear-gradient(rgba(18, 16, 16, 0) 50%, rgba(0, 0, 0, 0.25) 50%), linear-gradient(90deg, rgba(255, 0, 0, 0.03), rgba(0, 255, 0, 0.01), rgba(0, 0, 255, 0.03));
            z-index: 999;
            background-size: 100% 4px, 6px 100%;
            pointer-events: none;
        }

        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #0284c7;
            padding-bottom: 12px;
            margin-bottom: 15px;
            background: rgba(3, 7, 18, 0.8);
            box-shadow: 0 0 15px rgba(2, 132, 199, 0.2);
        }

        h1 { 
            color: #38bdf8; 
            font-size: 1.2rem; 
            text-shadow: 0 0 10px rgba(56,189,248,0.6);
            letter-spacing: 1px;
        }

        .badge { 
            background: #042f2e; 
            color: #2dd4bf; 
            padding: 6px 10px; 
            border-radius: 2px; 
            font-size: 0.75rem; 
            border: 1px solid #14b8a6;
            box-shadow: 0 0 8px rgba(45, 212, 191, 0.3);
        }

        /* Pasek Zakładek (Tabs) */
        .tabs {
            display: flex;
            gap: 8px;
            margin-bottom: 15px;
            overflow-x: auto;
            padding-bottom: 6px;
        }

        .tab-btn {
            background: #090d16;
            color: #64748b;
            border: 1px solid #1e293b;
            padding: 10px 16px;
            border-radius: 3px;
            cursor: pointer;
            font-family: 'Share Tech Mono', monospace;
            font-size: 0.8rem;
            white-space: nowrap;
            transition: all 0.3s ease;
            letter-spacing: 0.5px;
        }

        .tab-btn:hover {
            color: #38bdf8;
            border-color: #0284c7;
            box-shadow: 0 0 8px rgba(2, 132, 199, 0.3);
        }

        .tab-btn.active {
            background: #082f49;
            color: #38bdf8;
            border-color: #38bdf8;
            box-shadow: 0 0 12px rgba(56,189,248,0.4);
            font-weight: bold;
        }

        /* Karty Główne */
        .panel-card {
            display: none;
            background: rgba(8, 12, 20, 0.95);
            border: 1px solid #1e293b;
            border-radius: 4px;
            padding: 18px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.8);
            position: relative;
        }

        .panel-card.active { display: block; }

        /* Neonowa krawędź karty */
        .panel-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 4px; height: 100%;
            background: #38bdf8;
            box-shadow: 0 0 10px #38bdf8;
        }

        h3 { 
            color: #93c5fd; 
            font-size: 1rem; 
            margin-bottom: 14px; 
            border-bottom: 1px dashed #1e293b; 
            padding-bottom: 8px; 
            letter-spacing: 0.5px;
        }
        
        label { font-size: 0.8rem; color: #94a3b8; display: block; margin-bottom: 6px; }
        
        input, textarea { 
            width: 100%; 
            background: #010306; 
            color: #38bdf8; 
            border: 1px solid #334155; 
            border-radius: 2px; 
            padding: 10px; 
            font-family: 'Share Tech Mono', monospace; 
            font-size: 0.85rem;
            outline: none;
            margin-bottom: 12px;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.6);
        }
        
        input:focus, textarea:focus {
            border-color: #38bdf8;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.6), 0 0 8px rgba(56,189,248,0.3);
        }

        button { 
            background: #0284c7; 
            color: #ffffff; 
            border: none; 
            padding: 11px; 
            border-radius: 2px; 
            cursor: pointer; 
            font-weight: bold; 
            font-family: 'Share Tech Mono', monospace;
            width: 100%;
            font-size: 0.85rem;
            margin-bottom: 10px;
            transition: all 0.2s;
            letter-spacing: 1px;
            box-shadow: 0 0 10px rgba(2, 132, 199, 0.4);
        }
        
        button:hover { 
            background: #0369a1; 
            box-shadow: 0 0 15px rgba(2, 132, 199, 0.7);
        }

        button.secondary { background: #1e293b; box-shadow: none; color: #cbd5e1; }
        button.secondary:hover { background: #334155; box-shadow: 0 0 10px rgba(100,116,139,0.4); }
        
        button.special { background: #7c3aed; box-shadow: 0 0 10px rgba(124, 58, 237, 0.5); }
        button.special:hover { background: #6d28d9; box-shadow: 0 0 15px rgba(124, 58, 237, 0.8); }

        pre { 
            background: #010306; 
            color: #34d399; 
            padding: 12px; 
            border-radius: 2px; 
            border: 1px solid #1e293b; 
            overflow-y: auto; 
            white-space: pre-wrap; 
            font-size: 0.8rem; 
            height: 210px;
            box-shadow: inset 0 2px 6px rgba(0,0,0,0.8);
        }

        .stats-row { 
            display: flex; 
            justify-content: space-between; 
            font-size: 0.85rem; 
            margin-bottom: 10px; 
            border-bottom: 1px dotted #1e293b; 
            padding-bottom: 6px; 
        }
        .stats-val { color: #facc15; text-shadow: 0 0 6px rgba(250,204,21,0.4); }
        .time { color: #64748b; }

        /* Paski postępu / obciążenia rdzenia */
        .load-bar-container {
            background: #010306;
            border: 1px solid #1e293b;
            height: 12px;
            border-radius: 2px;
            margin-bottom: 12px;
            overflow: hidden;
            position: relative;
        }
        .load-bar-fill {
            background: linear-gradient(90deg, #0284c7, #38bdf8);
            height: 100%;
            width: 42%;
            box-shadow: 0 0 8px #38bdf8;
            transition: width 0.4s ease;
        }
    </style>
</head>
<body>
    <header>
        <h1>🛡️ Mega Poland Wetr'vi</h1>
        <div class="badge">HUD v5.0 // ONLINE</div>
    </header>
    
    <div class="tabs">
        <button class="tab-btn active" onclick="switchTab(event, 'tab-console')">⚙️ [01] Konsola</button>
        <button class="tab-btn" onclick="switchTab(event, 'tab-telemetry')">📊 [02] Telemetria</button>
        <button class="tab-btn" onclick="switchTab(event, 'tab-threads')">🧵 [03] Wątki</button>
        <button class="tab-btn" onclick="switchTab(event, 'tab-exorpero')">⚛️ [04] Exorpero</button>
        <button class="tab-btn" onclick="switchTab(event, 'tab-vault')">🗄️ [05] Vault</button>
    </div>

    <!-- Karta 1 -->
    <div id="tab-console" class="panel-card active">
        <h3>Główny Terminal Rozkazów</h3>
        <label>Pakiet / Payload:</label>
        <textarea id="consoleInp" rows="3">{"modul": "Sanctuary HUD", "status": "Ready"}</textarea>
        <button onclick="sendConsoleCmd()">WYŚLIJ PAKIET DO RDZENIA</button>
        <pre id="consoleLog"><span class="time">[INIT]</span> Połączenie z terminalem nawiązane pomyślnie...</pre>
    </div>

    <!-- Karta 2 -->
    <div id="tab-telemetry" class="panel-card" style="border-left-color: #facc15;">
        <h3 style="color: #facc15;">Telemetria i Obciążenie Magistrali</h3>
        <div class="stats-row"><span>Architekt:</span> <span class="stats-val">Mr.Mekrix</span></div>
        <div class="stats-row"><span>Przepustowość szyny:</span> <span class="stats-val">99.9%</span></div>
        <div class="stats-row"><span>Opóźnienie bazowe:</span> <span class="stats-val">0.31 ms</span></div>
        
        <label style="margin-top: 15px;">Obciążenie rdzenia C# / C++:</label>
        <div class="load-bar-container"><div class="load-bar-fill" id="coreLoad"></div></div>
        
        <div class="stats-row"><span>Stan obwodu:</span> <span style="color: #34d399;">ZSYNCHRONIZOWANY</span></div>
    </div>

    <!-- Karta 3 -->
    <div id="tab-threads" class="panel-card" style="border-left-color: #34d399;">
        <h3 style="color: #34d399;">Symulator Kolejki Wątków (Background Workers)</h3>
        <button onclick="toggleThreads()" id="threadBtn" class="secondary">URUCHOM STRUMIEŃ WĄTKÓW</button>
        <pre id="threadLog"><span class="time">[INIT]</span> Kolejka w tle w gotowości...</pre>
    </div>

    <!-- Karta 4 -->
    <div id="tab-exorpero" class="panel-card" style="border-left-color: #c084fc;">
        <h3 style="color: #c084fc;">Koniunktura Bezdystrybucyjna (Exorpero + Rixim)</h3>
        <button onclick="triggerExorpero()" class="special">WYWOŁAJ IMPULS EXORPERO</button>
        <button onclick="triggerRixim()" style="background: #0d9488; box-shadow: 0 0 10px rgba(13,148,136,0.5);">SYNCHRONIZACJA RIXIM (0-DIST)</button>
        <pre id="exorperoLog"><span class="time">[INIT]</span> Obwody reakcji bezpośredniej włączone...</pre>
    </div>

    <!-- Karta 5 -->
    <div id="tab-vault" class="panel-card" style="border-left-color: #2dd4bf;">
        <h3 style="color: #2dd4bf;">Magazyn Danych Trwałych (Vault)</h3>
        <label>Z

cat << 'EOF' > run_sanctuary_hybrid.sh
#!/bin/bash
cat << 'HTMLEOF' > index.html
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mr.Mekrix | Sanctuary Hybrid Core</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        
        body { 
            background-color: #030508; 
            color: #e2e8f0; 
            font-family: monospace; 
            padding: 14px; 
            max-width: 900px; 
            margin: auto; 
        }

        /* Klasyczny nagłówek z nowoczesną akcentującą linią */
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid #1e293b;
            padding-bottom: 10px;
            margin-bottom: 15px;
        }
        h1 { color: #38bdf8; font-size: 1.1rem; }
        .badge { 
            background: #065f46; 
            color: #34d399


pkg install python -y 2>/dev/null

cat << 'HTMLEOF' > index.html
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mr.Mekrix | Sanctuary Hybrid Core</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background-color: #030508; color: #e2e8f0; font-family: monospace; padding: 14px; max-width: 900px; margin: auto; }
        header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #1e293b; padding-bottom: 10px; margin-bottom: 15px; }
        h1 { color: #38bdf8; font-size: 1.1rem; }
        .badge { background: #065f46; color: #34d399; padding: 4px 8px; border-radius: 4px; font-size: 0.75rem; border: 1px solid #10b981; }
        .tabs { display: flex; gap: 6px; margin-bottom: 15px; overflow-x: auto; padding-bottom: 4px; }
        .tab-btn { background: #0b0f19; color: #94a3b8; border: 1px solid #1e293b; padding: 8px 14px; border-radius: 4px; cursor: pointer; font-family: monospace; font-size: 0.75rem; white-space: nowrap; }
        .tab-btn:hover { color: #38bdf8; border-color: #334155; }
        .tab-btn.active { background: #0f172a; color: #38bdf8; border-color: #38bdf8; font-weight: bold; }
        .grid { display: grid; grid-template-columns: 1fr; gap: 15px; }
        @media(min-width: 600px) { .grid { grid-template-columns: 1fr 1fr; } }
        .card { background: #0b0f19; border: 1px solid #1e293b; border-radius: 6px; padding: 14px; position: relative; }
        .card.full { grid-column: 1 / -1; }
        .card::before { content: ''; position: absolute; top: 0; left: 0; width: 3px; height: 100%; background: #38bdf8; border-radius: 3px 0 0 3px; }
        h3 { color: #93c5fd; font-size: 0.9rem; margin-bottom: 10px; border-bottom: 1px dashed #1e293b; padding-bottom: 5px; }
        label { font-size: 0.75rem; color: #94a3b8; display: block; margin-bottom: 5px; }
        input { width: 100%; background: #020408; color: #38bdf8; border: 1px solid #334155; border-radius: 4px; padding: 8px; font-family: monospace; font-size: 0.8rem; outline: none; margin-bottom: 8px; }
        button { background: #2563eb; color: #ffffff; border: none; padding: 10px; border-radius: 4px; cursor: pointer; font-weight: bold; font-family: monospace; width: 100%; font-size: 0.8rem; margin-bottom: 6px; }
        button:hover { opacity: 0.85; }
        button.special { background: #7c3aed; }
        pre { background: #020408; color: #34d399; padding: 10px; border-radius: 4px; border: 1px solid #334155; overflow-y: auto; white-space: pre-wrap; font-size: 0.75rem; height: 200px; }
        .stats-row { display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 6px; border-bottom: 1px dotted #1e293b; padding-bottom: 4px; }
        .stats-val { color: #facc15; }
        .time { color: #64748b; }
        .meter { background: #020408; border: 1px solid #334155; height: 10px; border-radius: 2px; margin-bottom: 10px; overflow: hidden; }
        .meter-fill { background: #38bdf8; height: 100%; width: 45%; transition: width 0.3s ease; }
    </style>
</head>
<body>
    <header>
        <h1>🛡️ Mega Poland Wetr'vi</h1>
        <div class="badge">Hybrid Sanctuary Core</div>
    </header>
    
    <div class="tabs">
        <button class="tab-btn active" onclick="switchView('view-main')">⚙️ Główny Panel</button>
        <button class="tab-btn" onclick="switchView('view-exorpero')">⚛️ Exorpero + Rixim</button>
        <button class="tab-btn" onclick="switchView('view-vault')">🗄️ Vault Logi</button>
    </div>

    <div id="view-main" class="grid">
        <div class="card">
            <h3>⚙️ Konsola Rozkazów</h3>
            <label>Instrukcja dla rdzenia:</label>
            <input type="text" id="cmdInput" value="Inicjalizacja hybrydowego obwodu #Mr.Mekrix">
            <button onclick="runCmd()">WYŚLIJ ROZKAZ</button>
        </div>

        <div class="card" style="border-left-color: #facc15;">
            <h3>📊 Telemetria i Obciążenie</h3>
            <div class="stats-row"><span>Architekt:</span> <span class="stats-val">Mr.Mekrix</span></div>
            <div class="stats-row"><span>Przepustowość:</span> <span class="stats-val">100%</span></div>
            <label style="margin-top: 6px;">Obciążenie rdzenia C# / C++:</label>
            <div class="meter"><div class="meter-fill" id="coreMeter"></div></div>
        </div>

        <div class="card full">
            <h3>📜 Dziennik Zdarzeń Systemowych</h3>
            <pre id="mainLog"><span class="time">[INIT]</span> System gotowy pod adresem http://localhost:8080...</pre>
        </div>
    </div>

    <div id="view-exorpero" class="grid" style="display: none;">
        <div class="card full" style="border-left-color: #c084fc;">
            <h3 style="color: #c084fc;">⚛️ Koniunktura Bezdystrybucyjna</h3>
            <button onclick="triggerExo()" class="special">WYWOŁAJ IMPULS EXORPERO</button>
            <button onclick="triggerRix()" style="background: #0d9488;">SYNCHRONIZACJA RIXIM (0-DIST)</button>
            <pre id="exoLog"><span class="time">[INIT]</span> Obwody reakcji bezpośredniej w gotowości...</pre>
        </div>
    </div>

    <div id="view-vault" class="grid" style="display: none;">
        <div class="card full" style="border-left-color: #34d399;">
            <h3 style="color: #34d399;">🗄️ Pamięć Trwała (Vault)</h3>
            <label>Nowy wpis do pamięci:</label>
            <input type="text" id="vaultInp" value="Dane sesji zabezpieczone lokalnie">
            <button onclick="saveVault()" style="background: #059669;">ZAPISZ TRWALE W SYSTEMIE</button>
            <pre id="vaultLog"><span class="time">[INIT]</span> Magazyn danych aktywny...</pre>
        </div>
    </div>

    <script>
        function switchView(viewId) {
            document.getElementById('view-main').style.display = 'none';
            document.getElementById('view-exorpero').style.display = 'none';
            document.getElementById('view-vault').style.display = 'none';

            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
            
            document.getElementById(viewId).style.display = 'grid';
            event.currentTarget.classList.add('active');
        }

        function runCmd() {
            const val = document.getElementById('cmdInput').value;
            const log = document.getElementById('mainLog');
            const time = new Date().toLocaleTimeString();
            log.innerHTML += `\n<span class="time">[${time}]</span> [CMD] Wykonano: "${val}"`;
            log.scrollTop = log.scrollHeight;
        }

        function triggerExo() {
            const log = document.getElementById('exoLog');
            const time = new Date().toLocaleTimeString();
            log.innerHTML += `\n<span class="time">[${time}]</span> [EXORPERO] Impuls korelacyjny 99.96% bez dystrybucji.`;
            log.scrollTop = log.scrollHeight;
        }

        function triggerRix() {
            const log = document.getElementById('exoLog');
            const time = new Date().toLocaleTimeString();
            log.innerHTML += `\n<span class="time">[${time}]</span> [RIXIM] Zamknięcie obwodu reakcji w 0.0ms.`;
            log.scrollTop = log.scrollHeight;
        }

        function saveVault() {
            const val = document.getElementById('vaultInp').value;
            const log = document.getElementById('vaultLog');
            const time = new Date().toLocaleTimeString();
            log.innerHTML += `\n<span class="time">[${time}]</span> [VAULT] Zapisano rekord: "${val}"`;
            log.scrollTop = log.scrollHeight;
        }

        setInterval(() => {
            const fill = document.getElementById('coreMeter');
            if(fill) {
                const val = Math.floor(Math.random() * 40) + 30;
                fill.style.width = val + '%';
            }
        }, 2000);
    </script>
</body>
</html>
HTMLEOF

termux-open-url http://localhost:8080 || termux-open index.html
python -m http.server 8080

pkill -f "http.server"
cat << 'HTMLEOF' > index.html
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mr.Mekrix | Sanctuary Core</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background-color: #030508; color: #e2e8f0; font-family: monospace; padding: 14px; max-width: 900px; margin: auto; }
        header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #1e293b; padding-bottom: 10px; margin-bottom: 15px; }
        h1 { color: #38bdf8; font-size: 1.1rem; }
        .badge { background: #065f46; color: #34d399; padding: 4px 8px; border-radius: 4px; font-size: 0.75rem; border: 1px solid #10b981; }
        .tabs { display: flex; gap: 6px; margin-bottom: 15px; overflow-x: auto; padding-bottom: 4px; }
        .tab-btn { background: #0b0f19; color: #94a3b8; border: 1px solid #1e293b; padding: 8px 14px; border-radius: 4px; cursor: pointer; font-family: monospace; font-size: 0.75rem; white-space: nowrap; }
        .tab-btn:hover { color: #38bdf8; border-color: #334155; }
        .tab-btn.active { background: #0f172a; color: #38bdf8; border-color: #38bdf8; font-weight: bold; }
        .grid { display: grid; grid-template-columns: 1fr; gap: 15px; }
        @media(min-width: 600px) { .grid { grid-template-columns: 1fr 1fr; } }
        .card { background: #0b0f19; border: 1px solid #1e293b; border-radius: 6px; padding: 14px; position: relative; }
        .card.full { grid-column: 1 / -1; }
        .card::before { content: ''; position: absolute; top: 0; left: 0; width: 3px; height: 100%; background: #38bdf8; border-radius: 3px 0 0 3px; }
        h3 { color: #93c5fd; font-size: 0.9rem; margin-bottom: 10px; border-bottom: 1px dashed #1e293b; padding-bottom: 5px; }
        label { font-size: 0.75rem; color: #94a3b8; display: block; margin-bottom: 5px; }
        input { width: 100%; background: #020408; color: #38bdf8; border: 1px solid #334155; border-radius: 4px; padding: 8px; font-family: monospace; font-size: 0.8rem; outline: none; margin-bottom: 8px; }
        button { background: #2563eb; color: #ffffff; border: none; padding: 10px; border-radius: 4px; cursor: pointer; font-weight: bold; font-family: monospace; width: 100%; font-size: 0.8rem; margin-bottom: 6px; }
        button:hover { opacity: 0.85; }
        button.special { background: #7c3aed; }
        pre { background: #020408; color: #34d399; padding: 10px; border-radius: 4px; border: 1px solid #334155; overflow-y: auto; white-space: pre-wrap; font-size: 0.75rem; height: 200px; }
        .stats-row { display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 6px; border-bottom: 1px dotted #1e293b; padding-bottom: 4px; }
        .stats-val { color: #facc15; }
        .time { color: #64748b; }
        .meter { background: #020408; border: 1px solid #334155; height: 10px; border-radius: 2px; margin-bottom: 10px; overflow: hidden; }
        .meter-fill { background: #38bdf8; height: 100%; width: 45%; transition: width 0.3s ease; }
    </style>
</head>
<body>
    <header>
        <h1>🛡️ Mega Poland Wetr'vi</h1>
        <div class="badge">Sanctuary Core ONLINE</div>
    </header>

termux-open index.html

       }

        .badge {
            background: #042f2e;                                        color: #2dd4bf;
            padding: 6px 10px;                                          border-radius: 2px;
            font-size: 0.75rem;                                         border: 1px solid #14b8a6;
            box-shadow: 0 0 8px rgba(45, 212, 191, 0.3);            }
                                                                    /* Pasek Zakładek (Tabs) */
        .tabs {
            display: flex;
            gap: 8px;
            margin-bottom: 15px;
            overflow-x: auto;
            padding-bottom: 6px;                                    }
                                                                    .tab-btn {                                                      background: #090d16;
            color: #64748b;
            border: 1px solid #1e293b;
            padding: 10px 16px;
            border-radius: 3px;
            cursor: pointer;
            font-family: 'Share Tech Mono', monospace;
            font-size: 0.8rem;                                          white-space: nowrap;
            transition: all 0.3s ease;                                  letter-spacing: 0.5px;
        }                                                   
        .tab-btn:hover {
            color: #38bdf8;
            border-color: #0284c7;
            box-shadow: 0 0 8px rgba(2, 132, 199, 0.3);
        }

        .tab-btn.active {
            background: #082f49;
            color: #38bdf8;
            border-color: #38bdf8;
            box-shadow: 0 0 12px rgba(56,189,248,0.4);
            font-weight: bold;
        }

        /* Karty Główne */
        .panel-card {
            display: none;
            background: rgba(8, 12, 20, 0.95);
            border: 1px solid #1e293b;                                  border-radius: 4px;
            padding: 18px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.8);
            position: relative;
        }

        .panel-card.active { display: block; }

        /* Neonowa krawędź karty */
        .panel-card::before {                                           content: '';
            position: absolute;
            top: 0; left: 0; width: 4px; height: 100%;
            background: #38bdf8;
            box-shadow: 0 0 10px #38bdf8;
        }
                                                                    h3 {
            color: #93c5fd;
            font-size: 1rem;
            margin-bottom: 14px;
            border-bottom: 1px dashed #1e293b;
            padding-bottom: 8px;
            letter-spacing: 0.5px;
        }
                                                                    label { font-size: 0.8rem; color: #94a3b8; display: block; margin-bottom: 6px; }
                                                                    input, textarea {
            width: 100%;                                                background: #010306;
            color: #38bdf8;                                             border: 1px solid #334155;
            border-radius: 2px;
            padding: 10px;
            font-family: 'Share Tech Mono', monospace;
            font-size: 0.85rem;
            outline: none;
            margin-bottom: 12px;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.6);
        }

        input:focus, textarea:focus {
            border-color: #38bdf8;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.6), 0 0 8px rgba(56,189,248,0.3);
        }

        button {                                                        background: #0284c7;
            color: #ffffff;
            border: none;
            padding: 11px;
            border-radius: 2px;
            cursor: pointer;
            font-weight: bold;
            font-family: 'Share Tech Mono', monospace;
            width: 100%;
            font-size: 0.85rem;
            margin-bottom: 10px;
            transition: all 0.2s;
            letter-spacing: 1px;
            box-shadow: 0 0 10px rgba(2, 132, 199, 0.4);
        }

        button:hover {
            background: #0369a1;
            box-shadow: 0 0 15px rgba(2, 132, 199, 0.7);
        }                                                                                                                       button.secondary { background: #1e293b; box-shadow: none; color: #cbd5e1; }
        button.secondary:hover { background: #334155; box-shadow: 0 0 10px rgba(100,116,139,0.4); }

        button.special { background: #7c3aed; box-shadow: 0 0 10px rgba(124, 58, 237, 0.5); }
        button.special:hover { background: #6d28d9; box-shadow: 0 0 15px rgba(124, 58, 237, 0.8); }

        pre {
            background: #010306;
            color: #34d399;
            padding: 12px;
            border-radius: 2px;
            border: 1px solid #1e293b;
            overflow-y: auto;
            white-space: pre-wrap;
            font-size: 0.8rem;
            height: 210px;
            box-shadow: inset 0 2px 6px rgba(0,0,0,0.8);
        }

        .stats-row {
            display: flex;
            justify-content: space-between;
            font-size: 0.85rem;
            margin-bottom: 10px;
            border-bottom: 1px dotted #1e293b;
            padding-bottom: 6px;
        }
        .stats-val { color: #facc15; text-shadow: 0 0 6px rgba(250,204,21,0.4); }
        .time { color: #64748b; }

        /* Paski postępu / obciążenia rdzenia */
        .load-bar-container {                                           background: #010306;
            border: 1px solid #1e293b;
            height: 12px;
            border-radius: 2px;
            margin-bottom: 12px;
            overflow: hidden;
            position: relative;
        }
        .load-bar-fill {
            background: linear-gradient(90deg, #0284c7, #38bdf8);
            height: 100%;
            width: 42%;
            box-shadow: 0 0 8px #38bdf8;
            transition: width 0.4s ease;
        }                                                       </style>                                                </head>
<body>
    <header>
        <h1>🛡️ Mega Poland Wetr'vi</h1>                              <div class="badge">HUD v5.0 // ONLINE</div>
    </header>                                               
    <div class="tabs">                                              <button class="tab-btn active" onclick="switchTab(event, 'tab-console')">⚙️ [01] Konsola</button>                        <button class="tab-btn" onclick="switchTab(event, 'tab-telemetry')">📊 [02] Telemetria</button>
        <button class="tab-btn" onclick="switchTab(event, 'tab-threads')">🧵 [03] Wątki</button>
        <button class="tab-btn" onclick="switchTab(event, 'tab-exorpero')">⚛️ [04] Exorpero</button>
        <button class="tab-btn" onclick="switchTab(event, 'tab-vault')">🗄️ [05] Vault</button>                               </div>
                                                                <!-- Karta 1 -->
    <div id="tab-console" class="panel-card active">                <h3>Główny Terminal Rozkazów</h3>
        <label>Pakiet / Payload:</label>                            <textarea id="consoleInp" rows="3">{"modul": "Sanctuary HUD", "status": "Ready"}</textarea>
        <button onclick="sendConsoleCmd()">WYŚLIJ PAKIET DO RDZENIA</button>
        <pre id="consoleLog"><span class="time">[INIT]</span> Połączenie z terminalem nawiązane pomyślnie...</pre>
    </div>
                                                                <!-- Karta 2 -->
    <div id="tab-telemetry" class="panel-card" style="border-left-color: #facc15;">
        <h3 style="color: #facc15;">Telemetria i Obciążenie Magistrali</h3>
        <div class="stats-row"><span>Architekt:</span> <span class="stats-val">Mr.Mekrix</span></div>                           <div class="stats-row"><span>Przepustowość szyny:</span> <span class="stats-val">99.9%</span></div>
        <div class="stats-row"><span>Opóźnienie bazowe:</span> <span class="stats-val">0.31 ms</span></div>

        <label style="margin-top: 15px;">Obciążenie rdzenia C# / C++:</label>
        <div class="load-bar-container"><div class="load-bar-fill" id="coreLoad"></div></div>

        <div class="stats-row"><span>Stan obwodu:</span> <span style="color: #34d399;">ZSYNCHRONIZOWANY</span></div>
    </div>                                                  
> cat << 'EOF' > run_sanctuary_v5.sh
#!/bin/bash                                                 cat << 'HTMLEOF' > index.html                               <!DOCTYPE html>                                             <html lang="pl">                                            <head>                                                          <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mr.Mekrix | Sanctuary HUD v5.0</title>
    <style>                                                         @import url('https://fonts.googleapis.com/css2?family=Share+Tech+Mono&display=swap');                           
        * { box-sizing: border-box; margin: 0; padding: 0; }
                                                                    body {
            background-color: #020408;                                  color: #38bdf8;                                             font-family: 'Share Tech Mono', monospace;
            padding: 14px;                                              max-width: 950px;
            margin: auto;
            position: relative;
            overflow-x: hidden;
        }                                                   
        /* Efekt siatki tła (Cyberpunk Grid) */                     body::before {                                                  content: " ";
            display: block;
            position: fixed;                                            top: 0; left: 0; bottom: 0; right: 0;                       background: linear-gradient(rgba(18, 16, 16, 0) 50%, rgba(0, 0, 0, 0.25) 50%), linear-gradient(90deg, rgba(255, 0, 0, 0.03), rgba(0, 255, 0, 0.01), rgba(0, 0, 255, 0.03));                                                                     z-index: 999;                                               background-size: 100% 4px, 6px 100%;
            pointer-events: none;
        }                                                   
        header {                                                        display: flex;
            justify-content: space-between;                             align-items: center;
            border-bottom: 2px solid #0284c7;                           padding-bottom: 12px;
            margin-bottom: 15px;
            background: rgba(3, 7, 18, 0.8);                            box-shadow: 0 0 15px rgba(2, 132, 199, 0.2);            }
                                                                    h1 {
            color: #38bdf8;                                             font-size: 1.2rem;                                          text-shadow: 0 0 10px rgba(56,189,248,0.6);                 letter-spacing: 1px;
        }

        .badge {                                                        background: #042f2e;                                        color: #2dd4bf;                                             padding: 6px 10px;
            border-radius: 2px;                                         font-size: 0.75rem;
            border: 1px solid #14b8a6;
            box-shadow: 0 0 8px rgba(45, 212, 191, 0.3);
        }

        /* Pasek Zakładek (Tabs) */
        .tabs {
            display: flex;
            gap: 8px;
            margin-bottom: 15px;
            overflow-x: auto;
            padding-bottom: 6px;
        }

        .tab-btn {
            background: #090d16;                                        color: #64748b;
            border: 1px solid #1e293b;                                  padding: 10px 16px;
            border-radius: 3px;                                         cursor: pointer;
            font-family: 'Share Tech Mono', monospace;                  font-size: 0.8rem;
            white-space: nowrap;
            transition: all 0.3s ease;
            letter-spacing: 0.5px;
        }

        .tab-btn:hover {                                                color: #38bdf8;
            border-color: #0284c7;                                      box-shadow: 0 0 8px rgba(2, 132, 199, 0.3);
        }                                                   
        .tab-btn.active {
            background: #082f49;
            color: #38bdf8;
            border-color: #38bdf8;
            box-shadow: 0 0 12px rgba(56,189,248,0.4);                  font-weight: bold;
        }

        /* Karty Główne */
        .panel-card {
            display: none;
            background: rgba(8, 12, 20, 0.95);
            border: 1px solid #1e293b;
            border-radius: 4px;
            padding: 18px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.8);
            position: relative;
        }                                                   
        .panel-card.active { display: block; }

        /* Neonowa krawędź karty */                                 .panel-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 4px; height: 100%;
            background: #38bdf8;                                        box-shadow: 0 0 10px #38bdf8;
        }

        h3 {
            color: #93c5fd;
            font-size: 1rem;
            margin-bottom: 14px;                                        border-bottom: 1px dashed #1e293b;                          padding-bottom: 8px;
            letter-spacing: 0.5px;
        }                                                                                                                       label { font-size: 0.8rem; color: #94a3b8; display: block; margin-bottom: 6px; }                                                                                                    input, textarea {
            width: 100%;                                                background: #010306;                                        color: #38bdf8;
            border: 1px solid #334155;
            border-radius: 2px;                                         padding: 10px;
            font-family: 'Share Tech Mono', monospace;                  font-size: 0.85rem;
            outline: none;                                              margin-bottom: 12px;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.6);            }

        input:focus, textarea:focus {                                   border-color: #38bdf8;                                      box-shadow: inset 0 2px 4px rgba(0,0,0,0.6), 0 0 8px rgba(56,189,248,0.3);
        }                                                                                                                       button {                                                        background: #0284c7;
            color: #ffffff;
            border: none;
            padding: 11px;
            border-radius: 2px;                                         cursor: pointer;                                            font-weight: bold;                                          font-family: 'Share Tech Mono', monospace;
            width: 100%;                                                font-size: 0.85rem;
            margin-bottom: 10px;
            transition: all 0.2s;
            letter-spacing: 1px;
            box-shadow: 0 0 10px rgba(2, 132, 199, 0.4);
        }

        button:hover {
            background: #0369a1;
            box-shadow: 0 0 15px rgba(2, 132, 199, 0.7);
        }

        button.secondary { background: #1e293b; box-shadow: none; color: #cbd5e1; }
        button.secondary:hover { background: #334155; box-shadow: 0 0 10px rgba(100,116,139,0.4); }                                                                                         button.special { background: #7c3aed; box-shadow: 0 0 10px rgba(124, 58, 237, 0.5); }
        button.special:hover { background: #6d28d9; box-shadow: 0 0 15px rgba(124, 58, 237, 0.8); }
                                                                    pre {
            background: #010306;
            color: #34d399;
            padding: 12px;
            border-radius: 2px;
            border: 1px solid #1e293b;
            overflow-y: auto;                                           white-space: pre-wrap;
            font-size: 0.8rem;                                          height: 210px;                                              box-shadow: inset 0 2px 6px rgba(0,0,0,0.8);
        }                                                                                                                       .stats-row {
            display: flex;                                              justify-content: space-between;                             font-size: 0.85rem;
            margin-bottom: 10px;
            border-bottom: 1px dotted #1e293b;
            padding-bottom: 6px;
        }
        .stats-val { color: #facc15; text-shadow: 0 0 6px rgba(250,204,21,0.4); }
        .time { color: #64748b; }                           
        /* Paski postępu / obciążenia rdzenia */
        .load-bar-container {
            background: #010306;
            border: 1px solid #1e293b;
            height: 12px;
            border-radius: 2px;
            margin-bottom: 12px;
            overflow: hidden;                                           position: relative;
        }                                                           .load-bar-fill {
            background: linear-gradient(90deg, #0284c7, #38bdf8);
            height: 100%;
            width: 42%;
            box-shadow: 0 0 8px #38bdf8;
            transition: width 0.4s ease;                            }
    </style>
</head>
<body>
    <header>                                                        <h1>🛡️ Mega Poland Wetr'vi</h1>                              <div class="badge">HUD v5.0 // ONLINE</div>
    </header>

    <div class="tabs">
        <button class="tab-btn active" onclick="switchTab(event, 'tab-console')">⚙️ [01] Konsola</button>                        <button class="tab-btn" onclick="switchTab(event, 'tab-telemetry')">📊 [02] Telemetria</button>                         <button class="tab-btn" onclick="switchTab(event, 'tab-threads')">🧵 [03] Wątki</button>
        <button class="tab-btn" onclick="switchTab(event, 'tab-exorpero')">⚛️ [04] Exorpero</button>                             <button class="tab-btn" onclick="switchTab(event, 'tab-vault')">🗄️ [05] Vault</button>
    </div>
                                                                <!-- Karta 1 -->
    <div id="tab-console" class="panel-card active">
        <h3>Główny Terminal Rozkazów</h3>
        <label>Pakiet / Payload:</label>                            <textarea id="consoleInp" rows="3">{"modul": "Sanctuary HUD", "status": "Ready"}</textarea>                             <button onclick="sendConsoleCmd()">WYŚLIJ PAKIET DO RDZENIA</button>
        <pre id="consoleLog"><span class="time">[INIT]</span> Połączenie z terminalem nawiązane pomyślnie...</pre>          </div>

    <!-- Karta 2 -->                                            <div id="tab-telemetry" class="panel-card" style="border-left-color: #facc15;">                                             <h3 style="color: #facc15;">Telemetria i Obciążenie Magistrali</h3>                                                     <div class="stats-row"><span>Architekt:</span> <span class="stats-val">Mr.Mekrix</span></div>                           <div class="stats-row"><span>Przepustowość szyny:</span> <span class="stats-val">99.9%</span></div>
        <div class="stats-row"><span>Opóźnienie bazowe:</span> <span class="stats-val">0.31 ms</span></div>             
        <label style="margin-top: 15px;">Obciążenie rdzenia C# / C++:</label>                                                   <div class="load-bar-container"><div class="load-bar-fill" id="coreLoad"></div></div>                                                                                               <div class="stats-row"><span>Stan obwodu:</span> <span style="color: #34d399;">ZSYNCHRONIZOWANY</span></div>
    </div>

    <!-- Karta 3 -->
    <div id="tab-threads" class="panel-card" style="border-left-color: #34d399;">                                               <h3 style="color: #34d399;">Symulator Kolejki Wątków (Background Workers)</h3>
        <button onclick="toggleThreads()" id="threadBtn" class="secondary">URUCHOM STRUMIEŃ WĄTKÓW</button>
        <pre id="threadLog"><span class="time">[INIT]</span> Kolejka w tle w gotowości...</pre>
    </div>

    <!-- Karta 4 -->
    <div id="tab-exorpero" class="panel-card" style="border-left-color: #c084fc;">
        <h3 style="color: #c084fc;">Koniunktura Bezdystrybucyjna (Exorpero + Rixim)</h3>
        <button onclick="triggerExorpero()" class="special">WYWOŁAJ IMPULS EXORPERO</button>
        <button onclick="triggerRixim()" style="background: #0d9488; box-shadow: 0 0 10px rgba(13,148,136,0.5);">SYNCHRONIZACJA RIXIM (0-DIST)</button>
        <pre id="exorperoLog"><span class="time">[INIT]</span> Obwody reakcji bezpośredniej włączone...</pre>               </div>

    <!-- Karta 5 -->                                            <div id="tab-vault" class="panel-card" style="border-left-color: #2dd4bf;">                                                 <h3 style="color: #2dd4bf;">Magazyn Danych Trwałych (Vault)</h3>
        <label>Z

cat << 'EOF' > run_sanctuary_hybrid.sh
#!/bin/bash
cat << 'HTMLEOF' > index.html                               <!DOCTYPE html>
<html lang="pl">                                            <head>
> pkg install python -y 2>/dev/null                                                                                     cat << 'HTMLEOF' > index.html
<!DOCTYPE html>                                             <html lang="pl">                                            <head>                                                          <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mr.Mekrix | Sanctuary Hybrid Core</title>
    <style>                                                         * { box-sizing: border-box; margin: 0; padding: 0; }                                                                    body { background-color: #030508; color: #e2e8f0; font-family: monospace; padding: 14px; max-width: 900px; margin: auto; }
        header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #1e293b; padding-bottom: 10px; margin-bottom: 15px; }
        h1 { color: #38bdf8; font-size: 1.1rem; }
        .badge { background: #065f46; color: #34d399; padding: 4px 8px; border-radius: 4px; font-size: 0.75rem; border: 1px solid #10b981; }                                                .tabs { display: flex; gap: 6px; margin-bottom: 15px; overflow-x: auto; padding-bottom: 4px; }
        .tab-btn { background: #0b0f19; color: #94a3b8; border: 1px solid #1e293b; padding: 8px 14px; border-radius: 4px; cursor: pointer; font-family: monospace; font-size: 0.75rem; white-space: nowrap; }
        .tab-btn:hover { color: #38bdf8; border-color: #334155; }
        .tab-btn.active { background: #0f172a; color: #38bdf8; border-color: #38bdf8; font-weight: bold; }
        .grid { display: grid; grid-template-columns: 1fr; gap: 15px; }
        @media(min-width: 600px) { .grid { grid-template-columns: 1fr 1fr; } }
        .card { background: #0b0f19; border: 1px solid #1e293b; border-radius: 6px; padding: 14px; position: relative; }                                                                    .card.full { grid-column: 1 / -1; }
        .card::before { content: ''; position: absolute; top: 0; left: 0; width: 3px; height: 100%; background: #38bdf8; border-radius: 3px 0 0 3px; }
        h3 { color: #93c5fd; font-size: 0.9rem; margin-bottom: 10px; border-bottom: 1px dashed #1e293b; padding-bottom: 5px; }
        label { font-size: 0.75rem; color: #94a3b8; display: block; margin-bottom: 5px; }
        input { width: 100%; background: #020408; color: #38bdf8; border: 1px solid #334155; border-radius: 4px; padding: 8px; font-family: monospace; font-size: 0.8rem; outline: none; margin-bottom: 8px; }
        button { background: #2563eb; color: #ffffff; border: none; padding: 10px; border-radius: 4px; cursor: pointer; font-weight: bold; font-family: monospace; width: 100%; font-size: 0.8rem; margin-bottom: 6px; }
        button:hover { opacity: 0.85; }                             button.special { background: #7c3aed; }                     pre { background: #020408; color: #34d399; padding: 10px; border-radius: 4px; border: 1px solid #334155; overflow-y: auto; white-space: pre-wrap; font-size: 0.75rem; height: 200px; }                                                          .stats-row { display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 6px; border-bottom: 1px dotted #1e293b; padding-bottom: 4px; }                        .stats-val { color: #facc15; }
        .time { color: #64748b; }                                   .meter { background: #020408; border: 1px solid #334155; height: 10px; border-radius: 2px; margin-bottom: 10px; overflow: hidden; }
        .meter-fill { background: #38bdf8; height: 100%; width: 45%; transition: width 0.3s ease; }
    </style>                                                </head>
<body>                                                          <header>
        <h1>🛡️ Mega Poland Wetr'vi</h1>                              <div class="badge">Hybrid Sanctuary Core</div>
    </header>
                                                                <div class="tabs">                                              <button class="tab-btn active" onclick="switchView('view-main')">⚙️ Główny Panel</button>
        <button class="tab-btn" onclick="switchView('view-exorpero')">⚛️ Exorpero + Rixim</button>
        <button class="tab-btn" onclick="switchView('view-vault')">🗄️ Vault Logi</button>                                    </div>                                                  
    <div id="view-main" class="grid">
        <div class="card">                                              <h3>⚙️ Konsola Rozkazów</h3>                                 <label>Instrukcja dla rdzenia:</label>                      <input type="text" id="cmdInput" value="Inicjalizacja hybrydowego obwodu #Mr.Mekrix">
            <button onclick="runCmd()">WYŚLIJ ROZKAZ</button>
        </div>                                                                                                                  <div class="card" style="border-left-color: #facc15;">
            <h3>📊 Telemetria i Obciążenie</h3>                         <div class="stats-row"><span>Architekt:</span> <span class="stats-val">Mr.Mekrix</span></div>
            <div class="stats-row"><span>Przepustowość:</span> <span class="stats-val">100%</span></div>
            <label style="margin-top: 6px;">Obciążenie rdzenia C# / C++:</label>
            <div class="meter"><div class="meter-fill" id="coreMeter"></div></div>
        </div>

        <div class="card full">
            <h3>📜 Dziennik Zdarzeń Systemowych</h3>
            <pre id="mainLog"><span class="time">[INIT]</span> System gotowy pod adresem http://localhost:8080...</pre>
        </div>
    </div>
                                                                <div id="view-exorpero" class="grid" style="display: none;">
        <div class="card full" style="border-left-color: #c084fc;">
            <h3 style="color: #c084fc;">⚛️ Koniunktura Bezdystrybucyjna</h3>
            <button onclick="triggerExo()" class="special">WYWOŁAJ IMPULS EXORPERO</button>
            <button onclick="triggerRix()" style="background: #0d9488;">SYNCHRONIZACJA RIXIM (0-DIST)</button>
            <pre id="exoLog"><span class="time">[INIT]</span> Obwody reakcji bezpośredniej w gotowości...</pre>                 </div>
    </div>                                                  
    <div id="view-vault" class="grid" style="display: none;">
        <div class="card full" style="border-left-color: #34d399;">                                                                 <h3 style="color: #34d399;">🗄️ Pamięć Trwała (Vault)</h3>
            <label>Nowy wpis do pamięci:</label>
            <input type="text" id="vaultInp" value="Dane sesji zabezpieczone lokalnie">
            <button onclick="saveVault()" style="background: #059669;">ZAPISZ TRWALE W SYSTEMIE</button>
            <pre id="vaultLog"><span class="time">[INIT]</span> Magazyn danych aktywny...</pre>                                 </div>
    </div>

    <script>
        function switchView(viewId) {
            document.getElementById('view-main').style.display = 'none';                                                            document.getElementById('view-exorpero').style.display = 'none';                                                        document.getElementById('view-vault').style.display = 'none';                                               
            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));

            document.getElementById(viewId).style.display = 'grid';
            event.currentTarget.classList.add('active');
        }

        function runCmd() {
            const val = document.getElementById('cmdInput').value;
            const log = document.getElementById('mainLog');
            const time = new Date().toLocaleTimeString();
            log.innerHTML += `\n<span class="time">[${time}]</span> [CMD] Wykonano: "${val}"`;                                      log.scrollTop = log.scrollHeight;
        }

        function triggerExo() {                                         const log = document.getElementById('exoLog');
            const time = new Date().toLocaleTimeString();
            log.innerHTML += `\n<span class="time">[${time}]</span> [EXORPERO] Impuls korelacyjny 99.96% bez dystrybucji.`;
            log.scrollTop = log.scrollHeight;
        }
                                                                    function triggerRix() {                                         const log = document.getElementById('exoLog');
            const time = new Date().toLocaleTimeString();
            log.innerHTML += `\n<span class="time">[${time}]> pkill -f "http.server"
cat << 'HTMLEOF' > index.html
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">                                      <meta name="viewport" content="width=device-width, initial-scale=1.0">                                                  <title>Mr.Mekrix | Sanctuary Core</title>                   <style>                                                         * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background-color: #030508; color: #e2e8f0; font-family: monospace; padding: 14px; max-width: 900px; margin: auto; }
        header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #1e293b; padding-bottom: 10px; margin-bottom: 15px; }
        h1 { color: #38bdf8; font-size: 1.1rem; }
        .badge { background: #065f46; color: #34d399; padding: 4px 8px; border-radius: 4px; font-size: 0.75rem; border: 1px solid #10b981; }
        .tabs { display: flex; gap: 6px; margin-bottom: 15px; overflow-x: auto; padding-bottom: 4px; }
        .tab-btn { background: #0b0f19; color: #94a3b8; border: 1px solid #1e293b; padding: 8px 14px; border-radius: 4px; cursor: pointer; font-family: monospace; font-size: 0.75rem; white-space: nowrap; }
        .tab-btn:hover { color: #38bdf8; border-color: #334155; }                                                               .tab-btn.active { background: #0f172a; color: #38bdf8; border-color: #38bdf8; font-weight: bold; }                      .grid { display: grid; grid-template-columns: 1fr; gap: 15px; }                                                         @media(min-width: 600px) { .grid { grid-template-columns: 1fr 1fr; } }
        .card { background: #0b0f19; border: 1px solid #1e293b; border-radius: 6px; padding: 14px; position: relative; }
        .card.full { grid-column: 1 / -1; }
        .card::before { content: ''; position: absolute; top: 0; left: 0; width: 3px; height: 100%; background: #38bdf8; border-radius: 3px 0 0 3px; }
        h3 { color: #93c5fd; font-size: 0.9rem; margin-bottom: 10px; border-bottom: 1px dashed #1e293b; padding-bottom: 5px; }
        label { font-size: 0.75rem; color: #94a3b8; display: block; margin-bottom: 5px; }
        input { width: 100%; background: #020408; color: #38bdf8; border: 1px solid #334155; border-radius: 4px; padding: 8px; font-family: monospace; font-size: 0.8rem; outline: none; margin-bottom: 8px; }
        button { background: #2563eb; color: #ffffff; border: none; padding: 10px; border-radius: 4px; cursor: pointer; font-weight: bold; font-family: monospace; width: 100%; font-size: 0.8rem; margin-bottom: 6px; }
        button:hover { opacity: 0.85; }
        button.special { background: #7c3aed; }
        pre { background: #020408; color: #34d399; padding: 10px; border-radius: 4px; border: 1px solid #334155; overflow-y: auto; white-space: pre-wrap; font-size: 0.75rem; height: 200px; }
        .stats-row { display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 6px; border-bottom: 1px dotted #1e293b; padding-bottom: 4px; }
        .stats-val { color: #facc15; }
        .time { color: #64748b; }
        .meter { background: #020408; border: 1px solid #334155; height: 10px; border-radius: 2px; margin-bottom: 10px; overflow: hidden; }
        .meter-fill { background: #38bdf8; height: 100%; width: 45%; transition: width 0.3s ease; }
    </style>
</head>
<body>
    <header>
        <h1>🛡️ Mega Poland Wetr'vi</h1>
        <div class="badge">Sanctuary Core ONLINE</div>
    </header>
> termux-open index.html
pkill -f "http.server" && rm -f index.html start.sh

cat << 'EOF' > setup.sh
#!/bin/bash
cat << 'HTMLEOF' > index.html
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mr.Mekrix | Sanctuary Core</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { background: #030508; color: #e2e8f0; font-family: monospace; padding: 14px; max-width: 900px; margin: auto; }
        header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #1e293b; padding-bottom: 10px; margin-bottom: 15px; }
        h1 { color: #38bdf8; font-size: 1.1rem; }
        .badge { background: #065f46; color: #34d399; padding: 4px 8px; border-radius: 4px; font-size: 0.75rem; border: 1px solid #10b981; }
        .tabs { display: flex; gap: 6px; margin-bottom: 15px; overflow-x: auto; }
        .tab-btn { background: #0b0f19; color: #94a3b8; border: 1px solid #1e293b; padding: 8px 14px; border-radius: 4px; cursor: pointer; font-family: monospace; font-size: 0.75rem; white-space: nowrap; }
        .tab-btn.active { background: #0f172a; color: #38bdf8; border-color: #38bdf8; font-weight: bold; }
        .grid { display: grid; grid-template-columns: 1fr; gap: 15px; }
        @media(min-width: 600px) { .grid { grid-template-columns: 1fr 1fr; } }
        .card { background: #0b0f19; border: 1px solid #1e293b; border-radius: 6px; padding: 14px; position: relative; }
        .card.full { grid-column: 1 / -1; }
        .card::before { content: ''; position: absolute; top: 0; left: 0; width: 3px; height: 100%; background: #38bdf8; }
        h3 { color: #93c5fd; font-size: 0.9rem; margin-bottom: 10px; border-bottom: 1px dashed #1e293b; padding-bottom: 5px; }
        label { font-size: 0.75rem; color: #94a3b8; display: block; margin-bottom: 5px; }
        input { width: 100%; background: #020408; color: #38bdf8; border: 1px solid #334155; border-radius: 4px; padding: 8px; font-family: monospace; font-size: 0.8rem; margin-bottom: 8px; outline: none; }
        button { background: #2563eb; color: #ffffff; border: none; padding: 10px; border-radius: 4px; cursor: pointer; font-weight: bold; font-family: monospace; width: 100%; font-size: 0.8rem; margin-bottom: 6px; }
        button.special { background: #7c3aed; }
        pre { background: #020408; color: #34d399; padding: 10px; border-radius: 4px; border: 1px solid #334155; overflow-y: auto; white-space: pre-wrap; font-size: 0.75rem; height: 180px; }
        .stats-row { display: flex; justify-content: space-between; font-size: 0.8rem; margin-bottom: 6px; border-bottom: 1px dotted #1e293b; padding-bottom: 4px; }
        .stats-val { color: #facc15; }
        .time { color: #64748b; }
        .meter { background: #020408; border: 1px solid #334155; height: 10px; border-radius: 2px; margin-bottom: 10px; overflow: hidden; }
        .meter-fill { background: #38bdf8; height: 100%; width: 45%; transition: width 0.3s ease; }
    </style>
</head>
<body>
    <header>
        <h1>🛡️ Mega Poland Wetr'vi</h1>
        <div class="badge">Sanctuary Core ONLINE</div>
    </header>
    
    <div class="tabs">
        <button class="tab-btn active" onclick="switchView('view-main', this)">⚙️ Główny Panel</button>
        <button class="tab-btn" onclick="switchView('view-exorpero', this)">⚛️ Exorpero + Rixim</button>
        <button class="tab-btn" onclick="switchView('view-vault', this)">🗄️ Vault Logi</button>
    </div>

    <div id="view-main" class="grid">
        <div class="card">
            <h3>⚙️ Konsola Rozkazów</h3>
            <label>Instrukcja dla rdzenia:</label>
            <input type="text" id="cmdInput" value="Inicjalizacja hybrydowa #Mr.Mekrix">
            <button onclick="runCmd()">WYŚLIJ ROZKAZ</button>
        </div>

        <div class="card" style="border-left-color: #facc15;">
            <h3>📊 Telemetria i Obciążenie</h3>
            <div class="stats-row"><span>Architekt:</span> <span class="stats-val">Mr.Mekrix</span></div>
            <div class="stats-row"><span>Status serwera:</span> <span class="stats-val" style="color: #34d399;">STABILNY</span></div>
            <label style="margin-top: 6px;">Obciążenie rdzenia C# / C++:</label>
            <div class="meter"><div class="meter-fill" id="coreMeter"></div></div>
        </div>

        <div class="card full">
            <h3>📜 Dziennik Zdarzeń Systemowych</h3>
            <pre id="mainLog"><span class="time">[INIT]</span> Panel Sanctuary uruchomiony pomyślnie...</pre>
        </div>
    </div>

    <div id="view-exorpero" class="grid" style="display: none;">
        <div class="card full" style="border-left-color: #c084fc;">
            <h3 style="color: #c084fc;">⚛️ Koniunktura Bezdystrybucyjna</h3>
            <button onclick="triggerExo()" class="special">WYWOŁAJ IMPULS EXORPERO</button>
            <button onclick="triggerRix()" style="background: #0d9488;">SYNCHRONIZACJA RIXIM (0-DIST)</button>
            <pre id="exoLog"><span class="time">[INIT]</span> Obwody reakcji bezpośredniej w gotowości...</pre>
        </div>
    </div>

    <div id="view-vault" class="grid" style="display: none;">
        <div class="card full" style="border-left-color: #34d399;">
            <h3 style="color: #34d399;">🗄️ Pamięć Trwała (Vault)</h3>
            <label>Nowy wpis do pamięci:</label>
            <input type="text" id="vaultInp" value="Dane sesji zabezpieczone lokalnie">
            <button onclick="saveVault()" style="background: #059669;">ZAPISZ TRWALE W SYSTEMIE</button>
            <pre id="vaultLog"><span class="time">[INIT]</span> Magazyn danych aktywny...</pre>
        </div>
    </div>

    <script>
        function switchView(viewId, btn) {
            document.getElementById('view-main').style.display = 'none';
            document.getElementById('view-exorpero').style.display = 'none';
            document.getElementById('view-vault').style.display = 'none';
            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
            document.getElementById(viewId).style.display = 'grid';
            btn.classList.add('active');
        }

        function runCmd() {
            const val = document.getElementById('cmdInput').value;
            const log = document.getElementById('mainLog');
            const time = new Date().toLocaleTimeString();
            log.innerHTML += `\n<span class="time">[${time}]</span> [CMD] Wykonano: "${val}"`;
            log.scrollTop = log.scrollHeight;
        }

        function triggerExo() {
            const log = document.getElementById('exoLog');
            const time = new Date().toLocaleTimeString();
            log.innerHTML += `\n<span class="time">[${time}]</span> [EXORPERO] Impuls 99.96% bez dystrybucji.`;
            log.scrollTop = log.scrollHeight;
        }

        function triggerRix() {
            const log = document.getElementById('exoLog');
            const time = new Date().toLocaleTimeString();
            log.innerHTML += `\n<span class="time">[${time}]</span> [RIXIM] Zamknięcie obwodu reakcji 0.0ms.`;
            log.scrollTop = log.scrollHeight;
        }

        function saveVault() {
            const val = document.getElementById('vaultInp').value;
            const log = document.getElementById('vaultLog');
            const time = new Date().toLocaleTimeString();
            log.innerHTML += `\n<span class="time">[${time}]</span> [VAULT] Zapisano: "${val}"`;
            log.scrollTop = log.scrollHeight;
        }

        setInterval(() => {
            const fill = document.getElementById('coreMeter');
            if(fill) {
                const val = Math.floor(Math.random() * 40) + 30;
                fill.style.width = val + '%';
            }
        }, 2000);
    </script>
</body>
</html>
HTMLEOF
termux-open index.html
