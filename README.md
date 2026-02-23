# Suits Workspace Toolkit

> *"Alles kommt zu dir. Du wechselst kein Fenster."*

Ein vollständiges AI-powered Knowledge & Task Management System für
Einzelpersonen und kleine Teams – gebaut auf **Claude Code**, dem
**PARA-Modell** und dem **ONE-TERMINAL-Prinzip**.

---

## Was ist das?

Dieses Toolkit ist ein produktionsreifes Setup-Kit für einen
AI-gestützten Workspace. Du bekommst:

- **9 spezialisierte Agents** (Donna, Harvey, Mike, Louis, Rachel,
  Katrina, Jessica, Harold, Dr. Lipschitz) – jeder mit eigenem
  Zuständigkeitsbereich
- **26 Skills** als wiederverwendbare Prozessbausteine
- **PARA-Ordnerstruktur** mit vollständiger Frontmatter-Konvention
- **25-Schritt Bootstrap** der dich von 0 auf produktiv bringt
- **Health-Score-System** das deinen Workspace automatisch überwacht
- **Orchestrator** für automatische Agent-Routinen

---

## Kernprinzipien

### ONE-TERMINAL-MANIFEST
```
✅ Agents holen Daten und liefern Synthesen
✅ Outputs: "Was tust du als nächstes?" – nicht "Hier sind Daten"
✅ Drafts, Pläne, Analysen landen direkt im Chat oder in Dateien
✅ Du tippst einen Befehl. Du bekommst eine Antwort. Fertig.

❌ "Schau mal kurz in Outlook"
❌ "Öffne Notion für die Details"
❌ Rohdaten ohne Interpretation
```

### Suits-Agents
| Agent | Rolle | Wann |
|-------|-------|------|
| Donna Paulsen | Mail, Inbox, Follow-Up, Drafts | Morgens |
| Harvey Specter | Tagesplan, Priorisierung | Nach Donna |
| Mike Ross | Analyse, Migration, Anomalien | On demand |
| Louis Litt | Verträge, Rechnungen, Watchdog | Bei Dokumenten |
| Rachel Zane | Meeting-Vorbereitung, Persona | Vor Meetings |
| Katrina Bennett | Tagesabschluss, Zeiterfassung | Abends |
| Jessica Pearson | Wochenbericht, OKR-Review | Freitags |
| Harold Gunderson | Health Check, Monitoring | Täglich |
| Dr. Lipschitz | Persona-Pflege, CRM-Intelligenz | On demand |

### Confidence-System
Alle Agents markieren Unsicherheiten explizit:
- `[HIGH]` → direkt ausführen
- `[MED]` → in `inbox/.staging/` zur Bestätigung
- `[LOW]` → Frage im Briefing an den User

---

## Voraussetzungen

1. **Claude Code** (claude CLI) installiert
2. **MCP-Server** nach Bedarf:
   - `@notionhq/notion-mcp-server` – für Notion-Integration
   - `@softeria/ms-365-mcp-server` – für M365/Outlook
   - Google Drive MCP – für GDrive-Integration
3. **Git** für Versionskontrolle
4. **Google Drive Desktop** (empfohlen) oder lokaler Ordner

---

## Schnellstart

```bash
# 1. Repo klonen
git clone https://github.com/DHV-DL/toolkit-workspace-installation.git workspace
cd workspace

# 2. Bootstrap starten
claude  # Claude Code öffnen
# Dann: "Lies BOOTSTRAP.md und starte bei Schritt 1"
```

Der Bootstrap-Guide in `BOOTSTRAP.md` führt dich durch alle
25 Schritte – von der Ordnerstruktur bis zum ersten vollständigen
Agent-Run.

---

## Was du anpassen musst

Bevor du den Bootstrap startest, passe diese 3 Dateien an:

| Datei | Was rein kommt |
|-------|---------------|
| `PROFILE.md` | Dein Name, Rolle, Arbeitsstil, Stärken/Schwächen |
| `COMPANY.md` | Dein Unternehmen, Struktur, Strategie, Kundenprofil |
| `WORKSPACE.md` | Deine Projekt-Slugs, Areas, Konventionen |

Beide sind als leere Templates vorhanden – füll sie aus, bevor
du Donna oder Harvey zum ersten Mal rufst.

---

## Skill-System

26 Skills definieren WIE die Agents arbeiten:

| Kategorie | Skills |
|-----------|--------|
| Inbound | inbound-triage, dokument-eingang |
| Outbound | email-stil, kanalregeln, follow-up-management, eskalation-kommunikation, brief-formal |
| Dokument-Lifecycle | vertrag-analyse, rechnung-verarbeitung, dokument-ablage |
| Projektmanagement | projekt-kickstart, projekt-status, uebergabe-dokument |
| Task-Management | task-erstellung, tagesplanung |
| Meeting | meeting-vorbereitung, meeting-protokoll, meeting-nachbereitung |
| CRM | kontakt-persona |
| Reporting | reporting, presentation-ci |
| Prozess & Wissen | sop-erstellung, cross-source-recherche, wissens-capture |
| System | correction-tracking, skill-vorschlag |

---

## Ordnerstruktur

```
workspace/
├── PROFILE.md          ← Über dich (Arbeitsstil, Expertise)
├── COMPANY.md          ← Über dein Unternehmen
├── WORKSPACE.md        ← Projekt-Slugs, Workflows, Commands
├── BOOTSTRAP.md        ← 25-Schritt Setup-Guide
├── ARCHITECTURE.md     ← Vollständige Struktur-Dokumentation
├── SYSTEMS.md          ← Index, Health Score, Protokolle
├── AGENTS.md           ← Alle Agent-Definitionen
├── agents/             ← Agent-Ordner (AGENT.md + config.yaml)
├── templates/          ← Alle Frontmatter-Templates
├── skills/             ← Prozess-Skills
├── orchestrator/       ← Automatische Agent-Routinen
├── projects/           ← PARA: Projekte (ongoing + temporal)
├── tasks/              ← Alle Tasks projektübergreifend
├── contacts/           ← Kontakte mit Persona-Profil
├── notes/              ← Meetings, Ideen, Knowledge
├── documents/          ← Verträge, Rechnungen, Belege
├── goals/              ← OKRs und Ziele
├── journal/            ← Tagesjournale, Briefings, Metriken
└── inbox/              ← Eingang: Mails, Scans, Quick Capture
```

---

## Lizenz

MIT License – siehe `LICENSE`

---

## Feedback & Beiträge

Issues und PRs willkommen auf GitHub.
