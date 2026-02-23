# Agent-Berechtigungsmatrix

## Principle of Least Privilege

Kein Agent greift auf mehr zu als er für seine Aufgabe benötigt.
Nicht gelistet = kein Zugriff.
Schreibzugriff auf sensitivity:restricted → niemals autonom (immer Staging/Eskalation).

| Agent     | Dateisystem (lesen)      | Dateisystem (schreiben)      | M365 Mail | M365 Kalender | Notion | GDrive |
|-----------|--------------------------|------------------------------|-----------|---------------|--------|--------|
| donna     | inbox/, contacts/, tasks/| inbox/, tasks/, contacts/    | Lesen+    | Lesen         | -      | -      |
| harvey    | journal/, tasks/, INDEX  | journal/                     | -         | Lesen         | -      | -      |
| mike      | Alles (lesen)            | inbox/.staging/ (Reports)    | -         | -             | Ja     | Ja     |
| louis     | documents/, inbox/       | documents/, inbox/.staging/  | Lesen     | -             | -      | -      |
| rachel    | notes/, projects/, contacts/ | notes/meetings/          | -         | Lesen         | -      | -      |
| katrina   | tasks/, journal/         | tasks/, journal/             | -         | -             | -      | -      |
| jessica   | Alles (lesen)            | journal/weekly/, journal/retro/ | -     | -             | -      | -      |
| harold    | Alles (lesen)            | INDEX.md, agents/*/errors.log, journal/metrics/ | - | -    | -      | -      |
| lipschitz | contacts/, inbox/        | contacts/                    | Lesen     | -             | -      | -      |

## Eskalationsmatrix

| Stufe | Beschreibung | Beispiele |
|-------|-------------|-----------|
| **Autonom** | Agent führt direkt aus | Frontmatter setzen, Tags vorschlagen, Drafts schreiben, INDEX.md aktualisieren, Quick-Capture verarbeiten |
| **Fragt** | Agent fragt im Briefing | Neue Kontakte anlegen, Tasks mit priority:urgent, [MED]/[LOW] Konfidenz-Items |
| **Staging** | Agent legt in inbox/.staging/ ab | Dateien überschreiben, archivieren, status:completed setzen, Dateien löschen, Verträge verarbeiten |
| **Eskaliert** | Agent stoppt und meldet | Alles mit sensitivity:confidential, Fehler > 3 Retries, Blocking-Deadlock |

## Regeln

- MCP-Server werden pro Agent in config.yaml explizit gelistet
- Donna darf Kontakte lesen + schreiben (Kommunikationslog)
- Harold ist der einzige Agent der INDEX.md schreiben darf
- Kein Agent liest oder schreibt PROFILE.md (nur User und harvey lesen)
- sensitivity: restricted → kein Agent handelt autonom → immer Eskalation
- sensitivity: confidential → nur louis und harold dürfen anfassen, nur via Staging

## Correction-Mechanismus (alle Agents)

Jeder Agent hat einen corrections/-Ordner: agents/{name}/corrections/

**Input (vor jeder Ausführung):**
Lies corrections/ → letzte 10 chronologisch + Top-5 nach applied_count.
Wende passende Learnings an. Erhöhe applied_count bei Anwendung.

**Output (bei User-Korrektur):**
User sagt "Korrektur: [was]" → Agent erstellt Correction-Datei:
  agents/{name}/corrections/YYYY-MM-DD-{kurzbeschreibung}.md

**Skill-Vorschlag (bei Improvisation):**
Agent improvisiert ohne passenden Skill → interner Zähler.
Bei 3+ ähnlichen Improvisationen → Skill-Entwurf in inbox/.staging/skills/
Harold meldet Vorschläge im Health Check.
