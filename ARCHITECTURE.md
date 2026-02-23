# Architektur – Templates, Struktur, Konventionen

---

## 1. Ordnerstruktur

```
workspace/
│
│  ══ PROJEKTE (PARA Backbone) ══
├── projects/
│   ├── {ongoing-slug}/           # Ongoing: Abteilungen, Töchter, Bereiche
│   │   ├── README.md             # Beschreibung, Stand, regelmäßige Aufgaben
│   │   ├── docs/                 # Projektspezifische Dokumente
│   │   └── shared/               # Für Kunden freigegeben (GDrive Sharing)
│   └── {temporal-slug}/          # Temporal: echte Projekte mit Start/Ende
│       ├── README.md             # Scope, Meilensteine, Timeline, Zeiterfassung
│       ├── docs/
│       └── shared/
│
│  ══ ZENTRALE ENTITÄTEN ══
├── tasks/                        # Alle Tasks, projektübergreifend
│   └── {YYYY-MM-DD}_{slug}.md   # Frontmatter: projects: [], areas: []
│
├── contacts/                     # Alle Kontakte (mit Persona-Profil)
│   └── {slug}.md                 # Frontmatter: projects: [], persona, channels
│
├── notes/
│   ├── meetings/                 # Meeting-Transkripte & Notes
│   │   └── {YYYY-MM-DD}_{slug}.md
│   ├── ideas/                    # Ideen, Brainstorms
│   │   └── {YYYY-MM-DD}_{slug}.md
│   └── knowledge/                # Dauerhaftes Wissen (nicht zeitgebunden)
│       ├── howto/                # Anleitungen
│       ├── decisions/            # Entscheidungslogs
│       ├── learnings/            # Lessons Learned
│       └── tech/                 # Technische Dokumentation
│
├── documents/                    # Zentrale Dokumentenablage
│   ├── vertraege/                # + Markdown-Companion pro Dokument
│   │   └── UEBERSICHT.md        # Auto-generiert von Louis: alle Verträge
│   ├── rechnungen/
│   ├── belege/
│   └── sonstiges/
│
├── goals/                        # OKRs & Ziele
│   └── {YYYY}-Q{X}.md
│
│  ══ JOURNAL ══
├── journal/
│   ├── {YYYY-MM-DD}.md           # Tagesplan + Rückblick
│   ├── weekly/                   # Wochenberichte (jessica)
│   │   └── {YYYY}-W{XX}.md
│   ├── .briefings/               # Inter-Agent-Übergaben (täglich)
│   │   └── {YYYY-MM-DD}/
│   │       ├── donna.md
│   │       ├── harvey.md
│   │       └── ...
│   ├── metrics/                  # System-Metriken (harold, freitags)
│   ├── retro/                    # Monatliche System-Retros (jessica)
│   ├── dashboard/                # Generierte HTML-Dashboards
│   └── .orchestrator/            # Orchestrator-Logs (automatisch)
│       ├── orchestrator-YYYY-MM-DD.log  # Vollständiges Tages-Log
│       └── state-YYYY-MM-DD.log         # Was heute schon lief
│
│  ══ EINGANG ══
│  Inbox-Ordner auch direkt über Google Drive App befüllbar:
│  Handy → GDrive App → inbox/mobile/
│  Scanner-App → GDrive → inbox/documents/
│  Desktop → Drag & Drop in gemounteten Ordner
│
├── inbox/
│   ├── mobile/                   # Quick-Captures, Brain Dumps, Sprache
│   ├── documents/                # Scans, Downloads, PDFs
│   ├── mail/                     # Mail-Attachments (von donna extrahiert)
│   ├── voice/                    # Sprachnachrichten
│   ├── claude-chats/             # Erkenntnisse aus Claude.ai Verläufen
│   ├── quick-capture/            # "!" Schnelleingaben, donna verarbeitet morgens
│   ├── .staging/                 # Approval Queue für Agents (harold überwacht)
│   │   ├── tasks/
│   │   ├── contacts/
│   │   ├── documents/
│   │   └── onedrive/             # OneDrive-Migrations-Batches
│   │   └── skills/               # Skill-Vorschläge von Agents (Skill 25)
│   │   └── toolkit/              # Toolkit-Events mit [MED] Konfidenz
│   ├── toolkit-events/           # Events von ERP-Toolkits (Bridge, ab Stufe 2)
│   └── notion-audit/             # Inventar + Mapping (Bootstrap)
│
├── archive/                      # Verarbeitete Items + Altdaten
│   ├── {YYYY-MM}/               # Monatliche Inbox-Archive
│   ├── briefings/                # Gestrige Agent-Briefings
│   ├── improvements/             # Improvement-Queue + Wirkungs-Tracking
│   ├── onedrive-{datum}/         # OneDrive-Altablage (nach Migration)
│   └── notion-final-{datum}/     # Notion-Archiv (vor Abschaltung)
│
├── exports/                      # Kontext-Exporte für externe Systeme
│   └── toolkit-context/          # Projekt-Kontext für ERP-Toolkits (Bridge)
│
│  ══ SYSTEM ══
├── templates/
│   ├── task.md
│   ├── project-ongoing.md
│   ├── project-temporal.md
│   ├── contact.md
│   ├── meeting-note.md
│   ├── idea.md
│   ├── document.md
│   ├── knowledge.md
│   ├── decision-log.md
│   ├── postmortem.md
│   ├── okr-quarterly.md
│   ├── daily-journal.md
│   ├── briefing.md
│   └── project-kickstart/        # Vorlagen für neue Projekte
│       ├── migration/            # Standard für Migrationsprojekte
│       │   ├── README.md
│       │   └── standard-tasks.md
│       ├── evaluation/
│       └── onboarding/
│
├── skills/                       # Prozess-Skills (WIE Agents arbeiten)
│   │  ── INBOUND ──
│   ├── inbound-triage/           # 01: Master-Routing aller eingehenden Informationen
│   ├── dokument-eingang/         # 02: Dokumentenverarbeitung + MD-Companion
│   │  ── OUTBOUND ──
│   ├── email-stil/               # 03: Persönlicher E-Mail-Stil + Beispiele
│   ├── kanalregeln/              # 04: Regeln pro Kanal (Mail/Teams/WhatsApp/Telefon)
│   ├── follow-up-management/     # 05: Eskalationsstufen bei fehlender Antwort
│   ├── eskalation-kommunikation/ # 06: Kommunikation bei Problemen/Verzögerungen
│   ├── brief-formal/             # 07: DIN-5008-Briefe (Kündigungen, Formelles)
│   │  ── DOKUMENT-LIFECYCLE ──
│   ├── vertrag-analyse/          # 08: Vertragsverarbeitung + Fristen + Risiken
│   ├── rechnung-verarbeitung/    # 09: Rechnungserfassung + Prüfung + Zuordnung
│   ├── dokument-ablage/          # 10: Ablageregeln, Benennung, Archivierung
│   │  ── PROJEKTMANAGEMENT ──
│   ├── projekt-kickstart/        # 11: Neues Projekt standardisiert aufsetzen
│   ├── projekt-status/           # 12: Status-Bewertung + Kommunikation
│   ├── uebergabe-dokument/       # 13: Übergabe-Struktur bei Projektwechsel
│   │  ── TASK-MANAGEMENT ──
│   ├── task-erstellung/          # 14: Wie Tasks formuliert + priorisiert werden
│   ├── tagesplanung/             # 15: Priorisierung, Zeitbudget, Deep Work
│   │  ── MEETING-MANAGEMENT ──
│   ├── meeting-vorbereitung/     # 16: Agenda, Kontext, Persona-Integration
│   ├── meeting-protokoll/        # 17: Protokoll-Struktur + Action Items
│   ├── meeting-nachbereitung/    # 18: Post-Meeting-Prozess + Follow-Up
│   │  ── CRM ──
│   ├── kontakt-persona/          # 19: Persona-Datenmodell + Pflege + Nutzung
│   │  ── REPORTING ──
│   ├── reporting/                # 20: Alle Berichtsformate (intern/extern)
│   ├── presentation-ci/          # CI: Farben, Fonts, Logo für Berichte/Exports
│   │  ── PROZESS & WISSEN ──
│   ├── sop-erstellung/           # 21: SOPs dokumentieren + Automations-Kandidaten
│   ├── cross-source-recherche/   # 22: Aggregierte Suche über alle Quellen
│   └── wissens-capture/          # 23: Wissen extrahieren + klassifizieren + ablegen
│
├── agents/                       # Suits-Agents
│   ├── donna/
│   │   ├── AGENT.md
│   │   ├── config.yaml
│   │   ├── errors.log            # Harold überwacht täglich
│   │   ├── corrections/            # Learnings aus User-Korrekturen (Skill 24)
│   │   └── tests/
│   ├── harvey/  [analog]
│   ├── mike/    [analog]
│   ├── louis/   [analog]
│   ├── rachel/  [analog]
│   ├── katrina/ [analog]
│   ├── jessica/ [analog]
│   ├── harold/  [analog]
│   ├── lipschitz/                # Persona-Pflege + CRM-Intelligenz [analog]
│   └── dashboard/
│
├── orchestrator/                 # Automatische Agent-Routinen
│   ├── orchestrator.sh
│   ├── README.md
│   └── scripts/
├── workspace-mcp/                 # Eigener MCP-Server (Stufe 3+)
│   ├── src/
│   │   ├── index.ts               # MCP-Server Einstiegspunkt
│   │   ├── tools-read.ts          # get_index, get_tasks, get_project, ...
│   │   ├── tools-write.ts         # quick_capture, approve_staging, ...
│   │   └── frontmatter.ts         # YAML-Frontmatter Parser
│   ├── package.json
│   └── README.md
│   ├── orchestrator.sh           # Hauptskript (daemon/cron/einzel)
│   ├── README.md                 # Anleitung + VS Code Setup
│   └── scripts/                  # Mechanik-Skripte (Stufe 2+, Token-Optimierung)
│       ├── pulse-check.sh        # Ersetzt LLM-Pulse wenn nichts Neues
│       ├── harold-scan.sh        # Frontmatter + Health Score ohne LLM
│       ├── rebuild-index.py      # INDEX.md aus Frontmatter regenerieren
│       └── health-score.py       # Health Score Berechnung (Formel)
│
│  ══ CONFIG ══
├── PROFILE.md                    # Über DICH: Arbeitsstil, Werte, Präferenzen
├── COMPANY.md                    # Über dein UNTERNEHMEN: Strategie, Struktur, Markt
├── WORKSPACE.md                  # System-Instruktionen (Workflows, Konventionen)
├── CLAUDE.md
├── INDEX.md
├── .claude/rules/                  # Von Claude Code AUTO-GELESEN bei jedem Chat
│   ├── preferences.md              # Sprache, Konventionen, Konfidenz-Regeln
│   └── workflows.md                # Quick Commands, Routing, Regeln
├── .gitignore
└── .git/
```

### Google Drive Shortcuts (optionale Komfort-Ebene)

```
Für eine "normale" Dokumentenansicht ohne Code/System-Dateien:
Google Drive Shortcuts auf die Dokumenten-Ordner anlegen.

Meine Dokumente/                  ← Separater GDrive-Ordner
├── [Shortcut] Tochter Alpha → workspace/projects/tochter-alpha/docs/
├── [Shortcut] Rechnungen → workspace/documents/rechnungen/
├── [Shortcut] Verträge → workspace/documents/vertraege/
├── [Shortcut] Inbox → workspace/inbox/
└── ...

Harold kann neue Shortcuts vorschlagen wenn Projekte angelegt werden.
```

---

## 2. Templates

### 2.1 Task (templates/task.md)

```markdown
---
type: task
status: open                     # open | in-progress | done | blocked | cancelled
priority: medium                 # low | medium | high | urgent
projects: []                     # [slug-1, slug-2]
areas: []                        # [area-1, area-2]
contacts: []                     # [kontakt-slug]
due: ""                          # YYYY-MM-DD
created: ""                      # YYYY-MM-DD
completed: ""                    # YYYY-MM-DD (von katrina gesetzt)
tags: []
sensitivity: internal            # public | internal | confidential | restricted
source: ""                       # manual | mobile | mail | meeting | okr | notion | mail-follow-up | claude-chat | quick-capture
source_ref: ""                   # Link zum Original (Outlook Mail-URL, Notion-URL, etc.)

# Zeiterfassung:
time_estimate_h: 0               # Schätzung in Stunden (harvey setzt beim Tagesplan)
time_actual_h: 0                 # Ist-Zeit (katrina setzt beim Tagesabschluss)
time_date: ""                    # YYYY-MM-DD (katrina setzt)

# Blocking (optional):
# blocked_by:                    # Relative Pfade zu blockierenden Tasks
#   - tasks/YYYY-MM-DD_slug.md
# blocks:                        # Rückwärts-Referenz
#   - tasks/YYYY-MM-DD_slug.md

# Recurring (optional):
# recurrence:
#   frequency: monthly           # daily | weekly | monthly | quarterly | yearly
#   day: 1
#   next_due: ""
#   last_generated: ""
#   instance: 1
#   auto_create: true

# Follow-Up (optional, von donna):
# follow_up: false
# follow_up_for: ""
# awaiting_response: false

# Mail-Thread (optional, von donna):
# mail_thread: ""
# mail_count: 0
# last_mail: ""
---

## Beschreibung

## Notizen

## Erledigungskriterien

- [ ] ...

## Antwort-Entwurf
<!-- Von donna befüllt wenn Antwort nötig -->
```

### 2.2 Projekt Ongoing (templates/project-ongoing.md)

```markdown
---
type: project
project_type: ongoing
status: active                   # active | paused | archived
entity_type: ""                  # holding-abteilung | tochterunternehmen | bereich
parent: ""
contacts: []
areas: []
tags: []
---

## Beschreibung

## Aktueller Stand

## Regelmäßige Aufgaben
```

### 2.3 Projekt Temporal (templates/project-temporal.md)

```markdown
---
type: project
project_type: temporal
status: active                   # lead | active | paused | completed | cancelled
parent_projects: []
contacts: []
areas: []
sensitivity: internal            # public | internal | confidential | restricted
start_date: ""
end_date: ""
budget: ""
tags: []

# Lifecycle:
lifecycle_phase: initiation      # initiation | planning | execution | monitoring | closure
lifecycle_phase_since: ""        # YYYY-MM-DD
lifecycle_next_review: ""        # YYYY-MM-DD (jessica erstellt Review-Task wenn überschritten)
---

## Projektübersicht

## Scope

## Meilensteine

- [ ] ...

## Zeiterfassung

| Datum | Stunden | Beschreibung |
|-------|---------|-------------|

## Offene Punkte
```

### 2.4 Kontakt (templates/contact.md)

```markdown
---
type: contact
name: ""
company: ""
role: ""
email: ""
phone: ""
projects: []
areas: []
tags: []
last_contact: ""                 # YYYY-MM-DD
communication_style: ""          # direct | formal | casual | diplomatic
preferred_address: ""            # Du | Sie
preferred_channel: email         # email | teams | phone | whatsapp
language: de
channels:
  email: ""
  phone: ""
  teams: false
  whatsapp: false
sensitivity: internal            # internal | confidential (für Personas mit sensitiven Infos)
ai_processing: true              # false = Agent überspringt diese Person bei API-Calls (DSGVO opt-out)
---

## Persona

### Kommunikationsprofil
<!-- Wie tickt diese Person? Was schätzt sie? Was nervt sie? -->

### Dos und Don'ts
<!-- ✅ Immer mit konkretem Vorschlag kommen -->
<!-- ❌ Nie sagen "das wissen wir noch nicht" -->

### Gesprächsthemen (Small Talk)
<!-- Was interessiert die Person persönlich? -->

### Beziehungshistorie
<!-- Wie hat die Beziehung begonnen? Entwicklung? -->

## Kontext

## Kommunikationslog

| Datum | Kanal | Zusammenfassung |
|-------|-------|-----------------|
```

### 2.5 Meeting-Note (templates/meeting-note.md)

```markdown
---
type: meeting
date: ""
projects: []
areas: []
attendees: []
contacts: []
platform: ""                     # teams | zoom | phone | in-person
recording: false
source: ""                       # meetily | manual | mobile
source_ref: ""                   # Link zum Original (Outlook Kalender-URL, etc.)
---

## Zusammenfassung

## Kernpunkte

## Action Items

- [ ] ...

## Transkript
```

### 2.6 Idee (templates/idea.md)

```markdown
---
type: idea
status: draft                    # draft | exploring | validated | parked | implemented
projects: []
areas: []
contacts: []
created: ""
tags: []
---

## Kernidee

## Kontext

## Ausarbeitung

## Nächste Schritte

## Historie

| Datum | Update |
|-------|--------|
```

### 2.7 Dokument (templates/document.md)

```markdown
---
type: document
category: ""                     # vertrag | rechnung | angebot | praesentation | bericht | beleg | sonstig
projects: []
areas: []
contacts: []
provider: ""
date: ""                         # YYYY-MM-DD
valid_until: ""                  # YYYY-MM-DD (Vertragsende)
amount: ""
currency: "EUR"
recurring: ""                    # monthly | yearly | once
source: ""                       # scan | mail | download | manual | notion | onedrive
source_ref: ""                   # Pfad zur Binärdatei oder URL zum Original
# Vertrags-Watchdog (nur bei category: vertrag):
# cancellation_period: ""        # z.B. "3 Monate"
# cancellation_deadline: ""      # YYYY-MM-DD (errechnet)
# auto_renewal: false
# renewal_period: ""             # z.B. "12 Monate"
# price_adjustment: ""           # z.B. "jährlich nach VPI"
# min_term_until: ""             # YYYY-MM-DD
tags: []
---

## Zusammenfassung

## Vertragsdetails (nur bei Verträgen)
<!-- Kündigungsfrist, Sonderkündigungsrecht, Preisklauseln -->

## Notizen
```

### 2.8 Knowledge (templates/knowledge.md)

```markdown
---
type: knowledge
topic: ""                        # howto | decision | learning | tech | reference
projects: []
areas: []
created: ""
updated: ""
tags: []
---

## Zusammenfassung

## Details

## Quellen / Referenzen

## Verwandte Einträge
```

### 2.9 Decision Log (templates/decision-log.md)

```markdown
---
type: knowledge
topic: decision
projects: []
areas: []
contacts: []
created: ""
decision: ""
---

## Entscheidung

## Kontext

## Alternativen

## Begründung

## Beteiligte
```

### 2.10 Postmortem (templates/postmortem.md)

```markdown
---
type: knowledge
topic: learning
projects: []
areas: []
created: ""
---

## Projektzusammenfassung

## Was lief gut?

## Was lief schlecht?

## Learnings für zukünftige Projekte

## Zahlen
```

### 2.11 OKR Quarterly (templates/okr-quarterly.md)

```markdown
---
type: okr
period: ""
status: active                   # draft | active | review | closed
---

## Objective 1: [TITEL]

Beschreibung:

### Key Results

- [ ] **KR 1.1:** [Messbares Ergebnis]
  - Target: [Zielwert]
  - Current: [Stand]
  - Progress: 0%
  - projects: []

---

## Retrospektive
```

### 2.12 Daily Journal + Briefing

(Wie bisher, siehe templates/daily-journal.md und templates/briefing.md)

---

### 2.13 PROFILE.md (Root-Ebene, kein Template)

```markdown
# Profil

## Über mich
- Name:
- Rolle:
- Standort:
- Zeitzone:
- Sprachen:

## Arbeitsstil
<!-- Wie arbeitest du am liebsten? Morgenmensch? Deep Work Phasen?
     Lieber async oder sync? Wie gehst du mit Interrupts um? -->

### Tagesstruktur
<!-- Wann bist du am produktivsten? Wie sieht ein idealer Tag aus? -->

### Entscheidungsstil
<!-- Schnelle Entscheidungen oder gründlich abwägen?
     Daten-getrieben oder Bauchgefühl? Allein oder im Sparring? -->

### Kommunikationspräferenzen
<!-- Kurz und direkt? Ausführlich? Formell/Informell?
     Bevorzugte Kanäle für welche Situationen? -->

## Werte & Prinzipien
<!-- Was ist dir in der Zusammenarbeit wichtig?
     Welche Prinzipien leiten deine Arbeit?
     Was geht gar nicht? -->

### Geschäftsprinzipien
<!-- z.B. Qualität vor Geschwindigkeit, Transparenz gegenüber Kunden,
     langfristige Beziehungen statt Projekthopping -->

### Persönliche Stärken
<!-- Was kannst du besonders gut? Wo bist du die Go-To-Person? -->

### Bekannte Schwächen / Delegations-Ziele
<!-- Was fällt dir schwer? Was sollten die Agents besonders abfangen?
     z.B. Follow-Ups vergessen, zu viel gleichzeitig anfangen -->

## Fachliche Expertise
<!-- Dein Erfahrungshintergrund. Was sind deine Kernkompetenzen?
     In welchen Themen bist du Experte, wo eher Generalist? -->

### Kernkompetenzen
<!-- z.B. Datenmigration, ERP-Integration, Prozessautomatisierung -->

### Technischer Stack
<!-- Sprachen, Frameworks, Tools, Cloud-Services die du beherrschst -->

### Branchenwissen
<!-- Welche Branchen kennst du von innen? -->

## Persönliche Ziele
<!-- Wo willst du in 1/3/5 Jahren stehen? Nicht Unternehmensziele
     (die stehen in COMPANY.md), sondern persönliche Entwicklung.
     z.B. weniger operativ, mehr strategisch; neues Standbein aufbauen;
     bestimmte Expertise vertiefen -->

### 1-Jahres-Horizont
### 3-Jahres-Vision
```

### 2.14 COMPANY.md (Root-Ebene, kein Template)

```markdown
# Unternehmen

## Überblick
- Firmenname:
- Rechtsform:
- Gegründet:
- Standort:
- Branche:
- Mitarbeiter:

## Holding-Struktur
<!-- Wie ist die Unternehmensgruppe aufgebaut?
     Welche Entitäten gibt es, wer gehört wem? -->

```
[Holding]
├── [Tochter A] – Beschreibung, Fokus
├── [Tochter B] – Beschreibung, Fokus
└── [Bereich X] – Beschreibung, Fokus
```

### Entität: [Name]
- Zweck:
- Kunden/Markt:
- Umsatzanteil ca.:
- Verantwortlich:
- Besonderheiten:

<!-- Für jede Entität wiederholen -->

## Geschäftsmodell
<!-- Wie verdient das Unternehmen Geld?
     Welche Leistungen werden erbracht? -->

### Leistungsportfolio
<!-- Was bietet ihr an? Welche Services, Produkte, Pakete? -->

### Umsatzströme
<!-- Recurring vs. Projekt? Stundensatz vs. Festpreis?
     Welche Projekte bringen am meisten? -->

### Wertversprechen
<!-- Warum sollte ein Kunde euch beauftragen statt die Konkurrenz? -->

## Strategie

### Mission
<!-- Ein Satz: Warum gibt es dieses Unternehmen? -->

### Vision
<!-- Wo soll das Unternehmen in 3-5 Jahren stehen? -->

### Strategische Säulen
<!-- Die 3-5 Kernthemen auf die ihr setzt.
     z.B. Automatisierung, Plattform-Aufbau, Kundennähe -->

### Strategische Entscheidungen
<!-- Bewusste Entscheidungen die die Richtung bestimmen.
     z.B. "Wir fokussieren auf Property Management, nicht auf Retail"
     z.B. "Wir bauen eigene Tools statt nur zu beraten" -->

## Unternehmensziele

### Jahresziele [YYYY]
<!-- Die übergeordneten Ziele für dieses Jahr.
     OKRs in goals/ sind die operationalisierte Version davon. -->

### Mittelfristige Ziele (2-3 Jahre)

### Langfristige Vision (5+ Jahre)

## Kundenprofil

### Idealkunde
<!-- Wer ist der perfekte Kunde?
     Branche, Größe, Problemstellung, Budget, Entscheidungsstruktur -->

### Kundensegmente
<!-- Welche Typen von Kunden habt ihr?
     z.B. "Große Hausverwaltungen mit Legacy-Systemen",
     "Mittelständische WEG-Verwalter vor der Digitalisierung" -->

### Anti-Profil
<!-- Welche Kunden wollt ihr NICHT?
     z.B. zu klein, falsche Erwartung, zu wenig Budget -->

### Akquise-Kanäle
<!-- Wie kommen Kunden zu euch?
     Empfehlungen, Netzwerk, Kaltakquise, Online? -->

## Markt & Wettbewerb

### Marktumfeld
<!-- Wie sieht der Markt aus? Trends, Regulierung, Dynamik.
     z.B. Property Management in DACH, Digitalisierungsdruck,
     regulatorische Anforderungen -->

### Wettbewerber
| Name | Fokus | Stärke | Schwäche | Differenzierung zu uns |
|------|-------|--------|----------|----------------------|
|      |       |        |          |                      |

### Positionierung
<!-- Wo steht ihr im Markt? Premium/Mittel/Günstig?
     Spezialist oder Generalist? Lokal oder national? -->

### Alleinstellungsmerkmale (USPs)
<!-- Was könnt ihr, was die anderen nicht können?
     z.B. Kombination aus Tech-Know-how und Branchenwissen -->

## Partnerschaften & Ökosystem
<!-- Mit wem arbeitet ihr zusammen?
     Technologie-Partner, Reseller, Berater-Netzwerk -->

## Risiken & Herausforderungen
<!-- Was sind die größten Risiken für das Unternehmen?
     Abhängigkeiten, Marktrisiken, Personalrisiken -->
```

---

## 3. Dokumenten-Strategie (AI-first)

### Paradigma

```
ALTE WELT:  Du öffnest Ordner → suchst Datei → öffnest PDF → liest
NEUE WELT:  Du fragst Claude → Claude antwortet aus der MD → fertig
```

**Die MD IST das Dokument.** Nicht ein "Index-Eintrag", nicht ein
"Schatten". Die MD ist die primäre Informationsquelle. Claude liest
sie, antwortet dir daraus, verlinkt sie mit Projekten und Kontakten.

**Die Binärdatei ist ein Anhang.** Sie existiert als Quelle und
zum externen Teilen. Du öffnest sie nur wenn du das visuelle
Original sehen oder sie versenden musst.

### Universelles Prinzip: source_ref

Jede MD die aus einer externen Quelle stammt hat ein `source_ref:`
Feld – der direkte Link zurück zum Original in der nativen App.

```
┌─────────────┬──────────────────────┬─────────────────────────────┐
│ Typ         │ MD enthält           │ source_ref öffnet           │
├─────────────┼──────────────────────┼─────────────────────────────┤
│ Vertrag     │ Klauseln, Watchdog   │ PDF in Google Drive         │
│ Rechnung    │ Betrag, Zuordnung    │ PDF in Google Drive         │
│ Präsentation│ Inhalt, Feedback     │ PPTX in Google Drive        │
│ E-Mail      │ Inhalt, Draft        │ Mail in Outlook Web         │
│ Termin      │ Agenda, Action Items │ Event in Outlook Kalender   │
│ Notion      │ Migrierter Inhalt    │ Notion-URL (vor Abschaltung)│
│ OneDrive    │ Migrierter Inhalt    │ OneDrive-URL (vor Migration)│
│ Brain Dump  │ Extrahierter Inhalt  │ Claude.ai Chat-URL          │
└─────────────┴──────────────────────┴─────────────────────────────┘
```

**Das Prinzip ist überall gleich:**
- Du fragst Claude → Claude antwortet aus der MD
- Du brauchst das Original → Claude gibt dir den source_ref Link
- "Zeig mir die Mail" → "Hier: [Outlook Link]"
- "Öffne den Vertrag" → "Hier: [GDrive Pfad]"
- "Welcher Termin war das?" → "Hier: [Outlook Kalender Link]"

**source_ref Formate:**
```yaml
# Binärdatei in Google Drive (relativ zum Workspace):
source_ref: "angebot-phase-2.pdf"
source_ref: "../../documents/vertraege/rahmenvertrag-[ERP System].pdf"

# Outlook Mail (Web-URL, von Donna per MCP geholt):
source_ref: "https://outlook.office.com/mail/id/AAMk..."

# Outlook Kalender-Event:
source_ref: "https://outlook.office.com/calendar/item/AAMk..."

# Notion (solange noch aktiv):
source_ref: "https://notion.so/page-id..."

# Claude.ai Chat:
source_ref: "https://claude.ai/chat/abc123..."
```

### Persistenz: Was wird lokal gesichert?

Nicht alles muss lokal liegen. `source_ref:` ist oft genug –
solange das Original in der Quelle auffindbar bleibt.
**Eine Ausnahme: E-Mail-Anhänge.**

```
┌─────────────────┬────────────────────┬──────────────┬─────────────────┐
│ Quelle          │ MD enthält         │ source_ref → │ Binärdatei lokal│
├─────────────────┼────────────────────┼──────────────┼─────────────────┤
│ E-Mail          │ Zusammenfassung    │ Outlook URL  │ NUR ANHÄNGE     │
│ E-Mail-Anhang   │ (in der MD)        │ GDrive-Pfad  │ ✅ JA           │
│ Kalenderevent   │ Meeting-Note       │ Outlook URL  │ Nein            │
│ Meeting-Audio   │ Transkription (MD) │ –            │ Nein            │
│ Claude.ai Chat  │ –                  │ Chat-URL     │ Nein            │
│ Vertrag (PDF)   │ Vollständig        │ GDrive-Pfad  │ ✅ JA (= Quelle)│
│ Rechnung (PDF)  │ Vollständig        │ GDrive-Pfad  │ ✅ JA (= Quelle)│
│ Notion          │ Migrierter Inhalt  │ Notion-URL   │ Nein            │
│ OneDrive        │ Migrierter Inhalt  │ GDrive-Pfad  │ ✅ JA (migriert)│
└─────────────────┴────────────────────┴──────────────┴─────────────────┘
```

**Warum E-Mail-Anhänge?**
Mails bleiben in Outlook – die findest du über source_ref.
Aber Anhänge leben NUR in der Mail. Wird die Mail gelöscht oder
der Provider gewechselt, ist die Binärdatei weg. Deshalb:
Donna extrahiert JEDEN relevanten Anhang und legt ihn in GDrive ab.

**Donna-Workflow für Anhänge:**
```
Mail mit Attachment:
1. Binärdatei per MCP extrahieren
2. Ablegen: Rechnung → documents/rechnungen/{datei}
            Vertrag → documents/vertraege/{datei}
            Projektspezifisch → projects/{slug}/docs/{datei}
            Unklar → inbox/documents/{datei}
3. MD erstellen mit source_ref: auf die lokale Binärdatei
4. Im Task zusätzlich source_ref: auf die Outlook-Mail
   → So findest du sowohl die Datei (lokal) als auch
     den Mail-Kontext (Outlook)
```

**Alles andere bleibt in der Quelle:**
- E-Mail-Body → Outlook (source_ref reicht, MD hat Zusammenfassung)
- Kalendertermine → Outlook Kalender (Meeting-Note hat alle Infos
  inkl. Meetily-Transkription, Teilnehmer, Action Items)
- Claude.ai Chats → Claude.ai (source_ref reicht)

### So sieht das aus

```
projects/migration-[Client-Example]/docs/
├── testmigration-report.md            ← DAS IST DAS DOKUMENT
│   Frontmatter: projects, contacts, date, tags
│   Body: Vollständiger Inhalt – Ergebnisse, Tabellen, nächste Schritte
│   Anhang: source_ref: testmigration-report.pptx
│
├── testmigration-report.pptx          ← Anhang: Gestaltete Version fürs Teilen
│
├── angebot-phase-2.md                 ← DAS IST DAS DOKUMENT
│   Frontmatter: category: angebot, amount: 15000, contacts: [[Client-Example]]
│   Body: Leistungsumfang, Konditionen, Timeline
│   Anhang: source_ref: angebot-phase-2.pdf
│
├── angebot-phase-2.pdf                ← Anhang: Unterschriebene Version
│
├── migration-leitfaden.md             ← Reines MD, kein Anhang nötig
└── statusbericht-2026-02.md           ← Reines MD

documents/vertraege/
├── hosting-vertrag-placetel.md        ← DAS IST DAS DOKUMENT
│   Frontmatter: Watchdog-Felder, Fristen, Kündigungsdeadline
│   Body: Vertragsdetails, Klauseln, Zusammenfassung
│   Anhang: source_ref: hosting-vertrag-placetel.pdf
│
└── hosting-vertrag-placetel.pdf       ← Anhang: Unterschriebenes Original
```

### Was gehört in die MD?

Die MD enthält ALLES was ein Agent oder du braucht um die Frage
zu beantworten ohne die Binärdatei öffnen zu müssen:

```markdown
---
type: document
category: angebot
projects: [migration-[Client-Example]]
areas: [datenmigration]
contacts: [[Client-Example]]
amount: "15000"
currency: "EUR"
date: "2026-02-15"
valid_until: "2026-03-15"
source: intern
source_ref: "angebot-phase-2.pdf"    # Relativer Pfad zum Anhang
tags: [deliverable]
---

## Zusammenfassung
Angebot für Phase 2 der Datenmigration [Client-Example] Immobilien.
Umfang: 150 Stunden, 3 Monate Laufzeit, Festpreis 15.000€.

## Leistungsumfang
- Migration 12 Objekte aus [Legacy System] nach [ERP System]
- Datenbereinigung und Mapping
- 2 Testmigrationen mit Abnahme
- Go-Live-Begleitung (2 Tage vor Ort)
- 4 Wochen Nachbetreuung

## Konditionen
- Festpreis: 15.000€ netto
- Zahlungsplan: 30% bei Beauftragung, 40% nach Testmigration, 30% nach Go-Live
- Gültig bis: 15.03.2026

## Notizen
Am 20.02. besprochen. [Client-Example] will Nachverhandlung beim Zahlungsplan.
```

**Wenn Claude gefragt wird "Was steht im Angebot für [Client-Example]?"**
→ Claude liest die MD, antwortet vollständig. Fertig.

**Wenn du das PDF brauchst "Schick mir das Angebot als PDF"**
→ Claude sagt: "Liegt unter projects/migration-[Client-Example]/docs/angebot-phase-2.pdf"

### Multi-Perspektiven: Eine Quelle, mehrere Deutungen

Eine Binärdatei kann in mehreren Projekten als MD existieren –
jeweils mit anderem Fokus, anderen Notizen, anderem Kontext.

```
documents/vertraege/
  rahmenvertrag-[ERP System].pdf              ← Quelle: liegt einmal
  rahmenvertrag-[ERP System].md               ← Master: Gesamtübersicht, Watchdog

projects/migration-[Client-Example]/docs/
  rahmenvertrag-[ERP System]-migration.md     ← Perspektive Migration
    source_ref: "../../documents/vertraege/rahmenvertrag-[ERP System].pdf"
    projects: [migration-[Client-Example]]
    Body: Welche Klauseln betreffen die Migration?
          "§4.2: Maximale Migrationsdauer 48h"
          "§6.1: Datenformat muss CSV oder XML sein"

projects/tochter-alpha/docs/
  rahmenvertrag-[ERP System]-hosting.md       ← Perspektive Hosting
    source_ref: "../../documents/vertraege/rahmenvertrag-[ERP System].pdf"
    projects: [tochter-alpha]
    Body: Hosting-Konditionen, monatliche Kosten
          "99,5% SLA, Preisanpassung §7 jährlich"
          "Support-Hotline nur Mo-Fr 8-17 Uhr"
```

**Warum das mächtig ist:**
- Rachel bereitet ein Meeting zu Migration vor → findet die
  Migrations-Perspektive mit den relevanten Klauseln
- Louis prüft Fristen → findet die Master-MD mit Watchdog-Feldern
- Mike macht Querschnitt über Tochter Alpha → findet die
  Hosting-Perspektive mit den monatlichen Kosten
- Alle zeigen auf die GLEICHE PDF als Quelle

**Regeln:**
- Die Master-MD in documents/ hat die vollständigen Vertragsdetails
  und die Watchdog-Felder (Kündigungsfrist, Deadline etc.)
- Projekt-MDs sind Perspektiven: nur der für dieses Projekt
  relevante Ausschnitt, mit projektspezifischen Notizen
- `source_ref:` zeigt immer auf dieselbe Binärdatei (relativer Pfad)
- Wenn du fragst "Zeig mir den Vertrag" → Claude liefert die
  Master-MD. Wenn du fragst "Was bedeutet der Vertrag für die
  Migration?" → Claude liefert die Projekt-Perspektive.

**Nicht nur für Verträge:**
- Eine Kundenpräsentation → MD im Projekt (Inhalt + Feedback)
  + MD in documents/ (als Referenz für künftige Angebote)
- Eine Marktanalyse → MD in notes/knowledge/ (allgemein)
  + MD im Projekt (was bedeutet das für unser Angebot?)
- Ein Angebot → MD im Projekt (Konditionen, Verhandlung)
  + MD beim Folgeprojekt (als Vorlage, was hat funktioniert?)

### Was liegt wo?

```
FAUSTREGEL: "Brauche ich das noch wenn das Projekt endet?"

JA → documents/
  documents/vertraege/       Rahmenverträge, laufende Verträge
  documents/rechnungen/      Monatliche Rechnungen, Abos
  documents/belege/          Quittungen, Nachweise
  documents/sonstiges/       Policen, Zertifikate, Lizenzen

NEIN → projects/{slug}/docs/
  Angebote, Präsentationen, Statusberichte
  Projektspezifische Verträge, Arbeitsergebnisse
  Kundenkommunikation

GRAUZONE:
  Vertrag bezieht sich auf Projekt ABER läuft weiter?
  → documents/vertraege/ mit projects: [slug]
```

### Wann gibt es eine Binärdatei?

```
BINÄRDATEI EXISTIERT:                    BINÄRDATEI GIBT ES NICHT:
- Eingehende Verträge (PDF)              - Statusberichte (rein MD)
- Unterschriebene Angebote (PDF)         - Projektdokumentation (rein MD)
- Kundenpräsentationen (PPTX)            - Meeting-Notes (rein MD)
- Rechnungen von Dritten (PDF)           - Entscheidungslogs (rein MD)
- Scans, Belege (PDF/JPG)               - Leitfäden, How-Tos (rein MD)
- Eigene Rechnungen (generiert)          - Analysen (rein MD)
```

Die meisten Arbeitsergebnisse sind reine MDs.
Binärdateien kommen rein (externe Dokumente) oder
werden erzeugt (Präsentation fürs Kunden-Meeting).

### Wer erstellt die MDs?

- **Louis:** Binärdatei kommt rein → Louis liest den Inhalt,
  erstellt die MD mit vollständiger Zusammenfassung und Metadaten.
  Bei Verträgen: Watchdog-Felder automatisch befüllen.
- **Donna:** Mail-Attachment → Binärdatei ablegen + MD erstellen
- **Du + Claude:** Arbeitsergebnisse entstehen direkt als MD
- **Harold:** Prüft ob Binärdateien ohne MD existieren → Warnung

### Git

```gitignore
# Binärdateien – nur in GDrive, nicht in Git
*.pdf
*.pptx
*.docx
*.xlsx
*.png
*.jpg
*.jpeg
*.gif
*.zip
```

Git trackt nur MDs. Die Binärdateien leben in Google Drive.
Das Repo ist klein, aber die gesamte Verschlagwortung und
der Inhalt aller Dokumente ist versioniert.

---

## 4. Workflows (werden in WORKSPACE.md eingetragen)

### "Verarbeite meine Inbox" (→ donna)
1. Prüfe inbox/ auf neue Dateien (mobile/, documents/, mail/, voice/, claude-chats/)
2. Hole neue Mails via M365 MCP, kategorisiere und extrahiere
3. Gruppiere Mails nach Thread (Subject + References)
   → Neuer Thread = neuer Task, bestehender Thread = Task updaten
4. Für Mails die Antwort brauchen: Antwort-Draft erstellen
   (Persona aus contacts/ lesen, email-style Skill anwenden)
5. Attachments → Binärdatei ablegen + MD als primäres Dokument erstellen → louis für Verträge
6. Ordne projects: [] und areas: [] zu
7. Kontakte aktualisieren (last_contact, Kommunikationslog)
   → Absender unbekannt? Outlook-Kontakte per MCP prüfen → vorschlagen
8. Follow-Up: Gesendete Mails ohne Antwort nach 5 Tagen → Task
9. Verarbeitete Items → archive/YYYY-MM/
10. Briefing schreiben

### "Erstell meinen Tagesplan" (→ harvey)
1. Lies Briefings von donna + louis
2. Hole Kalender (M365 MCP)
3. Offene Tasks sortiert (überfällig > heute > Woche > urgent)
4. Follow-Ups fällig? (awaiting_response Tasks)
5. Gestrige journal/ → offene Punkte
6. OKRs checken
7. Erstelle journal/YYYY-MM-DD.md
8. Meeting-Note-Vorlagen für Termine > 30min

### "Tagesabschluss" (→ katrina)
1. Tagesplan lesen
2. Pro Task: Erledigt → status: done, completed: Datum
3. Nicht erledigt → due morgen
4. Zeiterfassung pro Projekt
5. Journal ergänzen
6. Zusammenfassung

### "Querschnittsanalyse [Area]" (→ mike)
1. INDEX.md → Dateien mit areas: [area]
2. Nur Frontmatter scannen
3. Relevante vollständig lesen
4. Gruppieren nach Projekten
5. Tasks, Verträge, Kosten, Kontakte zeigen
6. Anomalien: Kosten-Ausreißer, inaktive Projekte, einschlafende Kontakte

### "Bereite Meeting vor" (→ rachel)
1. Kontakte laden inkl. Persona (Kommunikationsstil, Dos/Don'ts)
2. Projekt-Status aus README.md
3. Offene Tasks
4. Letzte 2-3 Meetings
5. Relevante Entscheidungen aus notes/knowledge/decisions/
6. Agenda-Vorschlag

### "Wochenbericht + OKR Review" (→ jessica)
1. Erledigte Tasks (nach Projekt)
2. Zeiterfassung summiert
3. Meeting-Kernentscheidungen
4. OKR-Fortschritt aktualisieren
5. Kommunikations-Health: Einschlafende Kontakte
6. Anomalien einbeziehen
7. Strategische Warnungen
8. Ausblick nächste Woche

### "Dokument verarbeiten" (→ louis)
1. Typ bestimmen (Vertrag, Rechnung, Angebot, Präsentation, Bericht, Beleg)
2. Binärdatei lesen, Inhalt vollständig verstehen
3. MD als primäres Dokument erstellen:
   - source_ref: Pfad zur Binärdatei oder URL zum Original
   - Body: Vollständiger Inhalt – niemand muss die Binärdatei öffnen
4. Vertrags-Watchdog bei Verträgen:
   - Kündigungsfrist, cancellation_deadline errechnen
   - Auto-Verlängerung? Preisanpassungsklauseln?
   - Task anlegen für Kündigungsentscheidung
5. projects: [] und areas: [] zuordnen
6. Vertragsübersicht aktualisieren

### "Health Check" (→ harold)
1. Frontmatter-Validierung
2. Referenz-Integrität
3. Tagging-Suggestions für neue Dateien mit leeren areas/projects
4. Recurring Tasks: next_due erreicht → neue Task generieren
5. Verwaiste Binärdateien: PDF/PPTX/DOCX ohne zugehörige MD? → unsichtbar!
6. Inbox-Hygiene (>48h)
7. INDEX.md vs. Realität
8. Reparieren oder melden

### "Suche [Stichwort]"
1. INDEX.md durchsuchen
2. grep in tasks/, contacts/, notes/, documents/, projects/
3. Treffer mit Frontmatter-Kontext anzeigen
4. Top-5 mit relevantem Absatz

### "Neues Projekt [Typ] für [Kunde]"
1. Kickstart-Template aus templates/project-kickstart/ wählen
2. Nach projects/{slug}/ kopieren
3. Platzhalter mit echten Daten ersetzen
4. Standard-Tasks erstellen
5. WORKSPACE.md + INDEX.md updaten

### "Übergabe-Dokument für [Projekt]" (→ mike)
1. README.md, Kontakte mit Persona, offene Tasks
2. Letzte 5 Meetings, Verträge, Entscheidungslog
3. Risiken, Empfehlungen
→ projects/{slug}/docs/uebergabe-YYYY-MM-DD.md

### "Brain Dump verarbeiten" (→ donna)
1. inbox/mobile/ und inbox/claude-chats/ lesen
2. Pro Item: Typ erkennen (Task, Idee, Entscheidung, Wissen)
3. Am richtigen Ort ablegen mit Frontmatter
4. Action Items extrahieren → eigene Tasks
5. Originals → archive/

### Natural Language Queries
```
"Was schuldet mir [Firma]?" → documents/rechnungen/ summieren
"Wann läuft Vertrag mit [X] aus?" → documents/vertraege/ → valid_until
"Letztes Meeting mit [Kontakt]?" → notes/meetings/ filtern
"Offene Tasks [Projekt]?" → tasks/ filtern
"Wer ist [Name]?" → contacts/ → Persona + Projekte
"Wie kommuniziere ich mit [X]?" → contacts/ → Persona + Dos/Don'ts
"! [Text]"                       → Quick Capture (inbox/quick-capture/)
"!! [Text]"                      → Quick Capture priority: urgent
"Snap [Beschreibung]"            → Git Checkpoint + INDEX.md regenerieren
"Staging zeigen"                 → inbox/.staging/ anzeigen
"Staging bestätigen"             → Staged Aktionen ausführen
"Staging verwerfen"              → Staging-Queue leeren
"Blockt was?"                    → Alle Tasks mit status: blocked
"Wie lange brauchen wir noch?"   → lifecycle_phase + time_estimate_h Summe
"Schätzgenauigkeit [Projekt]"    → time_actual_h vs. time_estimate_h Ratio
```

---

## 5. Konventionen

### Slugs
- Lowercase, Bindestriche, max 25 Zeichen, eindeutig
- Ongoing: `holding-{name}`, `{tochter-kurzname}`, `{bereich}`
- Temporal: `{aktion}-{kontext}` (z.B. `migration-[Client-Example]`)
- Kontakte: `{nachname}-{firma}` oder `{firma}` (User entscheidet)

### Dateinamen
- Datierte Einträge: `YYYY-MM-DD_{slug}.md`
- Stammdaten: `{slug}.md`
- Briefings: `{agent-name}.md`

### Frontmatter
- Pflichtfelder Tasks: type, status, projects, created
- Pflichtfelder Kontakte: type, name, projects
- Pflichtfelder Projekte: type, project_type, status
- Pflichtfelder Knowledge: type, topic, created
- Arrays immer als `[]`, auch ein Wert: `[slug]`
- Leere Werte: `""` (nicht weglassen)
- Booleans: `true` / `false`

### Context-Window-Management
- **IMMER** INDEX.md zuerst lesen
- Bei >20 Dateien: nur Frontmatter scannen
- Body nur wenn Inhalt nötig
- NIEMALS alle Tasks/Kontakte/Meetings auf einmal lesen

### Berechtigungen
- workspace/ → Privat
- projects/{slug}/shared/ → Per GDrive für Kunden
- Niemals tasks/, contacts/, journal/ teilen

### Inbox
- Jeder kann Dateien direkt in inbox/ werfen (GDrive App, Scanner, Desktop)
- Optionale Hinweise im Dateinamen: `URGENT_xyz.pdf`, `projekt-slug_xyz.pdf`
- Donna verarbeitet alles morgens
- Quick Capture: `!` im Chat → inbox/quick-capture/ (unter 10 Sekunden)
- Staging: inbox/.staging/ = Approval Queue, nicht manuell befüllen

### Sensitivity Defaults (automatisch)
```
Automatisch confidential: documents/vertraege/, goals/
Automatisch internal:     contacts/, tasks/, notes/, journal/
Automatisch public:       projects/{slug}/shared/
Manuell restricted:       Explizit vom User gesetzt
```

### Blocked_by Konvention
```
- Immer relativer Pfad von workspace/ root
- Beispiel: blocked_by: [tasks/2026-02-18_schritt1.md]
- status: blocked MUSS gesetzt sein wenn blocked_by gesetzt ist
- status: open MUSS gesetzt werden wenn blocked_by entfernt wird
- Harold prüft täglich auf Inkonsistenzen
```

### Zeiterfassung Konvention
```
- time_estimate_h: harvey setzt beim Erstellen des Tagesplans
- time_actual_h: katrina fragt beim Tagesabschluss
- time_date: katrina setzt auf heutiges Datum
- 0 = nicht erfasst (leer lassen ist auch OK)
- jessica analysiert Schätzgenauigkeit wöchentlich
```

### Lifecycle-Phasen (nur temporal Projekte)
```
initiation:   Projekt genehmigt, Scope unklar
planning:     Scope definiert, Tasks erstellt, Team bekannt
execution:    Aktive Umsetzung
monitoring:   Go-Live erfolgt, Nachbetreuung / Hypercare
closure:      Abnahme, Dokumentation, Postmortem
Erwartete Dauer: initiation 1-2W | planning 2-4W | monitoring 2-4W | closure 1-2W
jessica prüft freitags ob lifecycle_next_review überschritten
```
