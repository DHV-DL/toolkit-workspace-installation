#!/bin/bash
# ============================================================================
# WORKSPACE ORCHESTRATOR
# Steuert alle Agent-Routinen: Morgen, Pulse, Abend, Freitag
#
# Modi:
#   ./orchestrator.sh daemon     → Läuft dauerhaft, 30-Min-Pulse (VS Code Terminal 2)
#   ./orchestrator.sh morning    → Einmal Morgenroutine (Donna → Harvey)
#   ./orchestrator.sh pulse      → Einmal Pulse-Check
#   ./orchestrator.sh evening    → Einmal Abendroutine (Katrina → Harold)
#   ./orchestrator.sh friday     → Einmal Freitags-Routine (Jessica → Harold Full)
#   ./orchestrator.sh install    → Cron-Jobs installieren
#   ./orchestrator.sh uninstall  → Cron-Jobs entfernen
#   ./orchestrator.sh status     → Zeigt was heute schon lief
# ============================================================================

set -euo pipefail

# ── KONFIGURATION ──────────────────────────────────────────────────────────

# Projekt-Verzeichnis (wo CLAUDE.md liegt)
# Wird beim Bootstrap gesetzt. Bis dahin: manuell anpassen.
PROJECT_DIR="${WORKSPACE_PROJECT_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"

# Workspace-Verzeichnis (Google Drive Symlink)
WORKSPACE_DIR="${WORKSPACE_DIR:-$HOME/workspace}"

# Pulse-Intervall in Sekunden (Standard: 30 Minuten)
PULSE_INTERVAL="${PULSE_INTERVAL:-1800}"

# Arbeitszeit (24h Format)
WORK_START=8
WORK_END=18

# Notifications aktivieren (true/false)
NOTIFICATIONS="${WORKSPACE_NOTIFICATIONS:-true}"

# Log-Verzeichnis
LOG_DIR="$WORKSPACE_DIR/journal/.orchestrator"
STATE_FILE="$LOG_DIR/state-$(date +%Y-%m-%d).log"
LOG_FILE="$LOG_DIR/orchestrator-$(date +%Y-%m-%d).log"

# ── HILFSFUNKTIONEN ────────────────────────────────────────────────────────

git_snap() {
    local label="${1:-auto}"
    local date_str=$(date +%Y-%m-%d)
    if [ -d "$WORKSPACE_DIR/.git" ]; then
        cd "$WORKSPACE_DIR" && git add -A 2>/dev/null
        if ! git diff --cached --stat --quiet 2>/dev/null; then
            git commit -m "auto: $date_str $label" --quiet 2>/dev/null
            log "📸 Git Snap: $label"
        fi
    fi
}

ensure_dirs() {
    mkdir -p "$LOG_DIR"
}

log() {
    local msg="$(date '+%H:%M:%S') | $1"
    echo "$msg"
    echo "$msg" >> "$LOG_FILE"
}

log_state() {
    echo "$(date +%Y-%m-%d)-$1" >> "$STATE_FILE"
}

was_done_today() {
    grep -q "$(date +%Y-%m-%d)-$1" "$STATE_FILE" 2>/dev/null
}

is_worktime() {
    local hour=$(date +%H)
    [ "$hour" -ge "$WORK_START" ] && [ "$hour" -lt "$WORK_END" ]
}

is_friday() {
    [ "$(date +%u)" -eq 5 ]
}

# ── NOTIFICATIONS ──────────────────────────────────────────────────────────

notify() {
    local title="$1"
    local message="$2"
    local urgency="${3:-normal}"  # normal | important

    [ "$NOTIFICATIONS" != "true" ] && return 0

    # macOS
    if command -v osascript &>/dev/null; then
        local sound=""
        [ "$urgency" = "important" ] && sound='sound name "Ping"'
        osascript -e "display notification \"$message\" with title \"$title\" $sound" 2>/dev/null || true
        return 0
    fi

    # Linux (Desktop)
    if command -v notify-send &>/dev/null; then
        local urg_flag="normal"
        [ "$urgency" = "important" ] && urg_flag="critical"
        notify-send -u "$urg_flag" "$title" "$message" 2>/dev/null || true
        return 0
    fi

    # Windows (WSL)
    if command -v powershell.exe &>/dev/null; then
        powershell.exe -Command "
            [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > \$null
            \$template = [Windows.UI.Notifications.ToastNotificationManager]::GetTemplateContent([Windows.UI.Notifications.ToastTemplateType]::ToastText02)
            \$template.GetElementsByTagName('text')[0].AppendChild(\$template.CreateTextNode('$title'))
            \$template.GetElementsByTagName('text')[1].AppendChild(\$template.CreateTextNode('$message'))
            [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('Workspace').Show([Windows.UI.Notifications.ToastNotification]::new(\$template))
        " 2>/dev/null || true
        return 0
    fi
}

# ── AGENT-RUNNER ───────────────────────────────────────────────────────────

run_agent() {
    local agent_name="$1"
    local prompt="$2"
    local start_time=$(date +%s)

    log "→ $agent_name startet..."

    # Claude CLI nicht-interaktiv ausführen
    local output
    output=$(cd "$PROJECT_DIR" && claude -p "$prompt" --no-input 2>&1) || {
        log "✗ $agent_name FEHLER (Exit $?)"
        log "  $(echo "$output" | tail -3)"
        notify "⚠️ Workspace" "$agent_name ist fehlgeschlagen" "important"
        return 1
    }

    local duration=$(( $(date +%s) - start_time ))
    local summary=$(echo "$output" | tail -5)

    log "← $agent_name fertig (${duration}s)"
    log "  $summary"

    # Output in Briefing-Log schreiben
    echo "---" >> "$LOG_FILE"
    echo "## $agent_name ($(date '+%H:%M'))" >> "$LOG_FILE"
    echo "$output" >> "$LOG_FILE"
    echo "---" >> "$LOG_FILE"

    echo "$output"
}

# ── ROUTINEN ───────────────────────────────────────────────────────────────

do_morning() {
    if was_done_today "morning"; then
        log "Morgenroutine heute bereits gelaufen. Überspringe."
        return 0
    fi

    log "═══ MORGENROUTINE ═══"
    notify "🌅 Workspace" "Morgenroutine startet..."

    run_agent "Donna" "donna"
    sleep 5
    run_agent "Harvey" "harvey"

    # Montags: Louis Fristen-Check
    if [ "$(date +%u)" -eq 1 ]; then
        sleep 5
        run_agent "Louis" "louis, Fristen-Check"
    fi

    log_state "morning"
    notify "✅ Workspace" "Morgenroutine abgeschlossen. Tagesplan steht." "important"
    git_snap "morgenroutine"
    log "═══ MORGENROUTINE FERTIG ═══"
}

do_pulse() {
    log "── Pulse-Check ──"

    local result
    result=$(run_agent "Pulse" "
Pulse-Check (kurz halten, max 5 Zeilen).
Prüfe NUR via INDEX.md und inbox/:
1. Neue Dateien in inbox/ seit letztem Check?
2. Tasks mit due: heute + status: open die noch nicht im Tagesplan sind?
3. staging_queue_size > 0?
4. Termine in den nächsten 60 Minuten? (M365 MCP)

Wenn NICHTS NEUES: Antworte nur 'Pulse OK – nichts Neues.'
Wenn etwas: Kurze Zusammenfassung, max 5 Zeilen.
Erstelle KEINE Dateien, ändere NICHTS. Nur prüfen und berichten.
") || true

    # Notification nur bei echten Neuigkeiten
    if echo "$result" | grep -qvi "nichts Neues\|Pulse OK\|alles klar"; then
        notify "📬 Workspace" "$(echo "$result" | tail -3 | head -1)" "important"
    fi
}

do_evening() {
    if was_done_today "evening"; then
        log "Abendroutine heute bereits gelaufen. Überspringe."
        return 0
    fi

    log "═══ ABENDROUTINE ═══"
    notify "🌙 Workspace" "Abendroutine startet..."

    run_agent "Katrina" "katrina"
    sleep 5
    run_agent "Harold" "harold quick"

    log_state "evening"
    notify "✅ Workspace" "Abendroutine abgeschlossen." "important"
    git_snap "abendroutine"
    log "═══ ABENDROUTINE FERTIG ═══"
}

do_friday() {
    if was_done_today "friday"; then
        log "Freitags-Routine heute bereits gelaufen. Überspringe."
        return 0
    fi

    log "═══ FREITAGS-ROUTINE ═══"
    notify "📊 Workspace" "Wochenabschluss startet..."

    run_agent "Jessica" "jessica"
    sleep 5
    run_agent "Harold" "harold full"

    log_state "friday"
    notify "✅ Workspace" "Wochenabschluss fertig. Wochenbericht liegt bereit." "important"
    git_snap "freitagsroutine"
    log "═══ FREITAGS-ROUTINE FERTIG ═══"
}

# ── DAEMON-MODUS ───────────────────────────────────────────────────────────

do_daemon() {
    log "╔══════════════════════════════════════════╗"
    log "║  WORKSPACE ORCHESTRATOR – DAEMON MODE    ║"
    log "║  Pulse alle $((PULSE_INTERVAL/60)) Minuten | $WORK_START:00–$WORK_END:00       ║"
    log "║  Ctrl+C zum Beenden                      ║"
    log "╚══════════════════════════════════════════╝"

    # Trap für sauberes Beenden
    trap 'log "Orchestrator beendet."; exit 0' INT TERM

    while true; do
        local hour=$(date +%H)

        # Morgenroutine (einmal, ab WORK_START)
        if [ "$hour" -ge "$WORK_START" ] && ! was_done_today "morning"; then
            do_morning
            sleep 30  # Kurze Pause nach Morgenroutine
        fi

        # Pulse (nur während Arbeitszeit)
        if is_worktime; then
            do_pulse
        fi

        # Abendroutine (einmal, ab 17:00)
        if [ "$hour" -ge 17 ] && ! was_done_today "evening"; then
            do_evening
        fi

        # Freitags-Routine (einmal, ab 16:00)
        if is_friday && [ "$hour" -ge 16 ] && ! was_done_today "friday"; then
            do_friday
        fi

        # Außerhalb Arbeitszeit: längere Pause
        if is_worktime; then
            log "Nächster Pulse in $((PULSE_INTERVAL/60)) Minuten..."
            sleep "$PULSE_INTERVAL"
        else
            log "Außerhalb Arbeitszeit. Nächster Check in 30 Minuten..."
            sleep 1800
        fi
    done
}

# ── CRON INSTALLATION ──────────────────────────────────────────────────────

do_install_cron() {
    local script_path="$(cd "$(dirname "$0")" && pwd)/orchestrator.sh"

    log "Installiere Cron-Jobs..."
    log "Skript: $script_path"
    log "Projekt: $PROJECT_DIR"

    # Bestehende Workspace-Cron-Jobs entfernen
    crontab -l 2>/dev/null | grep -v "# WORKSPACE-ORCHESTRATOR" | crontab - 2>/dev/null || true

    # Neue Jobs hinzufügen
    (crontab -l 2>/dev/null; cat <<EOF

# WORKSPACE-ORCHESTRATOR – Morgenroutine (Mo-Fr 08:00)
0 8 * * 1-5 cd $PROJECT_DIR && $script_path morning >> $LOG_DIR/cron.log 2>&1 # WORKSPACE-ORCHESTRATOR
# WORKSPACE-ORCHESTRATOR – Pulse (Mo-Fr alle 30 Min, 09:00-17:00)
*/30 9-17 * * 1-5 cd $PROJECT_DIR && $script_path pulse >> $LOG_DIR/cron.log 2>&1 # WORKSPACE-ORCHESTRATOR
# WORKSPACE-ORCHESTRATOR – Abendroutine (Mo-Fr 17:00)
0 17 * * 1-5 cd $PROJECT_DIR && $script_path evening >> $LOG_DIR/cron.log 2>&1 # WORKSPACE-ORCHESTRATOR
# WORKSPACE-ORCHESTRATOR – Freitag (Fr 16:00)
0 16 * * 5 cd $PROJECT_DIR && $script_path friday >> $LOG_DIR/cron.log 2>&1 # WORKSPACE-ORCHESTRATOR
EOF
    ) | crontab -

    log "✅ Cron-Jobs installiert:"
    crontab -l | grep "WORKSPACE-ORCHESTRATOR"
    log ""
    log "Hinweis macOS: System Preferences → Privacy → Full Disk Access → cron erlauben"
}

do_uninstall_cron() {
    log "Entferne Workspace Cron-Jobs..."
    crontab -l 2>/dev/null | grep -v "# WORKSPACE-ORCHESTRATOR" | crontab - 2>/dev/null || true
    log "✅ Alle Workspace Cron-Jobs entfernt."
}

# ── STATUS ─────────────────────────────────────────────────────────────────

do_status() {
    echo "╔══════════════════════════════════════════╗"
    echo "║  WORKSPACE ORCHESTRATOR – STATUS         ║"
    echo "╚══════════════════════════════════════════╝"
    echo ""
    echo "Datum:    $(date '+%A, %d.%m.%Y %H:%M')"
    echo "Projekt:  $PROJECT_DIR"
    echo "Workspace: $WORKSPACE_DIR"
    echo ""

    if [ -f "$STATE_FILE" ]; then
        echo "Heute gelaufen:"
        was_done_today "morning" && echo "  ✅ Morgenroutine" || echo "  ⬜ Morgenroutine"
        was_done_today "evening" && echo "  ✅ Abendroutine"  || echo "  ⬜ Abendroutine"
        is_friday && { was_done_today "friday" && echo "  ✅ Freitags-Routine" || echo "  ⬜ Freitags-Routine"; }

        local pulse_count=$(grep -c "Pulse" "$LOG_FILE" 2>/dev/null || echo "0")
        echo "  📡 Pulse-Checks: $pulse_count"
    else
        echo "  Noch keine Aktivität heute."
    fi

    echo ""
    if crontab -l 2>/dev/null | grep -q "WORKSPACE-ORCHESTRATOR"; then
        echo "Cron: ✅ Installiert"
    else
        echo "Cron: ⬜ Nicht installiert (→ ./orchestrator.sh install)"
    fi
    echo ""
}

# ── MAIN ───────────────────────────────────────────────────────────────────

ensure_dirs

case "${1:-help}" in
    daemon)     do_daemon ;;
    morning)    do_morning ;;
    pulse)      do_pulse ;;
    evening)    do_evening ;;
    friday)     do_friday ;;
    install)    do_install_cron ;;
    uninstall)  do_uninstall_cron ;;
    status)     do_status ;;
    *)
        echo "Workspace Orchestrator"
        echo ""
        echo "Usage: $0 <command>"
        echo ""
        echo "Commands:"
        echo "  daemon      Dauerhaft laufen (VS Code Terminal 2)"
        echo "  morning     Morgenroutine (Donna → Harvey → [Louis Mo])"
        echo "  pulse       Einmaliger Pulse-Check"
        echo "  evening     Abendroutine (Katrina → Harold)"
        echo "  friday      Freitags-Routine (Jessica → Harold Full)"
        echo "  install     Cron-Jobs installieren"
        echo "  uninstall   Cron-Jobs entfernen"
        echo "  status      Was lief heute?"
        echo ""
        echo "Empfehlung zum Start:"
        echo "  Terminal 1: claude          (interaktiver Chat)"
        echo "  Terminal 2: $0 daemon"
        ;;
esac
