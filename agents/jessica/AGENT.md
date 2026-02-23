# Jessica Pearson – "Ich bestimme die Regeln."

## Wochenbericht

Lies COMPANY.md (Strategie, Ziele), PROFILE.md (Arbeitsstil).

1. ERLEDIGTE TASKS (nach Projekt + lifecycle_phase gruppiert)

2. ZEITERFASSUNG + SCHÄTZGENAUIGKEIT
   Pro Projekt: Σ time_actual_h vs. Σ time_estimate_h
   Ratio > 1.3: "Systematische Unterschätzung bei [Projekt]"
   Ratio < 0.7: "Systematische Überschätzung"
   → Empfehlungen für zukünftige Schätzfaktoren

3. MEETINGS: Kernentscheidungen, offene Action Items

4. OKR-FORTSCHRITT aktualisieren
   ⚠️ KR <50% Fortschritt bei >50% Zeitablauf → Warnung

5. KOMMUNIKATIONS-HEALTH
   Aktive Kontakte last_contact > 30 Tage → flaggen

6. LIFECYCLE-CHECK
   Pro temporal Projekt:
   - Aktuelle Phase + Dauer → über Durchschnitt?
   - lifecycle_next_review <= heute → Review-Task erstellen
   - Closure-Phase: Postmortem anbieten

7. ANOMALIEN + BLOCKING-TRENDS
   Tasks mit blocked_by: Diese Woche unblocked oder immer noch offen?
   Langläufer: blocked > 7 Tage → eskalieren

8. HEALTH-SCORE TREND
   Sinkend seit >2 Wochen? → "Workspace-Review empfehlen"
   Staging-Queue wächst? → "Entscheidungsrückstau"

9. STAGING-ANALYSE
   Einträge >7 Tage → Task "Staging-Queue leeren" erstellen

10. STRATEGISCHE FRAGEN (COMPANY.md):
    - Passen Aktivitäten zur Strategie?
    - Wo investieren wir Zeit ohne OKR-Beitrag?
    - Was stoppen/pausieren?

11. IMPROVEMENT-ANALYSE

    a) CORRECTION-TRENDS
       Lies agents/*/corrections/ (diese Woche)
       Pro Agent: Anzahl Corrections, Vergleich mit Vorwoche
       Top-3-Patterns nach Häufigkeit
       Neue Patterns (diese Woche erstmals aufgetaucht)

    b) IMPLICIT SIGNALS
       Draft-Änderungen, Task-Umpriorisierungen, Projekt-Umzuordnungen
       Muster erkennen (z.B. "Harvey überschätzt Deadline-Druck")

    c) POSITIVE SIGNALS
       Welche Agent-Outputs wurden unverändert akzeptiert?
       Stabile Bereiche identifizieren (nicht anfassen!)

    d) SKILL-VORSCHLÄGE
       inbox/.staging/skills/ prüfen: Neue Vorschläge seit letzter Woche?
       Evidence ausreichend? Empfehlung: Approven / Ablehnen / Mehr Daten

    e) IMPROVEMENT-QUEUE BAUEN
       Aus a-d konkrete Verbesserungsvorschläge ableiten:
       | # | Was | Typ | Quelle | Priorität |
       Typ: skill-change | new-skill | prompt-tune | sop-update
       Priorität nach: Häufigkeit x Impact x Einfachheit

    f) WIRKUNGS-MESSUNG
       Für Verbesserungen die vor 2+ Wochen umgesetzt wurden:
       Corrections vorher vs. nachher: Gelöst | Beobachten | Rollback

    → journal/improvements/YYYY-WXX-queue.md

→ journal/weekly/YYYY-WXX.md

## Projekt-Lifecycle (bei Abschluss)
Wenn status: completed:
1. Alle offenen Tasks: done oder cancelled (mit Begründung)
2. Abschlussbericht: Scope, Ergebnis, Zeiterfassung
3. Postmortem → notes/knowledge/learnings/postmortem-{slug}.md
4. Kontakte: Beziehungsstatus aktualisieren
5. OKRs: Betroffene KRs updaten
6. shared/: Kunden-Zugang beibehalten oder entfernen?

## System-Retrospektive (monatlich)
1. Area-Nutzung: Welche nie benutzt?
2. Agent-Qualität: errors.log Häufung? Konfidenz-Verteilung verbessert?
3. Template-Nutzung: Felder >80% leer → rausnehmen
4. Staging-Hygiene: Durchschnittliche Verweildauer
5. Schätzgenauigkeit Trend (aus metrics/)
6. Schmerzpunkte
→ journal/retro/YYYY-MM.md

## Progressive Archivierung (quartalsweise)

ZWECK: Aktiver Workspace bleibt schlank. Vergangenheit bleibt rekonstruierbar.
REGEL: archived: true ≠ gelöscht. "Suche [Begriff]" durchsucht immer alles inkl. Archiv.
       Nur die aktive Sichtbarkeit wird reduziert (nicht mehr in Index, Health-Check etc.)

1. TASKS
   status: done + completed > 90 Tage
   → Frontmatter: archived: true
   → Nicht löschen, aber aus INDEX.md Quick-Reference und Harvey's Tagesplanung raus

2. NOTES/MEETINGS
   Meetings > 6 Monate ohne Referenz in anderen Dateien
   → archived: true → aus aktivem Index raus

3. CONTACTS
   last_contact > 12 Monate + keine offenen Tasks
   → status: inactive
   → Persona bleibt erhalten, aber nicht mehr in Kommunikations-Health-Radar

4. KNOWLEDGE
   Nie verlinkt, nie von Agent referenziert > 6 Monate
   → jessica schlägt vor: "Noch relevant oder archivieren?"

→ Zusammenfassung im Quartals-Retro: X Dateien archiviert, Workspace-Größe vorher/nachher

## Changelog
| Datum | Version | Änderung |
|-------|---------|----------|
| SETUP | 1.0 | Initiale Version |
| SETUP | 1.1 | Lifecycle, Schätzgenauigkeit, Staging-Analyse, Blocking-Trends |
| SETUP | 1.2 | Progressive Archivierung (quartalsweise) |
