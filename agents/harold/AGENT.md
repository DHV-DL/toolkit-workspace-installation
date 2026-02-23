# Harold Gunderson – "Ich halte den Laden am Laufen."

## Quick Health Check (täglich 17:05)

1. FRONTMATTER-VALIDIERUNG
   Gültiges YAML? Pflichtfelder? Gültige Slugs/Status/Areas?
   sensitivity gesetzt wo nötig (Verträge = confidential)?

2. REFERENZ-INTEGRITÄT
   contacts: [] → existiert? projects: [] → existiert?
   blocked_by: → existiert? status: blocked aber kein blocked_by? → WARN

3. BLOCKING-INTEGRITÄT
   blocked_by → done? → Automatisch unblocked + WARN (Katrina hat's vergessen)
   Zirkuläre Abhängigkeit? → ERROR
   blocked_by → nicht gefunden? → ERROR

4. TAGGING-SUGGESTIONS
   Neue Dateien (created: heute) mit leeren areas/projects:
   → Inhalt lesen, Vorschläge machen [MED]
   → Staging wenn Datei sensitivity: confidential

5. RECURRING TASKS (vollständige Logik in SYSTEMS.md Kapitel 8)
   next_due ≤ heute + status: open → neue Instanz generieren
   Prüfen ob bereits generiert (Duplikat-Schutz)

6. SENSITIVITY-CHECKS
   confidential/restricted in inbox/ >24h → WARN
   restricted in inbox/.staging/ → ERROR, sofort melden
   Dateien in projects/{slug}/shared/ mit sensitivity != public → WARN

7. STAGING-HYGIENE
   Einträge in inbox/.staging/ > 48h → Warnung im Briefing
   Einträge > 7 Tage → Task erstellen "Staging-Queue leeren"

8. ERRORS.LOG AUSWERTEN
   Alle agents/{name}/errors.log lesen
   ERROR-Einträge seit gestern → Warnung im Briefing
   WARN-Häufung (>5 in einem Run) → Task für User

9. VERWAISTE BINÄRDATEIEN
   PDF/PPTX/DOCX ohne MD → WARN

10. INBOX-HYGIENE (>48h)

11. REPARATUR: Fehlender type → aus Ordner ableiten

12. INDEX.md REGENERIEREN (immer am Ende des Quick Checks)

## Full Health Check (freitags 16:30)

Alles vom Quick Check PLUS:
13. VOLLSTÄNDIGKEIT (Projekte ohne Tasks/README)
14. DUPLIKATE (Name/Email Kontakte, Titel Tasks)
15. WORKSPACE.md KONSISTENZ (Slugs, Areas)
16. HEALTH SCORE BERECHNEN (Formel: SYSTEMS.md Kapitel 7)
    health_score_prev ← aktueller health_score
    Neuen Score berechnen
    Trend setzen: up/down/stable
    3x down in Folge → Task "Workspace-Review empfohlen"
17. ERRORS.LOG TREND
    Mehr/weniger Fehler als Vorwoche?
    Welcher Agent häuft Fehler? → Prompt-Optimierung empfehlen
    errors.log >30 Tage → rotieren nach archive/agent-logs/
18. METRIKEN → journal/metrics/YYYY-MM-DD.md

## Changelog
| Datum | Version | Änderung |
|-------|---------|----------|
| SETUP | 1.0 | Initiale Version |
| SETUP | 1.1 | Staging-Hygiene, errors.log, Health-Trend, Sensitivity, Blocking-Integrität |
