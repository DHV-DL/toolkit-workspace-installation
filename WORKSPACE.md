# Workspace Konfiguration

> Diese Datei ist die zentrale Referenz für alle Agents und jeden Chat.
> Bei jedem neuen Chat: **Diese Datei + INDEX.md zuerst lesen.**
>
> SETUP: Ersetze alle Platzhalter [in eckigen Klammern] mit deinen echten Daten.

---

## System-Kontext

- **Pfad:** `[Pfad zu deinem Workspace]` (z.B. Google Drive Desktop, Offline-fähig)
- **Modell:** PARA (Projects, Areas, Resources, Archive)
- **Projekte = Rückgrat.** Alle Entitäten (Tasks, Kontakte, Notes, Dokumente) verweisen über `projects: []` auf Projekte.
- **Frontmatter = Datenbank.** YAML zwischen `---`. Immer am Dateianfang. Arrays für Multi-Zuordnung.
- **Google Drive = Source of Truth.** Git trackt nur Markdown-Dateien.
- **Zeiterfassung:** deaktiviert (kann später aktiviert werden)
- **Lifecycle-Phasen:** aktiv für temporale Projekte

---

## Projekte

> Ersetze diese Beispiele mit deinen echten Projekten.
> Konvention: kd- = Kunden, int- = Intern, prv- = Privat

### Kunden (kd-)

| Slug | Name | Typ |
|------|------|-----|
| kd-client-01 | [Kunde 1] | ongoing |
| kd-client-02 | [Kunde 2] | ongoing |
| kd-client-03 | [Kunde 3] | ongoing |

### Intern (int-)

| Slug | Name | Area |
|------|------|------|
| int-digitalisierung | Digitalisierung Geschäftsprozesse | technology |
| int-automation-ai | Automation & Data & AI | technology |
| int-strategie | Strategie | strategy |
| int-finance | Finance | controlling |
| int-operations | Operations | operations |
| int-hr | Human Resources | hr-legal |
| int-legal | Legal | hr-legal |
| int-marketing | Marketing | business-development |
| int-it-infra | IT Infrastruktur | technology |
| int-datenschutz | Datenschutz | hr-legal |
| int-m-a | Merger & Akquisition | strategy |
| int-investoren | Investoren / Zielerreichung | controlling |
| int-produkte | Produkte & Services | business-development |

### Privat (prv-)

| Slug | Name | Area |
|------|------|------|
| prv-health | Gesundheit & Fitness | privat |
| prv-finances | Finanzen & Vorsorge | privat |
| prv-family | Familie & Beziehungen | privat |
| prv-household | Haushalt & Zuhause | privat |
| prv-administration | Verwaltung & Behörden | privat |
| prv-personal-growth | Persönlichkeitsentwicklung | privat |

### Temporal (mit Deadline)

| Slug | Deadline | Hinweis |
|------|----------|---------|
| temporal-project-01 | [YYYY-MM-DD] | [Beschreibung] |
| temporal-project-02 | [YYYY-MM-DD] | [Beschreibung] |

---

## Areas (7)

| Area | Beschreibung | Projekte |
|------|-------------|----------|
| controlling | Finanzsteuerung, KPIs, Budget | int-finance, int-investoren |
| strategy | Holding-Strategie, M&A, Positionierung | int-strategie, int-m-a |
| business-development | Kunden, Vertrieb, Partnerschaften, Wachstum | int-marketing, int-produkte |
| technology | IT, Digitalisierung, Automation, AI | int-automation-ai, int-digitalisierung, int-it-infra |
| hr-legal | People, HR, Recht, Datenschutz, Compliance | int-hr, int-legal, int-datenschutz |
| operations | Tagesbetrieb, Prozesse, Services | int-operations |
| privat | Persönliche Projekte | prv-health, prv-finances, prv-family, prv-household, prv-administration, prv-personal-growth |

---

## Sensitivity-Tiers

```
confidential:  [sensible Projekte: z.B. int-investoren, prv-finances]
restricted:    [strategische Projekte: z.B. int-strategie, int-m-a, int-hr]
internal:      Alles andere (Default)
```

- **confidential** → Nie in Shared-Ordner, nie in Staging-Zusammenfassungen.
- **restricted** → Keine Zusammenfassungen in Briefings ohne explizite Nachfrage.
- **internal** → Standard. Agents können frei lesen und verarbeiten.

---

## Agents

| Agent | Rolle | Wann |
|-------|-------|------|
| donna | Inbox, Mail, Triage, Quick Capture | Morgens als erstes |
| harvey | Tagesplan, Priorisierung, Strategische Entscheidungen | Nach donna |
| mike | Querschnittsanalyse, Recherche, Übergabe-Dokumente | On demand |
| louis | Verträge, Rechnungen, Dokumente, Watchdog | Wenn Dokumente reinkommen |
| rachel | Meeting-Vorbereitung, Kontakt-Briefing | Vor Meetings |
| katrina | Tagesabschluss, Status-Updates | Abends |
| jessica | Wochenbericht, OKR-Review, Retro | Freitags |
| harold | Health Check, Frontmatter-Validierung, Recurring Tasks | Täglich (quick), Freitags (full) |
| lipschitz | Persona-Erstellung, Kontakt-Profile | On demand |

Agent-Prompts: `agents/{name}/AGENT.md`

---

## Workflows

### Inbox verarbeiten (donna)
1. inbox/ auf neue Dateien prüfen (mobile/, documents/, mail/, voice/, claude-chats/)
2. Mails via M365 MCP holen, kategorisieren, extrahieren
3. Mails nach Thread gruppieren → neuer Thread = neuer Task, bestehender = Task updaten
4. Antwort-Drafts für Mails die Antwort brauchen (Persona aus contacts/ lesen)
5. Attachments → Binärdatei ablegen + MD erstellen → louis für Verträge
6. projects: [] und areas: [] zuordnen
7. Kontakte aktualisieren (last_contact, Kommunikationslog)
8. Follow-Up: Gesendete Mails ohne Antwort nach 5 Tagen → Task
9. Verarbeitete Items → archive/YYYY-MM/
10. Briefing schreiben

### Tagesplan (harvey)
1. Briefings von donna + louis lesen
2. Kalender holen (M365 MCP)
3. Offene Tasks sortieren (überfällig > heute > Woche > urgent)
4. Follow-Ups fällig? (awaiting_response Tasks)
5. Gestrige journal/ → offene Punkte
6. OKRs checken
7. journal/YYYY-MM-DD.md erstellen
8. Meeting-Note-Vorlagen für Termine >30min

### Tagesabschluss (katrina)
1. Tagesplan lesen
2. Pro Task: Erledigt → status: done, completed: Datum
3. Nicht erledigt → due morgen
4. Journal ergänzen
5. Zusammenfassung

### Querschnittsanalyse (mike)
1. INDEX.md → Dateien mit areas: [area]
2. Nur Frontmatter scannen
3. Relevante vollständig lesen
4. Gruppieren nach Projekten
5. Tasks, Verträge, Kosten, Kontakte zeigen
6. Anomalien: Kosten-Ausreißer, inaktive Projekte, einschlafende Kontakte

### Meeting vorbereiten (rachel)
1. Kontakte laden inkl. Persona (Kommunikationsstil, Dos/Don'ts)
2. Projekt-Status aus README.md
3. Offene Tasks
4. Letzte 2-3 Meetings
5. Relevante Entscheidungen aus notes/knowledge/decisions/
6. Agenda-Vorschlag

### Wochenbericht + OKR Review (jessica)
1. Erledigte Tasks (nach Projekt)
2. Meeting-Kernentscheidungen
3. OKR-Fortschritt aktualisieren
4. Kommunikations-Health: Einschlafende Kontakte
5. Anomalien einbeziehen
6. Strategische Warnungen
7. Ausblick nächste Woche

### Dokument verarbeiten (louis)
1. Typ bestimmen (Vertrag, Rechnung, Angebot, Präsentation, Bericht, Beleg)
2. Binärdatei lesen, Inhalt vollständig verstehen
3. MD als primäres Dokument erstellen (source_ref: Pfad zur Binärdatei)
4. Vertrags-Watchdog: Kündigungsfrist, cancellation_deadline, Auto-Verlängerung
5. projects: [] und areas: [] zuordnen
6. Vertragsübersicht aktualisieren

### Health Check (harold)
1. Frontmatter-Validierung
2. Referenz-Integrität
3. Tagging-Suggestions für neue Dateien
4. Recurring Tasks: next_due erreicht → neue Task generieren
5. Verwaiste Binärdateien ohne MD → Warnung
6. Inbox-Hygiene (>48h)
7. INDEX.md vs. Realität
8. Reparieren oder melden

---

## Command Dictionary

### Session & Navigation
```
"Guten Morgen" / "Was steht an"     → harvey: INDEX.md + Briefings + Top 3
"Wo war ich"                         → journal/YYYY-MM-DD.md + gestrige Briefings
"Zusammenfassung" / "Überblick"      → INDEX.md Quick-Reference ausgeben
"Urlaub vorbei" / "Was hab ich verpasst" → harvey: Re-Entry Protokoll
```

### Quick Capture
```
"! [Text]"     → inbox/quick-capture/YYYY-MM-DD_HH-MM.md (donna verarbeitet morgens)
"!! [Text]"    → Wie oben, priority: urgent (harvey wird hingewiesen)
```

### Agents aufrufen
```
"donna"                      → Inbox + Mail verarbeiten
"harvey"                     → Tagesplan erstellen
"mike, [Auftrag]"           → Querschnitt / Anomalie / Migration
"louis, [Dokument]"          → Vertrag / Rechnung verarbeiten
"rachel, [Kontakt/Thema]"   → Meeting vorbereiten
"katrina"                    → Tagesabschluss
"jessica"                    → Wochenbericht + OKR Review
"harold" / "Health"          → Health Check (quick)
"harold full"                → Full Health Check
"lipschitz, [Kontakt]"      → Persona erstellen / aktualisieren
```

### Tasks & Projekte
```
"Task: [Text]"               → Neuer Task, fragt nach Projekt
"Task: [Text] #kd-client-01" → Direkt zuweisen
"Status kd-client-01"        → README + offene Tasks + letzte 3 Meetings
"Offene Tasks int-finance"   → Gefilterte Task-Liste
"Blockt was?"                → Alle Tasks mit status: blocked
```

### Dokumente & Suche
```
"Suche [Begriff]"            → INDEX.md → grep → Top 5 mit Kontext
"Wer ist [Name]"             → contacts/ → Persona + Projekte
"Wie kommuniziere ich mit [Name]" → Persona + Dos/Don'ts + Draft-Stil
"Wann läuft Vertrag mit [X] aus"  → documents/vertraege/ → Watchdog
"Letztes Meeting [Kontakt]"       → notes/meetings/ filtern
```

### System
```
"Snap [Beschreibung]"       → git add -A && git commit -m "snapshot: [Beschreibung]" + INDEX.md regenerieren
"Index"                      → INDEX.md regenerieren
"Staging zeigen"             → inbox/.staging/ anzeigen
"Staging bestätigen"         → Staged-Dateien ins Ziel
"Staging verwerfen"          → Staging-Queue leeren
"Wo stehen wir"              → BOOTSTRAP_STATE.md lesen
```

### Natural Language Queries
```
"Was schuldet mir [Firma]?"          → documents/rechnungen/ summieren
"Wann läuft Vertrag mit [X] aus?"   → documents/vertraege/ → valid_until
"Letztes Meeting mit [Kontakt]?"    → notes/meetings/ filtern
"Offene Tasks [Projekt]?"           → tasks/ filtern
"Wer ist [Name]?"                   → contacts/ → Persona + Projekte
"Wie kommuniziere ich mit [X]?"     → contacts/ → Persona + Dos/Don'ts
"Wie lange brauchen wir noch?"      → lifecycle_phase + Meilensteine
```

---

## Context-Window-Regeln

```
Bei JEDER Anfrage:
1. IMMER zuerst INDEX.md lesen
2. Aus INDEX.md relevante Dateien identifizieren
3. Nur die relevanten Dateien lesen
4. Bei Tasks/Kontakten: zuerst NUR Frontmatter
5. Body nur wenn Inhalt wirklich nötig
NIEMALS alle Tasks/Kontakte/Meetings auf einmal lesen
```
