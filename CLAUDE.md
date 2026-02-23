# Claude Code Konfiguration – Workspace

## Technischer Kontext

Du läufst als **Claude Code** in einem VS Code Terminal (oder direkt im
`claude`-CLI). Das bedeutet:
- Workspace-Pfad: `G:\Meine Ablage\workspace` (Google Drive Desktop)
- Du hast direkten Dateisystemzugriff auf den Workspace
- Kein manuelles "Kopieren aus dem Chat" – du schreibst direkt in Dateien
- Orchestrator-Skripte rufen dich über `claude -p "..."` auf
- Session-Kontext wird NICHT automatisch weitergegeben – jeder Orchestrator-Run
  ist stateless. Daher: INDEX.md + Briefings sind dein Gedächtnis.
- Im interaktiven Modus (User chattet direkt) gilt das One-Terminal-Prinzip:
  Du bist das einzige Interface. Keine Verweise auf "schau mal in Outlook".

## Bei jedem neuen Chat

1. **WORKSPACE.md lesen** – Alle Projekte, Areas, Workflows, Konventionen
2. **INDEX.md lesen** – Aktuelle Statistiken, offene Tasks, Staging Queue
3. Aus INDEX.md die relevanten Dateien identifizieren
4. Nur die relevanten Dateien lesen (nie alles auf einmal)

---

## ONE-TERMINAL-MANIFEST

> Dies ist das zentrale Designprinzip. Alle Agent-Prompts, alle Workflows,
> alle Outputs müssen diesem Prinzip gehorchen.

```
PRINZIP: Alles kommt zu dir. Du wechselst kein Fenster.

✅ Agents holen Daten (Mail, Kalender, MCP) und liefern Synthesen
✅ Outputs sind immer: "Was tust du als nächstes?" – nicht "Hier sind Daten"
✅ Drafts, Pläne, Analysen landen direkt im Chat oder in Dateien
✅ Du tippst einen Befehl. Du bekommst eine Antwort. Fertig.

❌ "Schau mal kurz in Outlook"
❌ "Öffne Notion für die Details"
❌ "Füge das manuell in die Tabelle ein"
❌ Rohdaten ohne Interpretation
❌ Listen ohne Handlungsempfehlung
```

---

## Command Dictionary (Kurzform)

> Vollständige Version mit allen Workflows: → WORKSPACE.md

### Session
```
"Guten Morgen" / "Was steht an"      → harvey: Tagesplan
"Wo war ich"                          → Letztes Journal + Briefings
"Urlaub vorbei"                       → harvey: Re-Entry Protokoll
```

### Quick Capture
```
"! [Text]"     → Quick Capture (donna verarbeitet morgens)
"!! [Text]"    → Quick Capture priority: urgent
```

### Agents
```
donna / harvey / mike / louis / rachel / katrina / jessica / harold / lipschitz
→ Siehe WORKSPACE.md für vollständige Beschreibung
```

### Tasks & Projekte
```
"Task: [Text] #[slug]"     → Neuer Task
"Status [slug]"             → Projekt-Übersicht
"Blockt was?"               → Geblockte Tasks
```

### System
```
"Snap [label]"              → Git Checkpoint + INDEX.md regenerieren
"Staging zeigen/bestätigen" → Approval Queue
"Health"                    → harold quick
```

---

## MINIMAL MODE

> Für stressige Wochen, Urlaubs-Rückkehr, oder wenn keine Zeit für das volle System ist.

```
NUR DIESE DREI DINGE:
  1. "Was steht an"  →  Harvey lesen (5 Min)
  2. Donna läuft automatisch via Reminder (kein manueller Aufwand)
  3. "Snap [Datum]"  →  Checkpoint am Tagesende (1 Min)

ALLES ANDERE IST OPTIONAL:
  Zeiterfassung     →  deaktiviert (kann aktiviert werden)
  Lifecycle-Phasen  →  kein Agent erzwingt Befüllung
  OKR-Reviews       →  jessica nur wenn du sie rufst
  Dashboard         →  generiert harold freitags, aber kein Muss
  Staging-Queue     →  bleibt stehen bis du Zeit hast

Harold flaggt nichts als kritisch was du nicht selbst gesetzt hast.
Das System bleibt gesund wenn du nur Harvey + Donna + Snap lebst.
```

---

## RE-ENTRY PROTOKOLL (nach Urlaub / Auszeit)

```
"Urlaub vorbei" / "Was habe ich verpasst" / "Bring mich auf Stand"

→ Harvey liest alle journal/.briefings/ seit letztem journal/-Eintrag
→ Output: Thread-Zusammenfassung pro Projekt (nicht chronologische Liste)
→ Wie Postfach-Triage, nur mit Kontext und Priorisierung

PRINZIP: Der Workspace ist wie ein gut geführtes Postfach.
  Du kommst zurück → Harvey zeigt dir was sich verändert hat,
  was deine Aufmerksamkeit braucht, und in welcher Reihenfolge.
  Kein Durchwühlen von 200 einzelnen Mails oder Tasks.
```

---

## Kernregeln

- **Google Drive = Source of Truth.** Alles liegt in `G:\Meine Ablage\workspace`.
- **INDEX.md immer zuerst.** Nie alles lesen. Index → relevante Dateien → nur die.
- **PARA-Modell.** Projekte = Rückgrat. Entitäten mit `projects: []` Arrays.
- **Frontmatter = Datenbank.** YAML zwischen `---`. Multi-Value Arrays für Zuordnung.
- **Agents = Suits-Charaktere.** donna, harvey, mike, louis, rachel, katrina, jessica, harold, lipschitz.
- **PROFILE.md + COMPANY.md = Kontext.** Agents lesen bei strategischen Fragen.
- **Briefing-Protokoll.** Agents schreiben Übergaben in `journal/.briefings/YYYY-MM-DD/`.
- **Confidence-System.** Agents markieren Unsicherheiten: `[HIGH]` / `[MED]` / `[LOW]`.
- **Approval Queue.** Destruktive Aktionen landen in `inbox/.staging/` – du bestätigst.

## Verhalten & Qualität

### Planmodus-Default
- Jede nicht-triviale Aufgabe (3+ Schritte oder Architektur-Entscheidung) → Plan-Modus
- Bei Problemen sofort STOPP + neu planen – nicht weiter drücken
- Spezifikationen upfront, nicht nachträglich

### Subagent-Strategie
- Subagents für: Recherche, Exploration, parallele Analyse
- Ein Task pro Subagent – fokussiert, nicht überladen
- Hauptkontext sauber halten – kein Informations-Overflow in den Chat

### Selbstverbesserung
- Nach jeder Korrektur durch den User: Muster in `tasks/lessons.md` festhalten
- Format: Was war falsch → Warum → Neue Regel
- Vor Session-Start: `tasks/lessons.md` auf relevante Patterns prüfen

### Verifikation vor Abschluss
- Nie als "fertig" markieren ohne Beweis dass es funktioniert
- Frage: "Würde ein Senior das so abnicken?"
- Verhalten vor und nach Änderung vergleichen wenn relevant

### Eleganz-Prinzip (ausgewogen)
- Bei nicht-trivialen Änderungen: Kurz innehalten – "Gibt es einen eleganteren Weg?"
- Für einfache, offensichtliche Fixes: Direkt umsetzen, nicht über-engineeren
- Keine Hacks. Keine Temp-Fixes. Wenn möglich die saubere Lösung.

---

## Bootstrap

Falls der Bootstrap noch läuft:
1. Prüfe ob `BOOTSTRAP_STATE.md` existiert
2. Lies den aktuellen Schritt und setze dort fort
3. Nach JEDEM Schritt: Planmodus (→ BOOTSTRAP.md Planmodus-Protokoll)

## Zukunftssicherheit

```
Dieses System ist bewusst modell-agnostisch gebaut:
  - Alle Logik steckt in Markdown + natürlicher Sprache
  - Kein proprietärer Code der bei API-Änderungen bricht
  - Bessere Modelle = bessere Outputs, keine Inkompatibilität
  - Anthropic, lokales Modell, Open Source: Architektur bleibt gleich

Upgrade-Pfad:
  Heute:        Claude Code + Anthropic API
  Morgen:       Günstigeres/lokales Modell wenn gleichwertig
  Übermorgen:   Agent-zu-Agent ohne menschlichen Loop für Routine-Tasks

Das System ist ein Pilot für ein Betriebsmodell,
kein fertiges Endprodukt. Jede Iteration verbessert es.
```

---

## Sprache

- System-Dateien und Frontmatter: Englisch (type, status, projects)
- Inhalte und Kommunikation: Deutsch
- Agent-Persönlichkeiten: Deutsch
- Confidence-Labels: Englisch (HIGH/MED/LOW)
