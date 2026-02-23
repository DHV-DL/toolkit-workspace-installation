# Orchestrator – Automatische Agent-Routinen

> Macht den Workspace lebendig: Agents laufen im Hintergrund,
> Ergebnisse liegen bereit wenn du bereit bist.

## Schnellstart

```bash
# 1. Ausführbar machen
chmod +x orchestrator/orchestrator.sh

# 2. Terminal 2 in VS Code öffnen (Ctrl+Shift+`)
# 3. Daemon starten
./orchestrator/orchestrator.sh daemon
```

Das war's. Der Orchestrator steuert jetzt alles:

```
08:00  Donna verarbeitet Mails → Briefing
08:05  Harvey erstellt Tagesplan → journal/
08:00  Louis Fristen-Check (nur Montags)
09:00  Erster Pulse-Check
09:30  Pulse...
10:00  Pulse...
...    (alle 30 Min während Arbeitszeit)
17:00  Katrina Tagesabschluss
17:05  Harold Quick Health Check
16:00  Jessica Wochenbericht (nur Freitags)
16:30  Harold Full Health Check (nur Freitags)
```

## Modi

| Befehl | Was passiert |
|--------|-------------|
| `daemon` | Läuft dauerhaft in Terminal 2, steuert alles automatisch |
| `morning` | Einmal Donna → Harvey (für Cron oder manuell) |
| `pulse` | Einmal Inbox + Tasks + Staging prüfen |
| `evening` | Einmal Katrina → Harold (für Cron oder manuell) |
| `friday` | Einmal Jessica → Harold Full (für Cron oder manuell) |
| `install` | Cron-Jobs installieren (Alternative zu daemon) |
| `uninstall` | Cron-Jobs entfernen |
| `status` | Zeigt was heute schon lief |

## Daemon vs. Cron

**Daemon (empfohlen zum Start):**
- Läuft in VS Code Terminal 2 — du siehst was passiert
- Steuert alle Routinen + Pulse automatisch
- Stirbt wenn VS Code schließt (Lösung: tmux)

**Cron (empfohlen für Dauerbetrieb):**
- `./orchestrator.sh install` → läuft im Hintergrund
- Überlebt Terminal-Schließen
- macOS: Full Disk Access für cron nötig
- Output in `journal/.orchestrator/cron.log`

## VS Code Setup

```
┌─────────────────────────────────────┐
│ VS Code                              │
│                                       │
│  ┌──────────────┐ ┌────────────────┐ │
│  │ Terminal 1    │ │ Terminal 2     │ │
│  │               │ │                │ │
│  │ > claude      │ │ Orchestrator   │ │
│  │               │ │                │ │
│  │ Dein Chat.    │ │ 08:00 Donna ✓  │ │
│  │ "Was steht    │ │ 08:05 Harvey ✓ │ │
│  │  an?"         │ │ 09:30 Pulse OK │ │
│  │               │ │ 10:00 Pulse: 1 │ │
│  │ Harvey zeigt  │ │   neue Mail... │ │
│  │ Tagesplan...  │ │ 10:30 Pulse OK │ │
│  │               │ │                │ │
│  └──────────────┘ └────────────────┘ │
└───────────────────────────────────────┘
```

**Terminal 1** = Dein interaktiver Chat mit Claude Code
**Terminal 2** = Orchestrator zeigt was im Hintergrund passiert

Du arbeitest in Terminal 1. Terminal 2 ist dein "Radar" — ein Blick genügt.

## Desktop-Notifications

Der Orchestrator sendet Benachrichtigungen bei:
- Morgenroutine fertig → "Tagesplan steht"
- Pulse findet was Neues → "Neue Mail von..."
- Abendroutine fertig → "Tagesabschluss fertig"
- Agent-Fehler → "⚠️ Donna ist fehlgeschlagen"

Funktioniert auf macOS, Linux (mit notify-send) und Windows (WSL).

Deaktivieren: `WORKSPACE_NOTIFICATIONS=false ./orchestrator.sh daemon`

## Konfiguration

Umgebungsvariablen (optional):

```bash
# Projekt-Verzeichnis (Standard: Elternordner von orchestrator/)
export WORKSPACE_PROJECT_DIR=~/mein-projekt

# Workspace-Verzeichnis (Standard: ~/workspace)
export WORKSPACE_DIR=~/workspace

# Pulse-Intervall in Sekunden (Standard: 1800 = 30 Min)
export PULSE_INTERVAL=900  # 15 Minuten

# Notifications aus
export WORKSPACE_NOTIFICATIONS=false
```

## Logs

Alles wird protokolliert in `journal/.orchestrator/`:

```
journal/.orchestrator/
├── orchestrator-2026-02-22.log   # Vollständiges Log (Agent-Outputs)
├── state-2026-02-22.log          # Was heute lief (Duplikat-Schutz)
└── cron.log                      # Cron-Output (wenn Cron installiert)
```

## Kosten-Hinweis

Jeder Pulse = 1 Claude-API-Call. Bei 30-Min-Intervall und 8h Arbeitszeit = ~16 Calls/Tag.
Der Pulse-Prompt ist bewusst schlank gehalten (nur INDEX.md + inbox/ prüfen, keine Deep-Reads).
Morgen + Abend + Freitag kommen dazu = ~20 Calls/Tag an normalen Tagen.

Zum Vergleich: Manuell "Was steht an" tippen kostet den gleichen Call — 
der Orchestrator macht es nur automatisch und regelmäßig.
