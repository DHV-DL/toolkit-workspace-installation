# IMPLEMENTATION.md – Implementierungsplan & Meilensteine

> Abgeleitet aus: BOOTSTRAP.md (25 Schritte), ARCHITECTURE.md, AGENTS.md, SYSTEMS.md
> Kernfrage: Wann bin ich produktiv? Was kann parallel laufen? Wo besser nicht?

---

## Übersicht: Von Bootstrap zu Betrieb

```
┌─────────────────────────────────────────────────────────────────────┐
│                                                                     │
│  FUNDAMENT        MVP            STUFE 1        STUFE 2      STUFE 3│
│  (Tag 1-2)     (Tag 3-5)      (Woche 2-3)   (Woche 4-6)  (Monat 3)│
│                                                                     │
│  Ordner         Harvey+Donna    Louis+Rachel  Jessica+Mike  Auto-   │
│  Profile        Quick Capture   Verträge      OKR-Reviews   matik   │
│  Kontakte       Tagesplan       Meetings      Retro         Cron    │
│  Git            Inbox-Flow      Personas      Dashboard     A2A     │
│                                                                     │
│  ──── PRODUKTIV AB HIER ────►                                       │
│       (Ende Tag 5)                                                  │
│                                                                     │
└─────────────────────────────────────────────────────────────────────┘
```

---

## FUNDAMENT (Tag 1–2) – Ohne das geht nichts

> Bootstrap-Schritte 1A, 1B, 2–6 + 16. Streng sequentiell.
> Hier besser KEIN paralleles Arbeiten – Entscheidungen bauen aufeinander auf.
> ⚠️ Alle Connections (Notion + M365) MÜSSEN vor Schritt 2 stehen.

### Tag 1: Infrastruktur + Connections + Datenmodell

| # | Bootstrap-Schritt | Was passiert | Dauer | Abhängigkeit |
|---|-------------------|-------------|-------|--------------|
| 1A | Infrastruktur & Grundlagen | GDrive-Mount, Symlink, Git/CLI prüfen | 15 min | – |
| 1B | Alle Connections einrichten | Notion MCP + M365 MCP Setup + Tests | 60-90 min | Schritt 1A |
| 2 | Notion scannen | Inventar, Tiefenanalyse, Konfidenz | 45 min | Schritt 1B (Notion) |
| 3 | Designentscheidungen | Slugs, Areas, Mappings, Status | 60 min | Schritt 2 |
| 4 | Ordnerstruktur | Alle Ordner + Templates + .gitkeep | 15 min | Schritt 3 |

**Meilenstein F1: Leerer Workspace steht, Connections getestet, Konventionen fixiert.**

### Tag 2: Identität + Konfiguration

| # | Bootstrap-Schritt | Was passiert | Dauer | Abhängigkeit |
|---|-------------------|-------------|-------|--------------|
| 5 | Profil & Unternehmen | PROFILE.md + COMPANY.md | 90 min | Schritt 4 |
| 6 | Konfiguration | WORKSPACE.md, CLAUDE.md, Templates, Rules | 60 min | Schritt 5 |
| 16 | Git einrichten | git init, .gitignore, erster Snap | 5 min | Schritt 6 |

**Meilenstein F2: Workspace hat Identität. Git-Baseline steht. Ab jetzt ist jede Änderung versioniert.**

### ⚠️ Warum NICHT parallel?

Schritt 3 (Designentscheidungen) beeinflusst ALLES danach: Slug-Konventionen fließen in Templates, WORKSPACE.md, Agent-Prompts und alle Dateien. Wer hier parallelisiert, macht Doppelarbeit.

---

## MVP (Tag 3–5) – Ab hier bist du produktiv

> Ziel: "Was steht an" funktioniert. Quick Capture funktioniert.
> Donna + Harvey liefern Wert. Tagesrhythmus ist möglich.

### Tag 3: Kontakte + Projekte migrieren

**Hier kann parallel gearbeitet werden (2 Terminals):**

```
TERMINAL 1                          TERMINAL 2
──────────────────────────          ──────────────────────────
Schritt 7: Kontakte migrieren      Schritt 8: Projekte migrieren
(Notion + Outlook Merge)            (READMEs, Docs)
~60 min                              ~45 min

Bedingung: Schritt 3 (Slugs) ist abgeschlossen.
Kontakte und Projekte referenzieren sich gegenseitig,
aber die Frontmatter-Arrays (projects:[], contacts:[])
können nachträglich befüllt werden.
```

| # | Bootstrap-Schritt | Terminal | Dauer |
|---|-------------------|----------|-------|
| 7 | Kontakte migrieren | T1 | 60 min |
| 7b | Mail & Kalender Backfill | T1 | 30–60 min |
| 8 | Projekte migrieren | T2 | 45 min |
| 9 | Tasks migrieren | T1 (nach 7) | 45 min |
| 10 | Meeting-Notes migrieren | T2 (nach 8) | 30 min |

**Meilenstein MVP1: Daten im Workspace. Projekte, Kontakte, Tasks sind da.**

### Tag 4: Kern-Agents aufsetzen

**Sequentiell – Agent-Definitionen referenzieren einander:**

| # | Bootstrap-Schritt | Was passiert | Dauer |
|---|-------------------|-------------|-------|
| 12 | Agents anlegen | Alle 9 Agent-Ordner + AGENT.md + config.yaml | 45 min |
| 18 | INDEX.md generieren | Erster vollständiger Index | 15 min |

Danach: **Erster manueller Test von Donna + Harvey.**

```
Test 1: "donna" → Mails holen, kategorisieren, Tasks erstellen
Test 2: "harvey" / "Was steht an" → Tagesplan aus INDEX.md + Briefings

Wenn das klappt: MVP erreicht.
```

**Meilenstein MVP2: Donna + Harvey laufen. Tagesplan wird erstellt.**

### Tag 5: Produktiv-Modus aktivieren

**Parallel möglich (2 Terminals):**

```
TERMINAL 1                          TERMINAL 2
──────────────────────────          ──────────────────────────
Schritt 19: Systemtest              Schritt 14: Skills anlegen
(10 Testfälle durchspielen)         (Email-Stil, Report-Stil)
~30 min                              ~30 min
```

| # | Schritt | Terminal | Dauer |
|---|---------|----------|-------|
| 19 | Systemtest (10 Fälle) | T1 | 30 min |
| 14 | Skills anlegen (6 MVP + 17 Platzhalter) | T2 | 60 min |
| 20 | Health Check (Harold) | T1 (nach 19) | 15 min |

**🎯 MEILENSTEIN MVP: SYSTEM IST PRODUKTIV.**

```
Was jetzt funktioniert:
  ✅ "Was steht an" → Tagesplan mit Top 3
  ✅ "! [Text]" → Quick Capture
  ✅ "donna" → Mails verarbeiten, Tasks erstellen, Drafts
  ✅ "harvey" → Tagesplan mit Zeitbudget + Blocking
  ✅ "Status [projekt]" → Projekt-Überblick
  ✅ "Wer ist [Name]" → Kontakt-Info
  ✅ "Snap [...]" → Git Checkpoint
  ✅ INDEX.md als zentrales Verzeichnis

Was NICHT funktioniert (und das ist OK):
  ❌ Automatische Cron-Jobs (manuell triggern)
  ❌ Vertrags-Watchdog (Louis noch nicht getestet)
  ❌ Meeting-Vorbereitung (Rachel noch nicht getestet)
  ❌ Wochenberichte (Jessica noch nicht getestet)
  ❌ Personas (Lipschitz noch nicht getestet)
  ❌ Zeiterfassung (Katrina optional)
  ❌ OKRs
  ❌ Dashboard
```

---

## AUSBAUSTUFE 1 (Woche 2–3) – Dokumenten-Intelligence + Meetings

> Fokus: Louis (Verträge), Rachel (Meetings), Katrina (Tagesabschluss)
> Hier viel parallel möglich – die Agents sind unabhängig voneinander.

**3 Terminals sinnvoll:**

```
TERMINAL 1: Louis               TERMINAL 2: Rachel + Lipschitz    TERMINAL 3: Katrina + Harold
────────────────────────         ────────────────────────           ────────────────────────
Verträge verarbeiten             Meeting-Vorbereitung testen        Tagesabschluss testen
Watchdog einrichten              Persona-Kickstart (3-5 Kontakte)   Zeiterfassung aktivieren
Fristen extrahieren              Skills: 6 MVP-Skills befüllen     Harold Full Check
Rechnungen erfassen              Schritt 15: Persona-Kickstart      Staging-Workflow testen

Dauer: ~3-4h verteilt           Dauer: ~2-3h verteilt              Dauer: ~1-2h verteilt
```

### Aufgaben im Detail

| Aufgabe | Agent | Kann parallel? | Abhängigkeit |
|---------|-------|----------------|--------------|
| Verträge aus Notion/GDrive verarbeiten | Louis | ✅ Ja | MVP abgeschlossen |
| Watchdog-Tasks für Kündigungsfristen | Louis | ✅ Ja | Verträge verarbeitet |
| Rechnungsablage strukturieren | Louis | ✅ Ja | MVP abgeschlossen |
| Meeting-Vorbereitung testen | Rachel | ✅ Ja | Kontakte + Projekte da |
| Persona-Kickstart (Top 5 Kontakte) | Lipschitz | ✅ Ja | Kontakte migriert |
| Tagesabschluss-Flow | Katrina | ✅ Ja | Harvey-Tagesplan existiert |
| Zeiterfassung aktivieren | Katrina | ✅ Ja | Katrina getestet |
| Staging-Workflow end-to-end testen | Harold | ✅ Ja | Donna oder Louis erzeugt Staging |
| OneDrive-Altablage migrieren (Schritt 24) | Mike | ✅ Ja | Ordnerstruktur steht |
| Notion Delta-Check #1 | Mike | ⚠️ Nach Woche 2 | 2 Wochen Nutzung als Basis |

### ⚠️ Wo NICHT parallel?

**Louis + Donna gleichzeitig auf denselben Verträgen** → Konflikte bei Staging-Einträgen. Donna liefert Anhänge an Louis weiter – das ist eine Pipeline, kein Parallelprozess.

**Meilenstein S1: Vertrags-Watchdog aktiv. Meetings werden vorbereitet. Tagesabschluss funktioniert.**

---

## AUSBAUSTUFE 2 (Woche 4–6) – Strategische Ebene + Automatisierung

> Fokus: Jessica (OKRs, Retro), Mike (Analysen), Orchestrator-Scripts
> Voraussetzung: 3-4 Wochen Daten im System für sinnvolle Auswertungen.

**2 Terminals:**

```
TERMINAL 1: Jessica + OKRs           TERMINAL 2: Automatisierung
────────────────────────              ────────────────────────
Schritt 11: OKRs aufsetzen           Orchestrator-Scripts testen
Erster Wochenbericht testen           Morgenroutine als Cron/manuell
Schätzgenauigkeit auswerten           Abendroutine als Cron/manuell
Erste System-Retrospektive            Freitagsroutine testen
                                      Test-Fixtures (Schritt 17)
```

| Aufgabe | Agent | Kann parallel? | Abhängigkeit |
|---------|-------|----------------|--------------|
| OKRs aufsetzen (Schritt 11) | – | ✅ Ja | MVP abgeschlossen |
| Erster Wochenbericht | Jessica | ⚠️ Nein | Mind. 1 Woche Briefings |
| System-Retro | Jessica | ⚠️ Nein | Mind. 4 Wochen Daten |
| Orchestrator-Morgen testen | – | ✅ Ja | Donna + Harvey getestet |
| Orchestrator-Abend testen | – | ✅ Ja | Katrina + Harold getestet |
| Orchestrator-Freitag testen | – | ⚠️ Nein | Jessica getestet |
| Cron-Jobs einrichten | – | ✅ Ja | Orchestratoren getestet |
| Test-Fixtures erstellen (Schritt 17) | – | ✅ Ja | Agents existieren |
| Querschnittsanalyse testen | Mike | ✅ Ja | Genug Daten in Areas |
| Notion Delta-Check #2 | Mike | ⚠️ Nach Woche 4 | 4 Wochen Nutzung |
| Notion abschalten | – | ⚠️ Nein | Delta = 0 bestätigt |
| Projekt-Kickstart-Templates (Schritt 13) | – | ✅ Ja | 1-2 Projekte manuell angelegt |

### ⚠️ Wo NICHT parallel?

**Jessica Wochenbericht VOR Orchestrator-Freitag** → Die Freitagsroutine ruft Jessica auf. Jessica muss erst standalone funktionieren.

**Notion abschalten VOR Delta-Check** → Offensichtlich, aber trotzdem: Nie Notion kündigen bevor Mike bestätigt hat dass alles migriert ist.

**Meilenstein S2: Orchestratoren laufen automatisch (oder semi-automatisch). OKRs existieren. Erste Retro durchgeführt. Notion kann abgeschaltet werden.**

---

## AUSBAUSTUFE 3 (Monat 3) – Polishing + Nice-to-have

> Ab hier kein Druck mehr. System läuft. Alles hier ist Optimierung.

**Kann komplett unabhängig und in beliebiger Reihenfolge bearbeitet werden:**

| Aufgabe | Schritt | Priorität | Parallel? |
|---------|---------|-----------|-----------|
| Dashboard HTML-Generierung | SYSTEMS.md §13 | Nice | ✅ Komplett unabhängig |
| Mobile Setup (Schritt 23) | BOOTSTRAP 23 | Mittel | ✅ Komplett unabhängig |
| Claude Memory setzen (Schritt 22) | BOOTSTRAP 22 | Mittel | ✅ Komplett unabhängig |
| Google Drive Shortcuts (Schritt 21) | BOOTSTRAP 21 | Nice | ✅ Komplett unabhängig |
| Correction-Tracking (Skill 24) | IDEEN.md | Hoch | ✅ Komplett unabhängig |
| Skill-Vorschlag / Emergenz (Skill 25) | IDEEN.md | Hoch | ✅ Komplett unabhängig |
| Continuous Improvement Loop | Skills 24+25 aktiv | ⚠️ Nach Skills 24+25 |
| Prompt-Versionierung | IDEEN.md | Nice | ✅ Komplett unabhängig |
| Demo-Skript für Vorführungen | IDEEN.md | Mittel | ✅ Komplett unabhängig |
| Token-Optimierung: Pulse als Skript | IDEEN.md | Hoch | ✅ Komplett unabhängig |
| Token-Optimierung: Harold als Skript | IDEEN.md | Mittel | ✅ Komplett unabhängig |
| Workspace-MCP Phase 1 (Read-Only) | IDEEN.md | Hoch | ✅ Komplett unabhängig |
| Workspace-MCP Phase 2 (Write) | Phase 1 fertig | Hoch | ⚠️ Nach Phase 1 |
| KPI-Dashboard für Reporting | IDEEN.md | Nice | ✅ Braucht 90 Tage Daten |

**Meilenstein S3: System ist polished. Alle Bootstrap-Schritte abgeschlossen. Bereit für Phase 2 (zweiter Nutzer).**

---

## Token-Optimierung Roadmap

> Mechanik in Skripte auslagern, LLM nur für Urteile rufen.
> Erst starten wenn Agent-Outputs 4+ Wochen stabil sind.

**Phase A (Monat 3): Pulse + Harold**
```
orchestrator/scripts/pulse-check.sh
  → find inbox/ -newer .last_pulse
  → grep "due: $(date)" tasks/**/*.md
  → ls inbox/.staging/ | wc -l
  → Wenn alles leer: "Pulse OK", KEIN Claude-Call
  → Wenn Fund: claude -p "Bewerte: [1-Zeiler]"
  Ersparnis: ~12.000 Tokens/Tag

orchestrator/scripts/harold-scan.sh
  → Frontmatter-Validierung (Python/Bash)
  → Health Score Berechnung (Formel)
  → INDEX.md Regenerierung (Template-basiert)
  → Nur Anomalien an Claude: "Bewerte diesen Report"
  Ersparnis: ~3.200 Tokens/Tag
```

**Phase B (Monat 4): Katrina + Jessica-Aggregation**
```
orchestrator/scripts/katrina-close.sh
  → Tasks mit done-Marker auf status: done setzen
  → Zeiterfassung aggregieren
  → Nur Bewertung + offene Fragen an Claude

orchestrator/scripts/jessica-aggregate.sh
  → Wochendaten sammeln (Tasks, Zeiten, Fristen)
  → Nur Analyse + Empfehlungen an Claude
```

**Phase C (Monat 6+): Intelligentes Routing**
```
orchestrator/scripts/should-call-llm.sh
  → Entscheidet pro Agent ob LLM nötig ist
  → Harold: 4/5 Tagen kein LLM nötig → 100% gespart
  → Pulse: 12/16 Checks kein LLM → 75% gespart
```

**Metrik:** Token-Verbrauch pro Tag tracken ab Stufe 1.
Jessica reportet wöchentlich: Calls/Tag + Tokens/Tag.
Optimierung erst wenn Baseline 4 Wochen stabil.

---

## AUSBAUSTUFE 4 (Q3-Q4 2026) – Skalierung

> Aus IDEEN.md und PITCH.md. Erst angehen wenn Phase 1 stabil läuft (8+ Wochen).

| Aufgabe | Voraussetzung | Parallel? |
|---------|---------------|-----------|
| Shared KI-Knowledgebase (HTML-Views) | Stabile Agent-Qualität | ✅ Ja |
| 7b | Mail & Kalender Backfill | T1 | 30–60 min |
| Toolkit Bridge Option A (inbox/toolkit-events/) | Erstes Toolkit produktiv | ✅ Ja |
| Toolkit Bridge Option B (Workspace-MCP-Server) | Option A validiert | ⚠️ Nach Option A |
| Workspace-MCP Phase 3 (Agent-Trigger) | Phase 2 + Token-Optimierung | ⚠️ Nach Phase 2 |
| Modell-Portabilitäts-Test (GPT-4o) | 4+ Wochen stabiler Betrieb | ✅ Ja |
| LangDock MCP-Integration testen | Workspace-MCP Phase 1 | ✅ Ja |
| LangDock Rollout-Pilot (1 Mitarbeiter) | MCP Phase 2 + LangDock Test | ⚠️ Sequentiell |
| Template-Repo für zweiten Nutzer | 8 Wochen Pilotbetrieb | ⚠️ Sequentiell mit Nutzer |
| Team-Architektur (shared/private Split) | Zweiter Nutzer konkret | ⚠️ Designentscheidungen zuerst |

**Meilenstein S4: Zweiter Nutzer ongeboardet. Template-Repo validiert.**

---

## AUSBAUSTUFE 5 (2027) – Rollout

> Aus PITCH.md Phase 3. Nur wenn Phase 2 funktioniert hat.

| Aufgabe | Voraussetzung |
|---------|---------------|
| Limitierte UI für Nicht-Techniker | Template-Repo stabil |
| Rollen-spezifische Agents | HV-Mitarbeiter-Profil definiert |
| Mandantentrennung | Datenschutz-Konzept |
| Agent-zu-Agent ohne Human Loop | 6+ Monate stabile Agent-Qualität |

**Meilenstein S5: Hausverwaltungs-Mitarbeiter arbeitet produktiv mit eigenem Workspace.**

---

## Parallelisierungs-Matrix (Zusammenfassung)

```
✅ = Sicher parallel     ⚠️ = Nur wenn unabhängige Daten     ❌ = Sequentiell

                  Donna  Harvey  Mike  Louis  Rachel  Katrina  Jessica  Harold
Donna               –      ❌     ✅    ⚠️      ✅      ✅       ✅       ✅
Harvey              ❌      –      ✅    ✅      ✅      ❌       ✅       ✅
Mike                ✅     ✅      –     ✅      ✅      ✅       ✅       ✅
Louis               ⚠️     ✅     ✅     –       ✅      ✅       ✅       ✅
Rachel              ✅     ✅     ✅     ✅       –       ✅       ✅       ✅
Katrina             ✅     ❌     ✅     ✅      ✅       –        ✅       ✅
Jessica             ✅     ✅     ✅     ✅      ✅      ✅        –        ❌
Harold              ✅     ✅     ✅     ✅      ✅      ✅       ❌        –

LEGENDE:
  Donna → Harvey:  ❌ Harvey LIEST Donna-Briefing. Muss danach laufen.
  Harvey → Katrina: ❌ Katrina LIEST Harvey-Tagesplan. Muss danach laufen.
  Jessica → Harold: ❌ Harold Full-Check NACH Jessica-Wochenbericht (Freitag).
  Donna ↔ Louis:   ⚠️ Donna liefert Anhänge → Louis verarbeitet. Pipeline.
```

---

## Kritische Pfade (was den Zeitplan verzögern kann)

| Risiko | Auswirkung | Mitigation |
|--------|------------|------------|
| M365 MCP funktioniert nicht | Donna kann keine Mails holen → kein MVP | Schritt 1B: Komplett einrichten + testen BEVOR weiter |
| Notion MCP funktioniert nicht | Scan + Migration unmöglich | Schritt 1B: Komplett einrichten + testen BEVOR weiter |
| Azure AD Permissions fehlen | M365 MCP auth-Fehler | Admin Consent in Schritt 1B explizit prüfen |
| Notion hat >500 Einträge | Schritt 2+7-10 dauern 2-3x länger | Batches, nur aktive Projekte |
| PROFILE.md wird zu dünn | Agents haben keinen Kontext für Drafts | 90 Min investieren, iterieren |
| GDrive-Sync ist langsam | Dateien erscheinen verzögert | Index-Regeneration nach Sync |
| Zu viele Designentscheidungen | Tag 1 wird zum Endlos-Meeting | Defaults akzeptieren, später ändern |

---

## Minimal-Einstieg: "Ich habe nur 3 Stunden"

```
Wenn du nicht 5 Tage hast sondern nur einen Nachmittag:

1. Schritt 1A+1B: Grundlagen + Connections      (75 min)
2. Schritt 3-4:   Designentscheidungen + Ordner  (45 min)
   (Schritt 2 Notion-Scan überspringen wenn keine Notion-Daten)
3. Schritt 5:     PROFILE.md minimal             (30 min)
4. Schritt 6:     WORKSPACE.md + Templates       (30 min)
5. Schritt 16:    Git init + Snap                (5 min)
6. Schritt 12:    Nur Donna + Harvey anlegen     (20 min)
7. Schritt 18:    INDEX.md generieren            (10 min)
8. Erster Test:   "Was steht an"                 (10 min)

= ~3.5 Stunden → "Was steht an" funktioniert, Mails fließen.
  Kontakte und Projekte kommen Tag für Tag dazu.
  System wächst organisch statt Big-Bang-Migration.
```

---

## Checkliste: "Bin ich schon produktiv?"

```
FUNDAMENT (muss alles ✅ sein):
  [ ] Ordnerstruktur steht
  [ ] Notion MCP verbunden + getestet
  [ ] M365 MCP verbunden + getestet (Mail + Kalender)
  [ ] PROFILE.md existiert (auch wenn minimal)
  [ ] WORKSPACE.md existiert
  [ ] Git initialisiert, erster Snap
  [ ] Mindestens 1 Projekt migriert

MVP (muss alles ✅ sein):
  [ ] Donna verarbeitet Mails → Tasks entstehen
  [ ] Harvey erstellt Tagesplan
  [ ] INDEX.md wird generiert
  [ ] "Was steht an" liefert sinnvollen Output
  [ ] "! [Text]" landet in quick-capture
  [ ] Snap funktioniert

STUFE 1 (empfohlen in Woche 2-3):
  [ ] Louis verarbeitet mindestens 1 Vertrag
  [ ] Rachel bereitet mindestens 1 Meeting vor
  [ ] Katrina schließt mindestens 1 Tag ab
  [ ] Top 5 Kontakte haben Personas

STUFE 2 (empfohlen in Woche 4-6):
  [ ] Orchestrator-Morgen läuft (manuell oder Cron)
  [ ] Jessica erstellt ersten Wochenbericht
  [ ] Notion Delta = 0 (bereit zur Abschaltung)
  [ ] OKRs existieren (falls gewünscht)
```
