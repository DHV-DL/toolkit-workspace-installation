# Systeme – Index, Protokolle, Versionierung, Dashboard

---

## 1. INDEX.md – Context-Window-Strategie

### INDEX.md Struktur

```markdown
---
type: index
generated: 2026-02-21T08:10:00
files_total: 247
health_score: 82
health_score_prev: 79
health_trend: down   # up | down | stable (Harold berechnet)
staging_queue: 3     # Einträge in inbox/.staging/ die auf User warten
---

# Workspace Index

## Statistiken
- Tasks: 43 offen, 12 in-progress, 2 blocked, 0 staged, 156 done
- Projekte: 8 ongoing (active), 5 temporal (active), 2 completed
- Kontakte: 34 (22 mit Persona)
- Meetings (letzte 30 Tage): 18
- Dokumente: 67
- Knowledge-Einträge: 15
- Ideen: 12
- OKRs: Q1 2026 (active, 3 Objectives, 9 Key Results)

## Health Score Trend
| Datum       | Score | Delta |
|-------------|-------|-------|
| 2026-02-21  |  82%  |  -3%  |
| 2026-02-14  |  85%  |  +2%  |
| 2026-02-07  |  83%  |   —   |

## ⚠️ Staging Queue (wartet auf dich)
- inbox/.staging/contacts/weber-[Client-Example].md [MED] Neuer Kontakt – relevant?
- inbox/.staging/tasks/2026-02-20_alt-task.md   [LOW] Notion-Import – noch aktuell?
- inbox/.staging/tasks/2026-02-20_alt-task2.md  [LOW] Notion-Import – noch aktuell?
→ "Staging zeigen" für Details | "Staging bestätigen" / "Staging verwerfen"

## Projekte (Quick Reference)
| Slug | Typ | Status | Phase | Offene Tasks | Letzte Aktivität |
|------|-----|--------|-------|-------------|-----------------|
| holding-hr | ongoing | active | — | 3 | 2026-02-20 |
| migration-[Client-Example] | temporal | active | execution | 8 | 2026-02-19 |

## Areas (Quick Reference)
| Area | Dateien | Offene Tasks | Projekte |
|------|---------|-------------|----------|
| telefonie | 23 | 5 | tochter-alpha |
| vertraege | 45 | 2 | holding-finance |

## Letzte Änderungen (heute)
- 08:03 donna: 3 Tasks, 2 Dokumente, 1 Follow-Up
- 08:05 harvey: Tagesplan erstellt

## ⚠️ Überfällige Tasks
- tasks/2026-02-15_vertrag-kuendigen.md (6 Tage, URGENT)

## 🔒 Geblockte Tasks
- tasks/2026-02-18_step2.md blocked_by: tasks/2026-02-18_step1.md

## ⚠️ Verträge mit nahender Frist (90 Tage)
- documents/vertraege/placetel-tochter-alpha.md (cancellation: 31.01.2026 ← VERPASST!)

## ⚠️ Follow-Ups ohne Antwort
- tasks/2026-02-16_follow-up-[Client-Example].md (5 Tage)

## 📡 Kommunikations-Health
| Kontakt | Letzter Kontakt | Status |
|---------|----------------|--------|
| [Client-Example] | 2026-02-18 | 🟢 aktiv |
| keller-anwalt | 2026-01-15 | 🔴 37 Tage |

## ♻️ Recurring Tasks (nächste 7 Tage)
- placetel-rechnung-pruefen: 2026-02-25 (monatlich)

## ⚙️ Agent-Status
| Agent | Letzter Run | Fehler | Warnungen |
|-------|-------------|--------|-----------|
| donna | 2026-02-21 08:03 | 0 | 1 |
| harvey | 2026-02-21 08:05 | 0 | 0 |

## Datei-Lokalisierung
- Tasks zu Projekt → tasks/ filtern nach projects: [slug]
- Geblockte Tasks → tasks/ filtern nach status: blocked
- Staged Items → inbox/.staging/
- Quick Captures → inbox/quick-capture/
- Verträge → documents/vertraege/
- Kontakt → contacts/{slug}.md
- Meeting-Historie → notes/meetings/
- Heutiger Plan → journal/YYYY-MM-DD.md
- Agent-Briefings → journal/.briefings/YYYY-MM-DD/
```

### Index-Generator Prompt

```
INDEX.md aktualisieren:
1. Scanne alle Ordner rekursiv (außer archive/, .git/)
2. Für jede MD-Datei: NUR Frontmatter lesen
3. Zähle pro Typ und Status
4. Überfällige Tasks (due < heute, status: open | in-progress)
5. Geblockte Tasks (status: blocked) + blocked_by referenzieren
6. Staging Queue: inbox/.staging/ zählen + Items auflisten
7. Quick Capture: inbox/quick-capture/ zählen
8. Verträge: valid_until UND cancellation_deadline < heute + 90 Tage
9. Follow-Ups: awaiting_response: true + due erreicht
10. Kommunikations-Health: Aktive Kontakte last_contact > 7/30 Tage
11. Recurring Tasks: next_due in nächsten 7 Tagen
12. Health Score berechnen (Formel: Kapitel 7)
13. Health Trend: vorherigen Wert aus INDEX.md lesen → Delta
14. Agent-Status: letzte Run-Zeit + Fehler aus errors.log
15. generated-Timestamp aktualisieren
```

### Context-Window-Regeln

```
Bei JEDER Anfrage:
1. IMMER zuerst INDEX.md lesen
2. Aus INDEX.md relevante Dateien identifizieren
3. Nur die relevanten Dateien lesen
4. Bei Tasks/Kontakten: zuerst NUR Frontmatter
5. Body nur wenn Inhalt wirklich nötig

NIEMALS alle Tasks/Kontakte/Meetings auf einmal lesen.
STATTDESSEN: INDEX.md → filtern → gezielt lesen.
```

---

## 2. Approval Queue (Staging-System)

### Zweck
Agents dürfen nicht eigenständig destruktiv oder unsicher handeln.
Alles mit Konfidenz [MED] oder [LOW] oder destruktivem Charakter
landet in `inbox/.staging/` zur manuellen Bestätigung.

### Was geht in Staging?

```
IMMER staging:
  - Dateien überschreiben (bestehende Datei neu schreiben)
  - Dateien archivieren / löschen
  - status: completed oder cancelled setzen
  - sensitivity: confidential Dateien anfassen
  - Verträge verarbeiten (louis)
  - Neue Kontakte mit [MED]/[LOW] Konfidenz

NIEMALS staging (direkt schreiben):
  - Neue Dateien erstellen (Tasks, Notes, Quick Captures)
  - Frontmatter-Felder ergänzen (nicht überschreiben)
  - INDEX.md aktualisieren
  - Briefings schreiben
  - Antwort-Drafts erstellen (im Task, nicht als Mail senden)
```

### Staging-Datei-Format

```markdown
---
type: staging
staged_by: donna
staged_at: 2026-02-21T08:03:00
confidence: MED
reason: "Neuer Kontakt Weber – Relevanz unklar"
target: contacts/weber-[Client-Example].md
action: create   # create | overwrite | archive | delete | status_change
original_source: "Mail von h.weber@[Client-Example].de"
---

## Vorgeschlagener Inhalt / Aktion

[Hier steht was der Agent tun würde wenn bestätigt]

## Warum MED/LOW?
Frau Weber ist in der Mail als "Kollegin" erwähnt, aber kein
Hinweis ob sie zukünftig projektrelevant ist.
```

### User-Befehle

```
"Staging zeigen"
  → Alle Dateien in inbox/.staging/ anzeigen mit Zusammenfassung

"Staging zeigen [agent]"
  → Nur Einträge von donna / louis / etc.

"Staging bestätigen [datei|alle]"
  → Agent führt die staged Aktion aus + Datei löschen

"Staging verwerfen [datei|alle]"
  → Staging-Datei löschen, Aktion nicht ausführen

"Staging [n]"
  → Zeige Staging-Eintrag Nummer n im Detail
```

### Harold überwacht Staging

```
Staging-Hygiene:
  Einträge >48h ohne Entscheidung → Warnung in Briefing
  Einträge >7 Tage → Eskalation (Harold erstellt Task für User)
  Leere Staging-Queue nach Bootstrap → ✅ in INDEX.md
```

---

## 3. Konfidenz-System

### Standard-Output-Format für alle Agents

```
Agents geben bei JEDER Zuordnung eine Konfidenz an:

[HIGH] Projekt → migration-[Client-Example]
       (Projekt-Slug direkt im Mail-Thread erwähnt)

[MED]  Kontakt → weber-[Client-Example]
       (Mail-Domain passt, aber kein Eintrag in contacts/)
       → Geht in Staging

[LOW]  Area → vertraege
       (heuristisch aus Stichwort "Vertrag" – bitte bestätigen)
       → Geht in Staging ODER wird im Briefing als Frage aufgelistet
```

### Schwellen (konfigurierbar in .claude/rules/preferences.md)

```yaml
confidence_thresholds:
  auto_apply: HIGH          # Nur HIGH wird direkt angewendet
  staging: MED              # MED geht in Staging
  ask_user: LOW             # LOW wird im Briefing als Frage aufgelistet
  staging_threshold: MED    # Ab wann kommt es in inbox/.staging/
```

### Konfidenz-Quellen

```
HIGH:  Explizit im Text / Frontmatter erwähnt
       Eindeutige Email-Domain → bekannter Kontakt
       Status-Wort im Betreff ("RE: Projekt Migration")

MED:   Domain-Match ohne Kontakt-Eintrag
       Stichwort-Match (nicht eindeutig)
       Mehrere mögliche Projekte, eines wahrscheinlicher

LOW:   Heuristik ohne klaren Beleg
       Neuer Kontext der nicht im Workspace vorhanden ist
       Widerspruch zu bestehendem Frontmatter
```

---

## 4. Fehlerprotokoll & Selbstheilung

### Struktur

```
agents/{name}/errors.log

Format: YYYY-MM-DD HH:MM [LEVEL] Beschreibung
Levels: ERROR | WARN | RETRY | RECOVERED

Beispiel:
2026-02-21 08:03 [WARN] M365 MCP: Timeout beim Abrufen Sent Items
2026-02-21 08:03 [RETRY] M365 MCP: Zweiter Versuch erfolgreich
2026-02-21 08:04 [ERROR] Kontakt [Client-Example] nicht in contacts/ – in Staging
```

### Retry-Regeln

```
MCP-Timeout:          3 Versuche, dann WARN im Briefing
Datei nicht gefunden: 0 Retries, direkt in Briefing als [LOW] markieren
Frontmatter-Fehler:   Harold repariert wenn möglich, sonst WARN
Konfidenz-Konflikt:   In Staging, nie retry
```

### Harold überwacht errors.log (täglich)

```
Quick Check:
  Alle agents/{name}/errors.log lesen
  ERROR-Einträge seit gestern → Warnung in Briefing
  WARN-Häufung (>5 in einem Run) → Task für User

Full Check (freitags):
  Fehler-Trend: Mehr oder weniger Fehler als letzte Woche?
  Welcher Agent hat die meisten Fehler? → Prompt-Optimierung empfehlen
  errors.log nach 30 Tagen rotieren → archive/agent-logs/
```

---

## 5. Zeiterfassung (Frontmatter-nativ)

### Task-Felder

```yaml
---
type: task
# ...bestehende Felder...
time_estimate_h: 2.0   # Schätzung (harvey setzt beim Tagesplan)
time_actual_h: 0       # Ist-Zeit (katrina setzt beim Tagesabschluss)
time_date: ""          # YYYY-MM-DD (katrina setzt)
---
```

### Katrina – Tagesabschluss Zeiterfassung

```
SCHRITT (neu): ZEITERFASSUNG

Für jeden Task der heute erledigt oder bearbeitet wurde:
  "Wie lange hast du an [Task] gearbeitet?" (Schätzung wenn unklar)
  → time_actual_h setzen
  → time_date: heute

Zeiterfassung pro Projekt aggregieren:
  → Summiere time_actual_h aller Tasks mit projects: [slug] + time_date: heute
  → In journal/YYYY-MM-DD.md unter "## Zeiterfassung"
  → Vergleich mit Schätzung: Über/Unterschätzung?

Wenn time_estimate_h und time_actual_h deutlich abweichen (>50%):
  → Notiz für jessica: "Schätzgenauigkeit bei [Projekt] prüfen"
```

### Harvey – Tagesplanung mit Zeitbudget

```
SCHRITT (neu): TAGESKAPAZITÄT

Schätze verfügbare Stunden heute (aus Kalender: Termine abziehen)
Pro Task in der Prioritätsliste: time_estimate_h anzeigen
"Heute ca. X Stunden verfügbar. Geplante Tasks: Y Stunden."
Wenn Y > X: "Achtung: Überbucht. Welche Tasks verschieben?"
```

### Jessica – Schätzgenauigkeit analysieren

```
SCHRITT (neu): SCHÄTZGENAUIGKEIT

Pro Projekt: Durchschnitt (time_actual_h / time_estimate_h)
Ratio > 1.3: "Du unterschätzt [Projekt]-Tasks systematisch um X%"
Ratio < 0.7: "Du überschätzt [Projekt]-Tasks systematisch"
→ Empfehlung für zukünftige Schätzungen
→ In Wochenbericht aufnehmen
```

---

## 6. Task-Abhängigkeiten (blocked_by)

### Frontmatter-Erweiterung

```yaml
---
type: task
status: blocked        # Status wird blocked wenn blocked_by gesetzt
blocked_by:            # Relativer Pfad zur blockierenden Task-Datei
  - tasks/2026-02-18_schritt1.md
blocks:               # (optional) Was blockiert DIESE Task (Rückwärts-Referenz)
  - tasks/2026-02-18_schritt3.md
---
```

### Harvey – Blocking-Awareness

```
Beim Tagesplan:
  Geblockte Tasks anzeigen: "Task X ist geblockt durch Y"
  Prüfen: Ist Y bereits done? → blocked_by entfernen, Status zu open
  Tagesplan-Warnung: "Task Z unblocked wenn du heute Y erledigst"

Tagesplan-Formatierung:
  🔒 [geblockt] Task X (wartet auf: Y)
  ▶️  [freigegeben] Task Y → dann wird X möglich
```

### Harold – Blocking-Integrität

```
Health Check:
  blocked_by verweist auf nicht-existente Datei? → WARN
  blocked_by verweist auf done-Task? → WARN (manuell unblocking vergessen)
  Zirkuläre Abhängigkeit? → ERROR
```

---

## 7. Health Score Berechnung

### Formel

```
Health Score (0-100%) = gewichteter Durchschnitt:

Gewichtung:
  25% Tasks-Hygiene:
      - Keine überfälligen Tasks       → +25
      - Für je 1 überfällige Task      → -3 (max -25)

  20% Inbox-Hygiene:
      - inbox/ leer                    → +20
      - quick-capture/ verarbeitet     → +5 (bonus)
      - Einträge >48h                  → -5 pro Item (max -20)

  20% Kommunikations-Health:
      - Alle aktiven Kontakte <30 Tage → +20
      - Kontakt 7-30 Tage ohne Kontakt → -2 (max -10)
      - Kontakt >30 Tage              → -5 (max -20)

  15% Vertragsfristen:
      - Keine Fristen <90 Tage        → +15
      - Frist <60 Tage               → -5
      - Frist <30 Tage               → -10
      - Frist VERPASST               → -15

  10% Staging-Queue:
      - Queue leer                    → +10
      - 1-3 Einträge                 → +5
      - >3 Einträge                  → 0
      - >10 Einträge                 → -10

  10% Agent-Fehler:
      - Keine ERROR Einträge          → +10
      - ERROR-Einträge letzte 7 Tage → -3 pro Agent

Trend:
  Aktueller Score - letzter Score = Delta
  3 Wochen sinkend → Eskalationswarnung im Briefing
```

### Trend-Tracking (harold schreibt in INDEX.md)

```
Bei jedem Full Check (freitags):
  health_score in INDEX.md → health_score_prev
  Neuen Score berechnen → health_score
  Trend bestimmen: up / down / stable (±2% = stable)
  Bei "3x down in Folge": Task für User "Workspace-Review empfohlen"
```

---

## 8. Recurring-Task-Generator (vollständige Logik)

### Trigger

```
Harold Quick Check (täglich 17:05):
  Scanne tasks/ nach Frontmatter:
    recurrence.next_due <= heute
    UND status: open (nicht bereits done)

Falls gefunden:
  1. Original-Task lesen (vollständige Kopie)
  2. Neue Task-Datei erstellen:
     - Dateiname: YYYY-MM-DD_{original-slug}-{n}.md
       (n = Instanz-Nummer, aus original-slug ableitbar)
     - due: recurrence.next_due (das fällige Datum)
     - created: heute
     - status: open
     - completed: "" (leer)
     - recurrence.next_due: nächster Zyklus (berechnet)
     - recurrence.instance: n+1
  3. Original-Task:
     - recurrence.next_due → nächsten Zyklus setzen
     - recurrence.last_generated: heute
     - Status NICHT ändern (Original bleibt als Template)
  4. Neuen Task in INDEX.md unter "Recurring Tasks" aufnehmen
```

### Zyklusberechnung

```python
# Pseudo-Code
def naechstes_datum(current_due, frequency, day=None):
    if frequency == "daily":
        return current_due + 1 Tag
    if frequency == "weekly":
        return current_due + 7 Tage
    if frequency == "monthly":
        # day = Tag des Monats (z.B. 1 = erster)
        return erster_tag_naechsten_monats + (day - 1) Tage
    if frequency == "quarterly":
        return current_due + 91 Tage
    if frequency == "yearly":
        return current_due + 365 Tage
```

### Kein doppeltes Generieren

```
Prüfen vor Generieren:
  Existiert tasks/*_{original-slug}-*.md mit due: == next_due?
  → Bereits generiert, überspringen
  → WARN in errors.log: "Recurring task already exists"
```

---

## 9. Lifecycle-Phasen

### Frontmatter-Erweiterung (project-temporal.md)

```yaml
---
type: project
project_type: temporal
lifecycle_phase: execution  # initiation|planning|execution|monitoring|closure
lifecycle_phase_since: 2026-01-15
lifecycle_next_review: 2026-03-01
---
```

### Phasen-Definitionen

```
initiation:   Projekt ist genehmigt, Scope noch unklar
planning:     Scope definiert, Tasks erstellt, Team bekannt
execution:    Aktive Umsetzung
monitoring:   Go-Live erfolgt, Nachbetreuung / Hypercare
closure:      Abnahme, Dokumentation, Postmortem
```

### Harvey – Phase-Awareness

```
Beim Tagesplan, für temporal Projekte:
  "migration-[Client-Example] (execution, seit 6 Wochen)"
  Standard-Dauer pro Phase (konfigurierbar in WORKSPACE.md):
    initiation: 1-2 Wochen
    planning:   2-4 Wochen
    execution:  [projektspezifisch]
    monitoring: 2-4 Wochen
    closure:    1-2 Wochen
  Wenn Phase > Erwartung: "Review empfohlen"
```

### Jessica – Lifecycle-Management (freitags)

```
Für jedes temporal Projekt:
  Ist die aktuelle Phase abgeschlossen? → Vorschlag: nächste Phase
  Ist lifecycle_next_review <= heute? → Review-Task erstellen
  status: completed aber Phase nicht closure? → WARN
  Closure-Phase: Postmortem-Template vorschlagen
```

---

## 10. Datensensitivität (Sensitivity-Tier)

### Frontmatter-Feld

```yaml
sensitivity: internal   # public | internal | confidential | restricted
```

### Tier-Definitionen

```
public:       Kann geteilt werden (projects/{slug}/shared/)
internal:     Standard, nur workspace-intern (Default wenn nicht gesetzt)
confidential: Vertragsinhalte, Finanzdaten, personenbezogene Daten
restricted:   Besonders sensibel (Gehaltsinfos, M&A, rechtliche Positionen)
```

### Regeln pro Tier

```
public:       Darf in projects/{slug}/shared/ liegen
              Darf in Kunden-Mails referenziert werden
internal:     Standard. Kein GDrive-Sharing.
confidential: Nicht in Staging (direkte Eskalation zu User)
              Nicht in Git committen ohne explizite Prüfung
              Harold warnt wenn confidential in inbox/ >24h liegt
restricted:   Harold blockiert Staging → immer direkte User-Freigabe
              In INDEX.md nicht inhaltlich aufgeführt (nur Dateiname)
```

### Harold – Sensitivity-Checks

```
Quick Check täglich:
  confidential/restricted Dateien in inbox/ oder quick-capture/ >24h → WARN
  restricted Dateien in inbox/.staging/ → ERROR (sofort zu User eskalieren)
  Dateien in projects/{slug}/shared/ mit sensitivity != public → WARN
```

---

## 11. Inter-Agent-Protokoll (Briefings)

### Ablauf-Kette

```
donna (08:00) → Briefing (Tasks, Drafts, Follow-Ups, Konfidenz-Fragen)
louis (08:00) → Briefing (Fristen, Watchdog) [montags + bei Bedarf]
    ↓
harvey (08:05) → LIEST donna + louis → Tagesplan (mit Zeitbudget + Blocking)
    ↓
[Tagsüber: mike, rachel, lipschitz on demand]
    ↓
katrina (17:00) → Tagesabschluss + Zeiterfassung → Briefing
    ↓
harold (17:05) → Quick Check (+ Recurring + Staging + errors.log)
    ↓
[Freitags:]
jessica (16:00) → LIEST alle Briefings → Wochenbericht + Lifecycle + Schätzgenauigkeit
harold (16:30) → Full Health Check + Metriken + Health Trend
dashboard → HTML generieren
```

### Briefing-Format (alle Agents)

```markdown
---
type: briefing
agent: donna
date: 2026-02-21
run_duration_min: 3
errors: 0
warnings: 1
---

## Zusammenfassung
X Mails verarbeitet. Y Tasks erstellt. Z Drafts.

## Konfidenz-Übersicht
[HIGH] 8 Items direkt verarbeitet
[MED]  2 Items in Staging (weber-[Client-Example], alt-task)
[LOW]  1 Frage für User (siehe unten)

## Neue Tasks
...

## Staging-Einträge
- inbox/.staging/contacts/weber-[Client-Example].md [MED]

## Offene Fragen
- [LOW] Mail von info@unbekannte-firma.de – ignorieren oder Kontakt anlegen?

## Für Harvey
Top 3 Prioritäten: ...

## Fehler / Warnungen
[WARN] M365 Timeout bei Sent Items (automatisch recovered)
```

---

## 12. Git – Rollback & Versionierung

### Initialisierung

```bash
cd ~/workspace
git init

cat > .gitignore << 'EOF'
*.pdf
*.png
*.jpg
*.jpeg
*.gif
*.xlsx
*.pptx
*.docx
*.zip
inbox/
archive/
journal/.briefings/
journal/orchestrator.log
agents/*/errors.log
.env
*.secret
*.key
.DS_Store
Thumbs.db
EOF

git add -A
git commit -m "Initial workspace setup"
```

### Snap-Befehl (interaktiv)

```
"Snap [Beschreibung]" →
1. INDEX.md regenerieren
2. git add -A
3. git commit -m "snapshot: [Beschreibung]"
4. Ausgabe: "✅ Checkpoint gesetzt: [hash] – X Dateien, Y Änderungen"

Empfohlen:
  - Nach manuellen Korrekturen
  - Vor großen Agent-Runs (mike, louis)
  - Nach Bootstrap-Schritten (automatisch)
  - Nach Staging-Bestätigung
```

### Auto-Commit (Orchestrator)

```bash
# Am Ende jedes Orchestrator-Runs:
cd "$WORKSPACE"
git add -A
git diff --cached --stat --quiet || \
  git commit -m "auto: $DATE $RUN_TYPE" --quiet
```

### Rollback

```bash
git log --oneline -10
git diff HEAD~1                    # Was hat sich geändert?
git checkout HEAD~1 -- file.md    # Eine Datei zurücksetzen
```

### Orchestrator-Modell: Reminder statt Executor

```
PRINZIP: Kein Always-On System. Kein Cron der blind ausführt.
Der Cron löst einen Hinweis aus – du entscheidest ob du ihn startest.

WARUM:
  - Kein Always-On VM → keine permanenten API-Kosten
  - Kein Idempotenz-Problem (doppelte Runs unmöglich)
  - Du behältst volle Kontrolle über Ausführungszeitpunkt
  - Donna läuft erst wenn du bereit bist – nicht um 08:00 wenn du im Zug sitzt

WIE:
  1. Cron schreibt .pending-morning-run in workspace/
  2. Du öffnest Claude Code → Harvey sieht die Datei → "Morgenroutine bereit. Starten?"
  3. Du sagst "ja" / "donna" → Routine läuft
  4. Nach Run: .pending-morning-run wird gelöscht

# orchestrator-reminder.sh (Cron: 0 8 * * 1-5)
#!/bin/bash
WORKSPACE=~/workspace
DATE=$(date +%Y-%m-%d)
echo "$DATE" > "$WORKSPACE/.pending-morning-run"
# Optional: macOS Notification
# osascript -e 'display notification "Workspace: Morgenroutine bereit" with title "Harvey"'

FAZIT: Der Workflow ist identisch – nur der Startzeitpunkt liegt bei dir.
```

---

## 13. Dashboard (HTML-Generierung)

```
Generiere ein HTML-Dashboard (Single File, inline CSS + JS).

DATENQUELLEN:
INDEX.md, tasks/, goals/, documents/vertraege/, journal/metrics/, contacts/

SEKTIONEN:
1. HEADER: Datum, Health-Score + Trend-Pfeil, Staging-Queue-Größe
2. TASK-ÜBERSICHT: Donut-Chart + geblockte Tasks
3. OKR-FORTSCHRITT: Balkendiagramm
4. VERTRAGSFRISTEN: Timeline 90 Tage
5. KOMMUNIKATIONS-HEALTH: Kontakte mit Ampel
6. ZEITERFASSUNG: Stunden pro Projekt + Schätzgenauigkeit
7. PROJEKT-KARTEN: mit lifecycle_phase Badge
8. HEALTH TREND: Liniendiagramm letzte 8 Wochen
9. AGENT-STATUS: Letzte Runs, Fehler, Staging-Queue

DESIGN: Dunkles Theme, responsive, keine externen Dependencies.
OUTPUT: journal/dashboard/YYYY-MM-DD.html
```

---

## 14. Test-Fixtures

### Donna-Tests (+ Konfidenz + Staging)

```json
// fixtures/mail-high-confidence.json
{
  "from": "h.[Client-Example]@[Client-Example]-immo.de",
  "subject": "RE: Testmigration Status",
  "body": "Können Sie bis Freitag den Report zusenden?"
}
// Erwartung: [HIGH] → migration-[Client-Example], kein Staging

// fixtures/mail-med-confidence.json
{
  "from": "h.weber@[Client-Example]-immo.de",
  "subject": "Frage zur Migration",
  "body": "Ich bin Kollegin von Herrn [Client-Example]."
}
// Erwartung: [MED] Neuer Kontakt → inbox/.staging/contacts/

// fixtures/mail-staging-required.json
{
  "from": "rechtsanwalt@kanzlei.de",
  "body": "Anbei der geänderte Vertrag.",
  "attachment": "vertrag_v2.pdf"
}
// Erwartung: Anhang → inbox/.staging/ (Vertrag = destructive action)
```

### Harvey-Tests (+ Blocking + Zeitbudget)

```
// fixtures/day-with-blocked-tasks.md
Index: 2 offene Tasks, 1 geblockt (blockiert durch Task X die status:open)
// Erwartung: Harvey zeigt 🔒 Task Y, schlägt vor Task X zuerst zu machen

// fixtures/overbooked-day.md
Kalender: 4h Meetings. Tasks: 6h time_estimate_h gesetzt.
// Erwartung: Harvey warnt "Überbucht: 6h Tasks, nur 4h verfügbar"
```

---

## 15. Claude Memory Integration

### Memory Edits (mobile / claude.ai)

```
1. "Workspace: ~/workspace (GDrive). Quick Capture: '! [Text]' für sofort.
    Komplexes: Lies INDEX.md + WORKSPACE.md."

2. "PARA: Ongoing [SLUGS]. Temporal [SLUGS]. Areas [SLUGS]."

3. "Agents: donna (Mail 08:00), harvey (Plan 08:05), katrina (17:00),
    harold (Health 17:05), jessica (OKR Fr)."

4. "Staging: Bestätigte Aktionen in inbox/.staging/.
    'Staging zeigen' für offene Items."

5. "Context: INDEX.md zuerst. PROFILE.md für Strategie."
```

---

## 16. Feedback-Loop

### Monatliche Retrospektive (jessica)

```
1. Area-Nutzung: Welche nie benutzt?
2. Agent-Qualität: Fehler-Häufung? Staging-Quote pro Agent?
3. Template-Nutzung: Felder >80% leer → rausnehmen
4. Schätzgenauigkeit: time_estimate vs. time_actual Trend
5. Health-Score Trend: Seit wann sinkend?
6. Konfidenz-Verteilung: Viele [LOW]? → Prompts verbessern
7. Staging-Hygiene: Wie lange liegen Items im Staging?
→ journal/retro/YYYY-MM.md
```

### Metriken (harold, freitags)

```markdown
# journal/metrics/YYYY-MM-DD.md
files_total, tasks_open, tasks_done_week, tasks_overdue, tasks_blocked,
tasks_staging, staging_queue_size, staging_avg_age_h,
health_score, health_score_prev, health_trend,
confidence_high_pct, confidence_med_pct, confidence_low_pct,
time_estimated_week_h, time_actual_week_h, estimate_accuracy_pct,
recurring_tasks_generated, errors_total, errors_per_agent,
contacts_without_persona, inbox_pending, quick_capture_pending
```

---

## 17. OneDrive MCP – Altablagen migrieren

```
Staging für ALLE OneDrive-Importe:
  Alle migrierten Dateien landen zuerst in inbox/.staging/onedrive/
  User bestätigt Batch für Batch
  louis validiert Verträge vor Staging-Bestätigung

Migration (mike):
  Schritt 1: Scan + Mapping
  Schritt 2: inbox/.staging/onedrive/ befüllen
  Schritt 3: User bestätigt via "Staging bestätigen [batch]"
  Schritt 4: Korrekte Zielordner
  Schritt 5: Vollständigkeits-Matrix
```

---

## 17b. Notion-Sync – Bidirektionaler Workflow

```
PRINZIP:
  Notion = Team-Interface (Kollegen arbeiten dort)
  Workspace = Dein Interface (du arbeitest hier)
  Keine manuelle Synchronisation – immer via Agent (mike)

RICHTUNG 1: Notion → Workspace (täglich via mike)
  - Delta-Check: Was hat sich in Notion seit gestern geändert?
  - Neue Einträge von Kollegen → tasks/ oder notes/meetings/
  - Konfidenz: [HIGH] klarer Typ + Projekt, [MED] → Staging, [LOW] → Briefing-Frage
  - Frequenz: täglich (Morgenroutine) oder on-demand "mike, notion sync"

RICHTUNG 2: Workspace → Notion (nach harvey oder on-demand)
  - Statusupdates, Entscheidungen, Meeting-Notes
  - harvey oder katrina schreiben zurück via Notion MCP
  - Nur: projects/{slug}/shared-content, nie journal/, contacts/, PROFILE.md
  - Trigger: "sync [projekt-slug] nach notion"

BERECHTIGUNGEN:
  mike liest Notion (alle Seiten des Workspace)
  Schreiben nach Notion: nur mike + explizit freigegebene Projekte
  PROFILE.md, contacts/, journal/ → niemals nach Notion

FEHLERFÄLLE:
  Notion-API nicht erreichbar → Briefing-Hinweis, kein Abbruch
  Konflikte (beide Seiten geändert) → [MED] Staging, User entscheidet
```

---

## 18. Mobile Workflow

### Claude Mobile Memory Instructions

```
"Workspace: ~/workspace in Google Drive.
Aktive Projekte: [SLUGS]. Areas: [SLUGS].

Quick Capture: Schreib '! [Text]' und ich leg es in inbox/quick-capture/.
Brain Dump: Einfach schreiben – ich extrahiere Tasks, Ideen, Entscheidungen.

'Was steht an' → INDEX.md + heutigen Plan lesen."
```

### Claude.ai Chat → Workspace

```
Am Ende eines wertvollen Claude.ai Chats:
1. "Fasse Kernerkenntnisse zusammen als Markdown:
   Datum, Thema, Erkenntnisse, Entscheidungen, Action Items"
2. Ablegen: inbox/claude-chats/{datum}_{thema}.md
3. Donna verarbeitet morgens → Tasks / Ideen / Decisions / Wissen
```

---

## 19. Notion Abschaltung

```
Delta-Check Woche 2 (mike): Änderungen nach Migration → nachmigirieren
Delta-Check Woche 4 (mike): Alle Deltas = 0 → bereit
Finales Archiv: Export → archive/notion-final-YYYY-MM-DD/
Abschaltreihenfolge: Subscription kündigen → 30 Tage → MCP deaktivieren
```

---

## 20. M365 MCP Setup

```
Azure AD App Registration:
1. portal.azure.com → Azure AD → App registrations → New
2. API permissions → Microsoft Graph:
   Mail.ReadWrite, Mail.Send, Calendars.ReadWrite, Contacts.Read,
   Files.ReadWrite.All, Sites.Read.All, User.Read, offline_access
3. Admin consent

Credentials: .env (in .gitignore)
```

---

## 21. Real-World-Szenarien

### Montag Morgen (Claude Code Terminal)

```
> "Was steht an"

[INDEX.md lesen → journal/briefings lesen]

Harvey: Guten Morgen. 3 Termine heute (4h). 15 Tasks (2 überfällig).

⚠️ Staging Queue: 2 Einträge warten auf dich
   → "Staging zeigen" für Details

Top 3:
  1. 🔴 Antwort [Client-Example] (Draft liegt bereit, 6 Tage überfällig)
  2. 🔒 Schritt 2 Migration UNBLOCKED – Schritt 1 ist done
  3. 📋 Placetel-Vertrag: Kündigung bis 31.03. (32 Tage)

Zeitbudget: ~4h verfügbar. Geplante Tasks: ~6h.
Überbucht um 2h – was verschieben?
```

### Quick Capture unterwegs

```
> "! Idee: [ERP System] API als MCP Server wrappen"

✅ inbox/quick-capture/2026-02-21_09-15.md
   type: idea (heuristisch, Donna bestätigt morgens)
```

### Staging nach Louis-Run

```
> "louis, verarbeite Anhang placetel-vertrag.pdf"

[HIGH] Vertrag erkannt → Watchdog-Felder extrahiert
[MED]  Projekt-Zuordnung: tochter-alpha oder holding-finance?
→ Staging: inbox/.staging/documents/placetel-vertrag.md

"Staging zeigen 1"
→ Zeigt Entwurf mit beiden Optionen

"Staging bestätigen 1 → tochter-alpha"
→ Datei wird nach documents/vertraege/ mit projects: [tochter-alpha] geschrieben
```
