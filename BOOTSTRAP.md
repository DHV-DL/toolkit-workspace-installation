# BOOTSTRAP – Interaktiver Setup-Flow

> **Technischer Kontext:** Du läufst als Claude Code im VS Code Terminal.
> Du schreibst direkt in `~/workspace`. Kein Copy-Paste, kein Fenster wechseln.
>
> **Planmodus:** Nach JEDEM Hauptschritt führst du das Planmodus-Protokoll aus.
> Kein Schritt beginnt ohne explizites "OK" des Users.
>
> **Resumption:** Falls `BOOTSTRAP_STATE.md` existiert, lies sie zuerst und
> frage ob du weitermachen oder neu starten sollst.
>
> **Reihenfolge & Parallelisierung:** Siehe IMPLEMENTATION.md für
> die empfohlene Abfolge, MVP-Definition und welche Schritte
> parallel in mehreren Terminals laufen können.

---

## PLANMODUS-PROTOKOLL (nach jedem Schritt ausführen)

```
Nach Abschluss von Schritt N:

═══════════════════════════════════════════════
✅ SCHRITT N ABGESCHLOSSEN
═══════════════════════════════════════════════
Was wurde gemacht:
  → [konkrete Dateien, Entscheidungen, Ergebnisse]

Offene Punkte / Annahmen die ich getroffen habe:
  → [was der User noch bestätigen oder korrigieren sollte]

Widersprüche zu früheren Entscheidungen:
  → [falls keine: "Keine Widersprüche erkannt"]

═══════════════════════════════════════════════
📋 PLAN FÜR SCHRITT N+1: [Name]
═══════════════════════════════════════════════
Was kommt:
  → [2-4 konkrete Aktionen]

Annahmen die ich mache:
  → [was ich voraussetze – User kann korrigieren]

Risiko / was schiefgehen kann:
  → [z.B. "Wenn Notion-Daten unvollständig sind, …"]

BOOTSTRAP_STATE.md wird aktualisiert.
═══════════════════════════════════════════════
Bereit für Schritt N+1? → Warte auf OK.
```

---

## BOOTSTRAP_STATE.md – Resumption-Protokoll

```
Schreibe/aktualisiere nach JEDEM Schritt:

---
bootstrap_version: 1.0
current_step: N
completed_steps: [1, 2, ..., N-1]
status: in_progress   # in_progress | completed
last_updated: YYYY-MM-DD HH:MM

decisions:
  google_drive_path: ""
  slug_convention: ""
  areas: []
  ongoing_projects: []
  temporal_projects: []
  contact_convention: ""
  language: de
  timezone: ""
  currency: EUR

connections:
  notion_mcp: ""          # connected | failed | skipped
  notion_test: ""         # YYYY-MM-DD HH:MM | ""
  m365_mcp: ""            # connected | failed | skipped
  m365_mail_test: ""      # YYYY-MM-DD HH:MM | ""
  m365_calendar_test: ""  # YYYY-MM-DD HH:MM | ""
  azure_app_id: ""        # App Registration ID (kein Secret!)
  onedrive_mcp: ""        # connected | later | not_needed
  other_mcps: []          # Notizen zu weiteren Connections

connections:
  notion_mcp: ""          # connected | failed | skipped
  notion_test: ""         # YYYY-MM-DD HH:MM | ""
  m365_mcp: ""            # connected | failed | skipped
  m365_mail_test: ""      # YYYY-MM-DD HH:MM | ""
  m365_calendar_test: ""  # YYYY-MM-DD HH:MM | ""
  azure_app_id: ""        # App Registration ID (kein Secret!)
  onedrive_mcp: ""        # connected | later | not_needed
  other_mcps: []          # Notizen zu weiteren Connections

orchestrator:
  mode: ""                # daemon | cron | skipped
  pulse_interval: ""      # Sekunden (Standard: 1800)
  notifications: ""       # true | false
  first_morning_test: ""  # YYYY-MM-DD HH:MM
  first_pulse_test: ""    # YYYY-MM-DD HH:MM

pending_confirmations:
  - "Ist Projekt X temporal oder ongoing?"
  - ""

notes:
  - "Notion hat 3 DBs die keine klare Entsprechung im PARA-Modell haben"
  - ""
---

ZWECK: Ermöglicht Resume nach Unterbrechung.
Bei "Wo waren wir?" → Diese Datei lesen → User briefen → Weiter.
```

---

## SCHRITT 1A: Infrastruktur & Grundlagen

```
Frage den User:

1. "Wo ist dein Google Drive gemountet?"
   → macOS: /Volumes/GoogleDrive/My Drive/
   → Windows: G:\My Drive\
   → Linux: ~/GoogleDrive/My Drive/
   → Merke dir den Pfad. workspace/ wird dort liegen.
   → Erstelle Symlink: ln -s "[GDrive-Pfad]/workspace" ~/workspace

2. "Welche Sprache für Kommunikation?" (Default: Deutsch)
3. "Timezone?" (Default: Europe/Berlin)
4. "Gibt es Altsysteme neben Notion?"
   (Trello, Sheets, OneNote, OneDrive-Altablagen)
   → Für jedes: In BOOTSTRAP_STATE.md merken

Prüfe Voraussetzungen:
  - Git installiert?          → git --version
  - Claude Code CLI?          → claude --version
  - Google Drive Sync aktiv?  → Pfad erreichbar?
```

→ BOOTSTRAP_STATE.md anlegen.
→ PLANMODUS-PROTOKOLL ausführen. Warte auf OK.

---

## SCHRITT 1B: Alle Connections einrichten & testen

> ⚠️ ALLE externen Verbindungen müssen stehen BEVOR Daten fließen.
> Donna, Louis, Harvey – sie alle brauchen funktionierende MCP-Server.
> Dieser Schritt ist Pflicht. Kein Agent läuft ohne Connections.

```
CONNECTION 1: Notion MCP Server
─────────────────────────────────
1. "Hast du den Notion MCP Server eingerichtet?"
   → Wenn nein: Hilf beim Setup:
     a) Notion Integration erstellen (notion.so/my-integrations)
     b) API Key generieren
     c) MCP Server konfigurieren in Claude Code settings
     d) Integration mit relevanten Notion-Seiten teilen
   → Wenn ja: Weiter zu Test

2. Verbindungstest:
   → "Liste alle Notion-Datenbanken"
   → Ergebnis: Datenbanken sichtbar? → [HIGH] ✅
   → Fehler? → Troubleshoot (API Key, Sharing, Server-Config)
   → Ergebnis in BOOTSTRAP_STATE.md: notion_mcp: connected | failed

CONNECTION 2: Microsoft 365 MCP Server
─────────────────────────────────────────
1. "Hast du Zugang zum Azure Portal (portal.azure.com)?"
   → Wenn nein: Admin-Zugang klären (ggf. eigener Tenant)
   → Wenn ja: Weiter zu Setup

2. Azure AD App Registration:
   a) portal.azure.com → Azure AD → App registrations → New
   b) Name: "Workspace Claude Integration" (o.ä.)
   c) Redirect URI: je nach MCP-Server-Typ (localhost callback)
   d) API permissions → Microsoft Graph hinzufügen:
      - Mail.ReadWrite        (Donna: Mails lesen + als gelesen markieren)
      - Mail.Send             (Donna: Drafts senden wenn bestätigt)
      - Calendars.ReadWrite   (Harvey: Kalender lesen, Rachel: Termine)
      - Contacts.Read         (Donna: Outlook-Kontakte abgleichen)
      - Files.ReadWrite.All   (Mike: OneDrive-Altablagen, optional)
      - User.Read             (Basis-Berechtigung)
      - offline_access        (Token-Refresh ohne Re-Login)
   e) Admin Consent erteilen (oder Self-Consent wenn eigener Tenant)
   f) Client Secret oder Certificate generieren

3. MCP Server konfigurieren:
   → Credentials in .env (wird später in .gitignore aufgenommen)
   → MCP Server in Claude Code settings eintragen
   → WICHTIG: .env NIEMALS in Git committen

4. Verbindungstest:
   → "Hole meine letzten 3 Mails"
   → Ergebnis: Mails sichtbar? Absender + Betreff korrekt? → [HIGH] ✅
   → "Hole meine Termine für heute"
   → Ergebnis: Kalender lesbar? → [HIGH] ✅
   → Fehler? → Permissions prüfen, Consent prüfen, Token prüfen
   → Ergebnis in BOOTSTRAP_STATE.md: m365_mcp: connected | failed

CONNECTION 3: Weitere MCP-Server (optional, jetzt oder später)
──────────────────────────────────────────────────────────────
"Brauchst du jetzt schon weitere Connections?"
  - OneDrive MCP (für Altablagen-Migration) → Kann auch in Stufe 1
  - Andere SaaS-APIs → Notieren, nicht jetzt einrichten

ERGEBNIS dieses Schritts:
  ✅ Notion MCP: getestet, Datenbanken lesbar
  ✅ M365 MCP: getestet, Mails + Kalender lesbar
  ✅ Credentials sicher abgelegt (.env)
  ✅ Beide Server in Claude Code settings konfiguriert

  Wenn eine Connection NICHT funktioniert:
  → Dokumentiere den Fehler in BOOTSTRAP_STATE.md
  → Bootstrap kann für diesen Kanal trotzdem weitergehen
  → Donna arbeitet dann ohne Mail (nur Inbox-Dateien)
  → Harvey arbeitet dann ohne Kalender (nur Tasks)
  → Aber: Ziel ist BEIDES vor Schritt 2.
```

→ BOOTSTRAP_STATE.md aktualisieren (Connection-Status).
→ PLANMODUS-PROTOKOLL ausführen. Warte auf OK.

---

## SCHRITT 2: Notion scannen

```
Lies das komplette Notion per MCP:

1. Alle Datenbanken: Name, Typ, Anzahl, Properties, Relations
2. Tiefenanalyse pro aktive DB:
   - 3 neueste Einträge als Beispiel
   - Properties >80% befüllt (= wichtig), <20% (= Ballast)
3. Workflow-Erkennung: Relations, Rollups, Formeln, Automationen
4. Inaktive Bereiche: >3 Monate nicht bearbeitet

Konfidenz-Ausgabe:
  [HIGH] DB "Projekte" → klar als PARA-Projekte erkannt
  [MED]  DB "Ressourcen" → unklar, zeige dem User
  [LOW]  DB "Alt-2022" → wahrscheinlich ignorieren, bitte bestätigen

→ ~/workspace/inbox/notion-audit/inventar.md + tiefenanalyse.md
→ Zeig Zusammenfassung mit Konfidenz-Labels.
```

→ BOOTSTRAP_STATE.md aktualisieren (Notion-Scan-Ergebnis).
→ PLANMODUS-PROTOKOLL. Warte auf OK.

---

## SCHRITT 3: Vorschläge & Designentscheidungen

```
Basierend auf Inventar, schlage vor:

A) ONGOING-PROJEKTE → Slugs, Prefix-Konvention
B) TEMPORALE PROJEKTE → Slugs, Parents, Status, migrieren?
C) AREAS → 8-15 konsolidierte Querschnitts-Tags
D) FIELD MAPPING → Pro Notion-DB: Ziel + Property-Mapping
E) STATUS-MAPPING → Notion-Werte → Standard-Werte
F) KONTAKT-KONVENTION → Person/Firma pro Datei, Dateinamen
G) ZUSÄTZLICHE TYPEN → Was passt nicht in Standard-Templates?
H) LIFECYCLE-PHASEN → Welche Projekte brauchen lifecycle_phase?
I) SENSITIVITY-TIERS → Gibt es Daten die sensitivity: confidential brauchen?

Für jeden Punkt: Zeige Vorschlag + Konfidenz + Alternative.
Punkt für Punkt durchgehen. User korrigiert.
```

→ BOOTSTRAP_STATE.md: decisions[] vollständig befüllen.
→ PLANMODUS-PROTOKOLL. Warte auf OK bei JEDEM Punkt.

---

## SCHRITT 4: Ordnerstruktur aufbauen

```
Lies ARCHITECTURE.md Kapitel 1 für die vollständige Struktur.

Erstelle:
- workspace/ Root mit allen Ordnern
- inbox/.staging/  ← NEU: Approval Queue für Agents
- inbox/quick-capture/  ← NEU: "!" Schnelleingabe
- projects/{slug}/ für JEDEN bestätigten Slug
- Alle zentralen Ordner (tasks/, contacts/, notes/ inkl. knowledge/)
- agents/ für alle 9 Agents + orchestrator + dashboard
- journal/ mit .briefings/, metrics/, retro/, dashboard/
- templates/ (alle Templates aus ARCHITECTURE.md Kapitel 2)
- .gitkeep in leere Ordner

Nach Erstellung: Zeige Baumstruktur mit `tree ~/workspace -L 2`.
```

→ BOOTSTRAP_STATE.md aktualisieren.
→ PLANMODUS-PROTOKOLL. Warte auf OK.

---

## SCHRITT 5: Profil & Unternehmen erfassen

```
⚠️ VOR der Konfiguration – dieses Wissen fließt in ALLES ein.
Lies ARCHITECTURE.md Kapitel 2.13 und 2.14 für die Strukturen.

5A) PROFILE.md – Über DICH
Geh Sektion für Sektion:
1. Arbeitsstil (Morgenmensch? Deep Work? Interrupt-Handling?)
2. Entscheidungsstil (schnell/gründlich, Daten/Bauchgefühl?)
3. Kommunikationspräferenzen (kurz/direkt, formell?)
4. Geschäftsprinzipien (was geht gar nicht?)
5. Kernkompetenzen + technischer Stack
6. Bekannte Schwächen die Agents abfangen sollen
7. Persönliche Ziele (1 Jahr / 3 Jahre)

5B) COMPANY.md – Über dein UNTERNEHMEN
1. Name, Rechtsform
2. Holding-Struktur (Baum: Holding → Töchter → Bereiche)
3. Geschäftsmodell + Leistungsportfolio
4. Mission + Vision
5. Strategische Säulen (3-5)
6. Bewusste strategische Entscheidungen ("Nur Property Management")
7. Jahres- und Mittelfristziele
8. Idealer Kunde + wer NICHT
9. Akquise-Kanäle
10. Wettbewerber-Tabelle
11. Positionierung + USPs
12. Risiken + Abhängigkeiten

Leere Sektionen: <!-- TODO --> markieren. Nicht alles muss sofort.

→ Schreibe PROFILE.md + COMPANY.md auf Root-Ebene.
→ Zeig beide Dokumente. Warte auf OK bei BEIDEN.
```

→ BOOTSTRAP_STATE.md aktualisieren.
→ PLANMODUS-PROTOKOLL. Warte auf OK.

---

## SCHRITT 6: Konfiguration generieren

```
6.1 WORKSPACE.md
    - ALLE Projekte + Areas + Konventionen + Workflows
    - Context-Window-Regeln, Agents-Übersicht
    - Natural Language Queries (aus CLAUDE.md ergänzen mit echten Slugs)
    - Command Dictionary: Echte Slugs und Kontaktnamen einsetzen
    - Approval Queue Regeln
    - KEINE Platzhalter!

6.2 CLAUDE.md (für den fertigen Workspace!)
    - Mount-Pfad, PARA-Kurzregeln
    - "INDEX.md zuerst", One-Terminal-Manifest
    - Command Dictionary mit echten Slugs
    - Snap-Befehl konfiguriert

6.3 .claude/rules/preferences.md
    Diese Datei wird von Claude Code AUTOMATISCH bei jedem Chat gelesen.
    Inhalt:
    ```markdown
    # Workspace Preferences

    ## Sprache & Kommunikation
    - Sprache: Deutsch (Workspace-Dateien), Englisch (Code/Commits)
    - Anrede: Du (intern), Sie (extern/Kunden)
    - Timezone: Europe/Berlin
    - Währung: EUR

    ## Arbeitsweise
    - WORKSPACE.md zuerst lesen bei jedem neuen Chat
    - INDEX.md vor jeder Dateisuche konsultieren
    - Konfidenz-System immer anwenden ([HIGH/MED/LOW])
    - [MED] und [LOW] → inbox/.staging/ (nie direkt ausführen)
    - Keine Datei überschreiben ohne Staging oder explizite Anweisung
    - Git Snap nach größeren Änderungen vorschlagen

    ## Konventionen
    - Dateinamen: kebab-case, deutsch, keine Umlaute
    - Frontmatter: YAML, immer am Dateianfang
    - Datumsformat: YYYY-MM-DD
    - Alle Zeitangaben in 24h-Format
    ```
    Sprache, Anrede, Zeitzone, Währung, Konfidenz-Schwellen

6.4 .claude/rules/workflows.md
    Wird ebenfalls automatisch bei jedem Chat gelesen.
    Inhalt:
    ```markdown
    # Workspace Workflows

    ## Quick Commands
    - "donna" → Lies agents/donna/AGENT.md, führe Morgen-Workflow aus
    - "harvey" / "Was steht an" → Lies agents/harvey/AGENT.md, Tagesplan
    - "katrina" → Lies agents/katrina/AGENT.md, Tagesabschluss
    - "Status [slug]" → Projekt-README + offene Tasks + nächster Meilenstein
    - "Wer ist [Name]" → contacts/ durchsuchen, Persona zeigen
    - "Staging zeigen" → inbox/.staging/ auflisten
    - "Staging bestätigen" → Staging-Einträge verarbeiten
    - "Snap [label]" → git add -A && git commit -m "[label]"
    - "! [text]" → Quick Capture nach inbox/quick-capture/

    ## Routing
    - Meetings/Termine → rachel
    - Verträge/Rechnungen/Dokumente → louis
    - Analysen/Recherche → mike
    - Kontakte/Personas → lipschitz
    - Berichte/Retros → jessica
    - System-Health → harold

    ## Regeln
    - Bei jedem neuen Chat: INDEX.md lesen (nicht alle Dateien scannen)
    - Frontmatter ist die einzige Quelle für Metadaten
    - Keine Aktion ohne passenden Agent (kein Freestyle)
    - sensitivity: restricted/confidential → nie in Shared-Ordner
    ```
    Alle Workflows aus ARCHITECTURE.md + Custom-Workflows

6.5 INDEX.md (leere Grundstruktur)

6.6 Alle Templates (aus ARCHITECTURE.md Kapitel 2)
    - task.md: + blocked_by, sensitivity, time_estimate_h, lifecycle_phase
    - contact.md: + sensitivity, preferred_channel
    - project-temporal.md: + lifecycle_phase, lifecycle_since
    - knowledge.md, decision-log.md, postmortem.md
    - Briefing-Template mit Konfidenz-Ausgabe

6.7 OPT-IN FEATURES (Frage explizit – empfohlene Reihenfolge):

    "Möchtest du Zeiterfassung aktivieren?"
    → Empfehlung: NEIN in Woche 1-2. Erst wenn das System
      läuft und du Donna + Harvey täglich nutzt.
    → Bei JA: time_estimate_h + time_actual_h in task.md aktiv
    → Bei NEIN: Felder auskommentiert in Templates,
      katrina fragt nicht nach Zeiten, jessica analysiert nicht

    "Möchtest du Lifecycle-Phasen für Projekte aktivieren?"
    → Empfehlung: NEIN wenn <3 parallele temporale Projekte.
    → Bei JA: lifecycle_phase in project-temporal.md aktiv,
      jessica macht Lifecycle-Check freitags
    → Bei NEIN: Felder auskommentiert, jessica überspringt Lifecycle

→ Zeig WORKSPACE.md komplett. Warte auf OK.
```

→ BOOTSTRAP_STATE.md aktualisieren.
→ PLANMODUS-PROTOKOLL. Warte auf OK.

---

## SCHRITT 7: Kontakte migrieren (Notion + Outlook Merge)

```
⚠️ KONTAKTE ZUERST – werden von allem anderen referenziert!

1. Lies ALLE Kontakte aus Notion per MCP
2. Lies Outlook-Kontakte per M365 MCP (falls M365 eingerichtet)
3. Merge-Strategie:
   - Gleiche Person in beiden? → Outlook-Email/Phone führend,
     Notion-Projekte/Areas führend
   - Nur in Outlook? → Nur importieren wenn business-relevant
   - Nur in Notion? → Normal migrieren
4. Konfidenz pro Kontakt:
   [HIGH] Eindeutige Zuordnung
   [MED]  Mögliches Duplikat – zeigen und fragen
   [LOW]  Relevanz unklar – fragen ob importieren

5. Zeig 3 Vorschauen (mit Contact-Template inkl. Persona-Sektion)
6. Warte auf OK → alle [HIGH] automatisch, [MED]/[LOW] bestätigen
7. Live-Vergleich: Anzahl Notion vs. Workspace

STAGING: [MED] und [LOW] Kontakte → inbox/.staging/contacts/
→ "Staging zeigen" → User entscheidet einzeln
```

→ BOOTSTRAP_STATE.md aktualisieren.
→ PLANMODUS-PROTOKOLL. Warte auf OK.

---

---

## SCHRITT 7b: Mail & Kalender Backfill (empfohlen)

> Optional aber empfohlen. Holt die letzten 90 Tage Mail- und
> Kalenderhistorie ins System. Ohne Backfill kennt Donna keine
> offenen Threads, Harvey keine überfälligen Follow-Ups, und
> Lipschitz hat keine Kommunikationshistorie für Personas.
> Dauer: 30–60 Min (je nach Mailvolumen).

```
7b.1 KONTAKT-FREQUENZ AUS KALENDER (schnell, 5 Min)
     "Lies meine Kalendereinträge der letzten 90 Tage per M365 MCP.
      Extrahiere alle Teilnehmer. Zähle Häufigkeit pro Person.
      Zeig Top 20 – wer fehlt noch in contacts/?"

     → Neue Kontakte aus Kalender-Teilnehmern anlegen [MED] → Staging
     → Bestehende Kontakte: last_contact aus letztem gemeinsamen Termin
     → Output: Tabelle (Name | Häufigkeit | Im Workspace? | last_contact)

7b.2 OFFENE THREADS FINDEN (Kern, 15–30 Min)
     "Lies meine Mails der letzten 90 Tage per M365 MCP.
      Finde Threads wo ICH der letzte Empfänger war und NICHT
      geantwortet habe. Gruppiere nach Alter (>7d, >14d, >30d)."

     Konfidenz:
       [HIGH] Klarer offener Thread, Absender erwartet Antwort
       [MED]  Unklar ob Antwort nötig (CC, Newsletter, Notification)
       [LOW]  Wahrscheinlich keine Antwort nötig

     → [HIGH] → Follow-Up-Tasks erstellen mit:
       - title: "Antwort ausstehend: {Betreff}"
       - source: mail-backfill
       - source_ref: Message-ID
       - priority: urgent (>30d) | high (>14d) | medium (>7d)
       - contacts: [Absender-Slug]
       - follow_up_since: YYYY-MM-DD (Datum der letzten Mail)
     → [MED] → inbox/.staging/backfill/ → User entscheidet
     → [LOW] → Im Report auflisten, nicht als Task

     Output: "X offene Threads gefunden (Y urgent, Z high, W medium).
     N in Staging zur Prüfung."

7b.3 OFFENE ACTION ITEMS EXTRAHIEREN (optional, 10–15 Min)
     "Durchsuche die letzten 90 Tage nach Mails die explizite
      Handlungsaufforderungen an mich enthalten:
      Signalwörter: bitte, bis, können Sie, deadline, warten auf,
      anbei zur Prüfung, brauche Ihre Rückmeldung

      NUR Mails zeigen wo die Handlung wahrscheinlich noch offen ist
      (kein späterer Thread der das auflöst)."

     → Tasks erstellen analog zu 7b.2
     → Deduplizierung: Wenn Thread schon aus 7b.2 bekannt → nicht doppelt

7b.4 KONTAKT-KOMMUNIKATIONSHISTORIE (schnell, 5 Min)
     Für alle in Schritt 7 migrierten Kontakte:
     → last_contact aus Mail-/Kalenderhistorie setzen
     → communication_frequency ableiten (wöchentlich/monatlich/selten)
     → Lipschitz: Kurznotiz pro Kontakt wenn Muster erkennbar
       ("Antwortet immer innerhalb 2h", "Schreibt nur montags")

7b.5 ZUSAMMENFASSUNG
     "Backfill abgeschlossen:
      - X offene Threads → Tasks erstellt
      - Y Action Items → Tasks erstellt
      - Z Kontakte mit last_contact aktualisiert
      - N neue Kontakte aus Kalender in Staging
      → 'Staging zeigen' für Backfill-Einträge"

WICHTIG:
- KEINE alten Mails als vollständige Tasks importieren (kein Archiv!)
- NUR offene/ausstehende Dinge extrahieren
- Alles Abgeschlossene ignorieren
- Mail-Inhalte NICHT in tasks/ speichern (nur Referenz via source_ref)
- sensitivity: internal für alle Backfill-Tasks
```

→ BOOTSTRAP_STATE.md aktualisieren:
  mail_backfill: completed | partial | skipped
  backfill_range_days: 90
  open_threads_found: X
  action_items_found: Y
  contacts_enriched: Z
→ Snap "nach mail-backfill"
→ PLANMODUS-PROTOKOLL. Warte auf OK.

---

## SCHRITT 8: Projekte einzeln aufsetzen + befüllen

```
⚠️ PROJEKT FÜR PROJEKT – nicht alle auf einmal!

Frage: "Welches Projekt hat den meisten Handlungsbedarf?"

Für JEDES Projekt:

8.1 README.md aus Notion-Daten + Template
    - lifecycle_phase: aus Kontext ableiten [HIGH/MED/LOW]
    - sensitivity: setzen falls Kundendaten

8.2 Tasks migrieren (nur status != done)
    - Konfidenz: [HIGH] klarer Task, [MED] unklar ob noch relevant
    - [MED] Tasks → inbox/.staging/ → User entscheidet
    - Zeig 3 Vorschauen → OK → alle [HIGH]

8.3 Meeting-Notes (letzte 3-6 Monate)

8.4 Dokumente + Markdown-Companions
    - Louis: Verträge mit Watchdog-Feldern analysieren
    - sensitivity: confidential für Vertragsdetails prüfen

8.5 Status Quo erfassen → README ergänzen

8.6 Abnahme: "Status [projekt-slug]" → Ausgabe zeigen

Fortschritt tracken:
  ✅ migration-[Client-Example]: 12 Tasks, 4 Meetings, 3 Docs
  ⬜ holding-hr: noch offen

→ Snap "nach projekt-[slug] migration" nach jedem Projekt.
→ OK nach jedem Projekt.
```

→ BOOTSTRAP_STATE.md aktualisieren.
→ PLANMODUS-PROTOKOLL. Warte auf OK nach jedem Projekt.

---

## SCHRITT 9: Übergreifende Inhalte

```
9.1 Tasks ohne Projektzuordnung → User fragen
    [HIGH] klar zuordenbar → direkt setzen
    [MED/LOW] → inbox/.staging/ → User entscheidet

9.2 Ideen → notes/ideas/
9.3 Sonstige Notion-Inhalte → Migrieren / Archivieren / Ignorieren?
9.4 Vollständigkeits-Matrix pro DB
```

→ PLANMODUS-PROTOKOLL. Warte auf OK.

---

## SCHRITT 10: Knowledge Base aufbauen

```
10.1 "Gibt es Entscheidungen die du dokumentieren möchtest?"
     → notes/knowledge/decisions/ mit decision-log.md Template
     → Z.B. "Warum [ERP System] statt [Legacy System]?"

10.2 "Gibt es How-Tos die du immer wieder brauchst?"
     → notes/knowledge/howto/

10.3 "Gibt es Lessons Learned aus abgeschlossenen Projekten?"
     → notes/knowledge/learnings/

10.4 "Gibt es technische Dokumentation die nirgendwo steht?"
     → notes/knowledge/tech/

Es ist OK wenn das erstmal wenig ist – wächst organisch.
```

→ PLANMODUS-PROTOKOLL. Warte auf OK.

---

## SCHRITT 11: OKRs aufsetzen

```
Falls in Notion vorhanden → migrieren nach goals/
Falls nicht → "Hast du Quartalsziele? Möchtest du OKRs?"
Wenn nein: Überspringen.
```

→ PLANMODUS-PROTOKOLL. Warte auf OK.

---

## SCHRITT 12: Agents anlegen

```
Lies AGENTS.md für alle 9 Agent-Definitionen.

Für JEDEN Agent:
- agents/{name}/AGENT.md  (mit Konfidenz-System Anweisungen)
- agents/{name}/config.yaml
- agents/{name}/errors.log  ← NEU (leer, Harold überwacht)
- agents/{name}/tests/ (leer)

Plus:
- agents/README.md mit Übersichtstabelle + Eskalationsmatrix
- agents/orchestrator.sh + orchestrator-evening.sh + orchestrator-friday.sh
- agents/dashboard/DASHBOARD.md

ESKALATIONSMATRIX (in agents/README.md):
  Autonom:   Frontmatter setzen, Tags vorschlagen, Drafts schreiben,
             INDEX.md aktualisieren, Quick-Capture verarbeiten
  Fragt:     Neue Kontakte anlegen, Tasks mit priority:urgent,
             [MED]/[LOW] Konfidenz-Items
  Staging:   Dateien überschreiben, Archivieren, status:completed setzen,
             Dateien löschen, Verträge verarbeiten
  Eskaliert: Alles mit sensitivity:confidential, Fehler > 3 retries

→ Zeig Agent-Übersicht + Eskalationsmatrix. Warte auf OK.
```

→ BOOTSTRAP_STATE.md aktualisieren.
→ PLANMODUS-PROTOKOLL. Warte auf OK.

---

## SCHRITT 13: Projekt-Kickstart-Templates

```
"Welche Projekt-Typen legst du regelmäßig neu an?"

Pro Typ:
- templates/project-kickstart/{typ}/README.md
- templates/project-kickstart/{typ}/standard-tasks.md
  → Tasks mit blocked_by Abhängigkeiten wo sinnvoll
  → lifecycle_phase: initiation als Start
  → time_estimate_h für Standard-Tasks (aus Erfahrung)

Typische Typen: migration, evaluation, onboarding
```

→ PLANMODUS-PROTOKOLL. Warte auf OK.

---

## SCHRITT 14: Skills anlegen

> Lies SKILLS-LONGLIST.md für die vollständige Liste aller 23 Skills.
> Skills definieren WIE Agents arbeiten — ohne Skills raten sie bei jedem Output.
> Nicht alle Skills müssen sofort befüllt werden. MVP-Skills sind Pflicht,
> der Rest wächst mit den Ausbaustufen.

```
PHASE MVP – Diese 6 Skills JETZT befüllen (mit User-Input):

14.1 skills/inbound-triage/SKILL.md
     "Welche E-Mails sind sofort wichtig? Was kann weg?
      Welche Absender-Domains gehören zu welchen Projekten?
      Wann ist eine Mail urgent vs. normal?"

14.2 skills/dokument-eingang/SKILL.md
     "Wie benennst du Dokumente? Was muss in einem MD-Companion stehen?
      Wann geht ein Dokument an Louis (Vertrag) vs. direkt in die Ablage?"

14.3 skills/email-stil/SKILL.md
     "Wie ist dein E-Mail-Stil? Signatur? 3-5 Beispiel-Mails?
      Verbotene Floskeln? Wann Du, wann Sie?"

14.4 skills/kanalregeln/SKILL.md
     "Pro Kanal (Email/Teams/WhatsApp/Telefon):
      Max Länge, Tonalität, Formalität, wann welcher Kanal?"

14.5 skills/dokument-ablage/SKILL.md
     "Dateinamen-Konvention bestätigen. Wann neue Datei vs. Update?
      Welche Ordner für welche Dokumenttypen?"

14.6 skills/task-erstellung/SKILL.md
     "Wie sollen Task-Titel formuliert sein? Wann ist etwas urgent?
      Wann soll ein großer Task aufgesplittet werden?"

STRUKTUR – Leere SKILL.md für spätere Phasen anlegen:

14.7 Für alle übrigen Skills (07-23): Leere SKILL.md mit TODO-Marker
     erstellen, damit die Ordnerstruktur steht:

     skills/follow-up-management/SKILL.md      → "<!-- TODO: Stufe 1 -->"
     skills/eskalation-kommunikation/SKILL.md   → "<!-- TODO: Stufe 1 -->"
     skills/brief-formal/SKILL.md               → "<!-- TODO: Stufe 3 -->"
     skills/vertrag-analyse/SKILL.md            → "<!-- TODO: Stufe 1 -->"
     skills/rechnung-verarbeitung/SKILL.md      → "<!-- TODO: Stufe 1 -->"
     skills/projekt-kickstart/SKILL.md          → "<!-- TODO: Stufe 2 -->"
     skills/projekt-status/SKILL.md             → "<!-- TODO: Stufe 2 -->"
     skills/uebergabe-dokument/SKILL.md         → "<!-- TODO: Stufe 3 -->"
     skills/tagesplanung/SKILL.md               → "<!-- TODO: Stufe 1 -->"
     skills/meeting-vorbereitung/SKILL.md       → "<!-- TODO: Stufe 1 -->"
     skills/meeting-protokoll/SKILL.md          → "<!-- TODO: Stufe 1 -->"
     skills/meeting-nachbereitung/SKILL.md      → "<!-- TODO: Stufe 2 -->"
     skills/kontakt-persona/SKILL.md            → "<!-- TODO: Stufe 1 -->"
     skills/reporting/SKILL.md                  → "<!-- TODO: Stufe 2 -->"
     skills/presentation-ci/SKILL.md            → "<!-- TODO: Stufe 2 -->"
     skills/sop-erstellung/SKILL.md             → "<!-- TODO: Stufe 2 -->"
     skills/cross-source-recherche/SKILL.md     → "<!-- TODO: Stufe 3 -->"
     skills/wissens-capture/SKILL.md            → "<!-- TODO: Stufe 1 -->"
```

→ PLANMODUS-PROTOKOLL. Warte auf OK.

---

## SCHRITT 15: Persona-Kickstart

```
Für die 3-5 wichtigsten Kontakte:

"lipschitz, erstelle Persona für [Kontakt]"
Fragen:
  - Kommunikationsstil? (direkt/formal/casual/diplomatisch)
  - Du oder Sie?
  - Was schätzt die Person? Was nervt sie?
  - Dos und Don'ts?
  - Small-Talk-Themen?
  - Beziehungshistorie kurz?
  - Bevorzugter Kanal? (email/teams/phone/whatsapp)

→ Persona in contacts/{slug}.md schreiben.
→ Restliche Kontakte nach und nach per lipschitz befüllen.
```

→ PLANMODUS-PROTOKOLL. Warte auf OK.

---

## SCHRITT 16: Git einrichten

```
Lies SYSTEMS.md Kapitel 3.
- git init, .gitignore, erster Commit

Nach Init: Snap "initial workspace setup"
```

→ PLANMODUS-PROTOKOLL. Warte auf OK.

---

## SCHRITT 17: Test-Fixtures erstellen

```
Lies SYSTEMS.md Kapitel 5.
Für donna und harvey: Realistische Test-Daten basierend
auf echten Projekten und Kontakten.
→ Test für Konfidenz-Ausgabe einbauen
→ Test für Staging-Verhalten (destruktive Aktionen)
```

→ PLANMODUS-PROTOKOLL. Warte auf OK.

---

## SCHRITT 18: INDEX.md generieren

```
Scanne gesamten Workspace, generiere INDEX.md:
- Statistiken, Quick-Reference-Tabellen
- Überfällige Tasks, Vertragsfristen, Follow-Ups
- Kommunikations-Health
- Recurring Tasks (nächste 7 Tage)
- Health-Score (Basis für Trend-Tracking)
- Staging-Queue Größe (falls Einträge warten)

→ Zeig INDEX.md. Warte auf OK.
```

→ BOOTSTRAP_STATE.md aktualisieren.
→ PLANMODUS-PROTOKOLL. Warte auf OK.

---

## SCHRITT 19: Systemtest

```
1. "Was steht an?" → Session-Start, Top 3, Überfällige?
2. "Querschnittsanalyse [Area]" → Dateien quer über Projekte?
3. "Wer ist [Kontakt]?" → Kontakt + Persona + Projekte?
4. "Status [Projekt]?" → README + Tasks + Meetings?
5. "Wie kommuniziere ich mit [Kontakt]?" → Persona + Dos/Don'ts?
6. "Wann läuft Vertrag mit [X] aus?" → Watchdog-Daten?
7. "! Test Quick Capture" → landet in inbox/quick-capture/?
8. Neuen Task erstellen → blocked_by, sensitivity, time_estimate_h gesetzt?
9. "Snap test-systemcheck" → Git Commit + INDEX.md regeneriert?
10. Staging testen: Destruktive Aktion → landet in inbox/.staging/?

→ Zeig Ergebnisse. Warte auf OK.
```

---

## SCHRITT 20: Health Check

```
Harold Full Health Check:
- Frontmatter, Referenzen, Tagging-Suggestions
- Sensitivity-Checks: restricted Dateien in falschem Ordner?
- Recurring Tasks check, Inbox-Hygiene
- errors.log aller Agents leer?
- Staging-Queue: Einträge >48h ohne Entscheidung → User informieren
- WORKSPACE.md Konsistenz, INDEX.md Validierung
- Health-Score setzen (Basis für Trend ab jetzt)

→ Probleme beheben. Warte auf OK.
```

---

## SCHRITT 21: Google Drive Shortcuts (optional)

```
"Möchtest du 'Meine Dokumente' in Google Drive
 mit Shortcuts auf die wichtigsten Ordner?"

Wenn ja: Shortcuts für Projekte-Docs, Rechnungen, Verträge, Inbox
```

→ Warte auf OK.

---

## SCHRITT 22: Claude Memory setzen

```
Lies SYSTEMS.md Kapitel 6.
Schlage Memory Edits vor basierend auf dem konkreten Setup.
User setzt sie in Claude Memory (claude.ai) für mobile Nutzung.

Hinweis: Claude Code selbst braucht kein Memory –
WORKSPACE.md + INDEX.md sind das Gedächtnis.
```

→ Warte auf OK.

---

## SCHRITT 23: Mobile Setup

```
Lies SYSTEMS.md Kapitel 9.

23.1 Google Drive App auf Handy:
     - inbox/mobile/ als Shortcut/Favorit
     - inbox/documents/ für Scanner-App

23.2 Claude Mobile: Memory Instructions mit echten Slugs

23.3 Test: "Speicher das: Idee für [Projekt]"
     → Landet in inbox/mobile/?
     → Oder direkt als "! Idee: ..." per Quick Capture?
```

→ Warte auf OK.

---

## SCHRITT 24: OneDrive-Altablage (optional)

```
Nur wenn OneDrive-Altablagen vorhanden:
Lies SYSTEMS.md Kapitel 8.

Alle migrierten Dateien: Staging-Queue nutzen
→ User bestätigt Batch für Batch
```

→ Warte auf OK.

---

## SCHRITT 24b: Orchestrator einrichten

> Automatische Agent-Routinen: Morgen, Pulse, Abend, Freitag.
> Agents laufen im Hintergrund, Ergebnisse liegen bereit wenn du bereit bist.

```
24b.1 Ausführbar machen:
      chmod +x orchestrator/orchestrator.sh

24b.2 Testen (Einzellauf):
      ./orchestrator/orchestrator.sh status
      → Sollte "Noch keine Aktivität heute" zeigen.

      ./orchestrator/orchestrator.sh pulse
      → Prüft INDEX.md + inbox/, zeigt "Pulse OK" oder Neuigkeiten.

24b.3 "Daemon oder Cron?"

      OPTION A – Daemon (empfohlen zum Start):
      "Öffne ein zweites Terminal in VS Code (Ctrl+Shift+`).
       Starte dort: ./orchestrator/orchestrator.sh daemon
       Lass es laufen. Es steuert alles automatisch.
       Terminal 1 = dein Claude-Chat. Terminal 2 = Radar."

      OPTION B – Cron (für Dauerbetrieb ohne VS Code):
      ./orchestrator/orchestrator.sh install
      → Installiert Cron-Jobs für Morgen/Pulse/Abend/Freitag.
      → macOS: System Preferences → Privacy → Full Disk Access → cron

24b.4 Morgenroutine manuell testen:
      ./orchestrator/orchestrator.sh morning
      → Donna + Harvey sollten laufen.
      → Prüfe: journal/.briefings/ enthält donna.md + harvey.md?
      → Im Claude-Chat: "Was steht an" → Harvey fasst zusammen.

24b.5 Notifications testen:
      → Nach morning sollte Desktop-Notification kommen: "Tagesplan steht"
      → Falls nicht: WORKSPACE_NOTIFICATIONS=false ist OK, nicht kritisch.

24b.6 Pulse-Intervall (optional):
      Standard: 30 Minuten. Anpassen:
      PULSE_INTERVAL=900 ./orchestrator/orchestrator.sh daemon  # 15 Min
```

→ BOOTSTRAP_STATE.md aktualisieren:
  orchestrator.mode: daemon | cron | skipped
→ PLANMODUS-PROTOKOLL. Warte auf OK.

---

## SCHRITT 25: Abschluss + BOOTSTRAP_STATE.md abschließen

```
BOOTSTRAP_STATE.md: status: completed setzen.

"Bootstrap abgeschlossen! 🎉

Dein Workspace:
- X Projekte (Y ongoing, Z temporal)
- A Kontakte (B mit Persona)
- C offene Tasks (D recurring, E geblockt)
- F Meeting-Notes
- G Dokumente (H Verträge mit Watchdog)
- I Knowledge-Einträge
- J Ideen
- K OKR Key Results

9 Agents konfiguriert mit Konfidenz-System + Staging
Approval Queue: inbox/.staging/ (aktuell X Einträge warten)
Git initialisiert (Snap 'initial-setup' gesetzt)
Health-Score Baseline: X%
Health-Trend ab nächstem Freitag verfügbar

NÄCHSTE SCHRITTE:
1. Orchestrator als Cron-Job: crontab -e
2. Meetily für Meeting-Transkription
3. 1 Woche arbeiten, Personas per lipschitz ausbauen
4. Mike: Delta-Checks gegen Notion (Woche 2 + 4)
5. Staging-Queue heute leeren: 'Staging zeigen' → 'Staging bestätigen'
6. OneDrive-Altablagen migrieren (Woche 2-3)
7. Jessica: Erste System-Retrospektive (Woche 4)
8. Notion abschalten (nach Woche 4)"

→ BOOTSTRAP_STATE.md kann nach Woche 4 archiviert werden.
```
