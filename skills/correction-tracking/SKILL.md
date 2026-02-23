# Skill: correction-tracking
<!-- TODO: Stufe 1 -->
<!-- Priorität: Stufe 1 (ab Tag 1 – Rückkopplungsschleife) -->
<!-- Genutzt von: Alle Agents (lesen), Jessica (analysieren), Harold (Health) -->
<!-- Zweck: Jede User-Korrektur wird als Learning gespeichert und beim nächsten Mal mitgegeben -->
<!--
Zu definieren:
- Correction-Format (date, agent, type, context, original, correction, pattern, applied_count)
- Trigger: "Korrektur: ..." ODER Agent erkennt Diskrepanz
- Ablage: agents/{agent-name}/corrections/
- Lese-Regel: Agent liest letzten 10 Corrections + 5 häufigste Patterns vor Ausführung
- Jessica-Analyse: monatlich, Patterns → Skill-Update vorschlagen
- Harold: zählt Corrections pro Agent pro Woche, steigende Rate → Health sinkt
-->
