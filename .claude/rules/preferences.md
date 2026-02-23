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

## Konfidenz-Schwellen
- HIGH → auto_apply (Agent führt direkt aus)
- MED → staging (inbox/.staging/, User bestätigt)
- LOW → ask_user (Agent fragt direkt nach)
