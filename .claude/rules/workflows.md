# Workspace Workflows

## Quick Commands
- "donna" → Lies agents/donna/AGENT.md, führe Morgen-Workflow aus
- "harvey" / "Was steht an" → Lies agents/harvey/AGENT.md, Tagesplan
- "katrina" → Lies agents/katrina/AGENT.md, Tagesabschluss
- "mike, [Auftrag]" → Querschnitt / Anomalie / Migration
- "louis, [Dokument]" → Vertrag / Rechnung verarbeiten
- "rachel, [Kontakt/Thema]" → Meeting vorbereiten
- "jessica" → Wochenbericht + OKR Review
- "harold" / "Health" → Health Check (quick)
- "harold full" → Full Health Check
- "lipschitz, [Kontakt]" → Persona erstellen / aktualisieren
- "Status [slug]" → Projekt-README + offene Tasks + nächster Meilenstein
- "Wer ist [Name]" → contacts/ durchsuchen, Persona zeigen
- "Staging zeigen" → inbox/.staging/ auflisten
- "Staging bestätigen" → Staging-Einträge verarbeiten
- "Snap [label]" → git add -A && git commit -m "snapshot: [label]" + INDEX.md regenerieren
- "! [text]" → Quick Capture nach inbox/quick-capture/
- "!! [text]" → Quick Capture priority: urgent

## Routing
- Inbox/Mail → donna
- Tagesplan/Prioritäten → harvey
- Meetings/Termine → rachel
- Verträge/Rechnungen/Dokumente → louis
- Analysen/Recherche → mike
- Kontakte/Personas → lipschitz
- Tagesabschluss → katrina
- Berichte/Retros → jessica
- System-Health → harold

## Regeln
- Bei jedem neuen Chat: INDEX.md lesen (nicht alle Dateien scannen)
- Frontmatter ist die einzige Quelle für Metadaten
- Keine Aktion ohne passenden Agent (kein Freestyle)
- sensitivity: restricted/confidential → nie in Shared-Ordner
- Zeiterfassung: deaktiviert (kann später aktiviert werden)
- Lifecycle-Phasen: aktiv für temporale Projekte
