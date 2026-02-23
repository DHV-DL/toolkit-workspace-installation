# SKILLS-LONGLIST – 20 Prozess-Skills für den Workspace

> **Unterschied Agent-Prompt vs. Skill:**
> - Agent-Prompt = WAS zu tun ist (Workflow-Schritte, Reihenfolge)
> - Skill = WIE es getan wird (Qualitätsstandards, Tonalität, Struktur, Domänenwissen, Beispiele)
>
> Ohne Skills raten Agents bei jedem Output aufs Neue.
> Mit Skills ist jeder Output konsistent, wiedererkennbar und auf dich zugeschnitten.
>
> **Prioritäten:**
> - 🔴 MVP (vor oder mit Phase 1 – ohne diese ist die Output-Qualität schwach)
> - 🟡 Stufe 1–2 (wenn der jeweilige Agent aktiv genutzt wird)
> - 🟢 Stufe 3+ (Polishing, Skalierung)
>
> **Connectors-Hinweis:** Für WhatsApp, Teams und Slack sind heute noch keine
> MCP-Server im Setup. Die Skills definieren die Regeln trotzdem jetzt –
> wenn Connectors kommen, greifen die Agents sofort auf definierte Prozesse zurück.
>
> Zuletzt aktualisiert: SETUP

---

## BLOCK 1: INBOUND – Wie Informationen ins System kommen

### Skill 01: inbound-triage 🔴
**Ordner:** `skills/inbound-triage/`
**Genutzt von:** Donna (primär), Louis, Harold
**Zweck:** Master-Routing für ALLE eingehenden Informationen – egal welcher Kanal.

**Was definiert wird:**
- Entscheidungsbaum: Mail / Teams-Nachricht / WhatsApp / Dokument / Scan / Voice / Quick Capture / Claude-Chat → wohin?
- Prioritäts-Ableitung aus Inhalt: Welche Signalwörter = urgent? (Frist, Kündigung, sofort, dringend)
- Projekt-Erkennung: Wie wird aus Inhalt + Absender + Betreff der richtige Projekt-Slug abgeleitet?
- Duplikat-Erkennung: Wann ist eine Mail ein neuer Thread vs. Update zu bestehendem Task?
- Wegwerf-Erkennung: Newsletter, Notifications, Marketing — Regeln was sofort weg kann
- Attachment-Routing: PDF → Louis Pipeline? Bild → Ablage? ZIP → Frage an User?
- Kanal-spezifische Unterschiede: Mail ist ausführlicher, Teams-Nachrichten sind oft fragmentiert (3 Nachrichten = 1 Gedanke), WhatsApp ist informell
- Eskalationsregeln: Wann wird Donna's Triage zu einem [MED] oder [LOW] Item?

**Warum MVP:** Donna verarbeitet täglich 10–50 Items. Ohne klare Triage-Regeln ist jede Zuordnung ein Münzwurf.

---

### Skill 02: dokument-eingang 🔴
**Ordner:** `skills/dokument-eingang/`
**Genutzt von:** Donna (Erstverarbeitung), Louis (Tiefenverarbeitung)
**Zweck:** Wie eingehende Dokumente verarbeitet, benannt, abgelegt und als MD-Companion erschlossen werden.

**Was definiert wird:**
- Typ-Erkennung: Vertrag / Rechnung / Angebot / Beleg / Protokoll / Bericht / Präsentation / Sonstiges
- Benennungskonvention: `{typ}_{absender-slug}_{thema}_{datum}.{ext}` oder Varianten
- MD-Companion-Pflicht: Jedes Binärdokument bekommt eine MD-Datei als primäres Dokument
- MD-Companion-Struktur: Was muss drin stehen? (Volltext-Zusammenfassung? Nur Metadaten? Beides?)
- Ablageort-Entscheidung: `documents/vertraege/` vs. `documents/rechnungen/` vs. `projects/{slug}/docs/`
- Scan-Qualitäts-Check: Wann ist ein Scan zu schlecht für automatische Verarbeitung? → [LOW]
- Pipeline Donna → Louis: Wann übergibt Donna an Louis? (Vertragscharakter, Rechnungen >X€, etc.)
- Binärdatei vs. MD: Was ist die Source of Truth? (MD = Inhalt, Binär = Beleg/Original)
- Archivierungs-Trigger: Wann wandert ein verarbeitetes Dokument ins Archiv?

**Warum MVP:** Ohne klare Regeln landen Dokumente in falschen Ordnern, ohne MD-Companion, ohne Frontmatter. Louis und die Suche werden blind.

---

## BLOCK 2: OUTBOUND – Wie wir kommunizieren

### Skill 03: email-stil 🔴
**Ordner:** `skills/email-stil/` (existiert, wird vertieft)
**Genutzt von:** Donna (Drafts), Rachel (Statusberichte), Louis (Vertragskommunikation)
**Zweck:** Dein persönlicher E-Mail-Stil als verbindliche Vorlage für alle Agent-Drafts.

**Was definiert wird:**
- Signatur (DE + optional EN)
- Anrede-Regeln: Wann "Sehr geehrte/r", wann "Hallo", wann "Hi"? → Verknüpfung mit Persona (Du/Sie)
- Struktur: Begrüßung → Kontext (1 Satz) → Kern → Handlungsaufforderung → Gruß
- Maximale Länge: Wie lang dürfen Mails sein? (Richtwert pro Typ)
- Tonalität-Spektrum: formell ←→ locker (mit Beispielen für jeden Punkt)
- 3–5 Beispiel-Mails die deinen Stil repräsentieren (Referenz für Agents)
- Abweichungen: Wann weicht der Ton ab? (Eskalation, Erstansprache, Entschuldigung)
- Verbotene Formulierungen: Floskeln die du nie verwendest
- Anhang-Hinweise: Wie referenzierst du Anhänge? ("Anbei finden Sie..." vs. "Im Anhang: ...")
- Sprach-Switch: Wann schreibst du auf Englisch? Englischer Stil anders als deutsch?

**Warum MVP:** Donna erstellt täglich Drafts. Ohne Stil-Referenz klingt jeder Draft generisch.

---

### Skill 04: kanalregeln 🔴
**Ordner:** `skills/kanalregeln/` (existiert als communication-channels, wird umbenannt und vertieft)
**Genutzt von:** Donna, Rachel, Lipschitz (Kanal-Empfehlung)
**Zweck:** Regeln pro Kommunikationskanal — was ist angemessen, was nicht.

**Was definiert wird:**

| Dimension | Email | Teams | WhatsApp | Telefon | Slack* | Brief |
|-----------|-------|-------|----------|---------|--------|-------|
| Max Länge | 300 Wörter | 50 Wörter | 30 Wörter | n/a | 80 Wörter | 1 Seite |
| Formalität | mittel–hoch | niedrig–mittel | niedrig | mittel | niedrig | hoch |
| Anrede | Je Persona | Vorname | Vorname | Je Persona | Vorname | formell |
| Reaktionszeit erwartet | 24–48h | 2–4h | 1–2h | sofort | 4–8h | 5–10 Tage |
| Geeignet für | Alles Formelle | Schnelle Abstimmung | Informelles, Erinnerungen | Dringendes, Beziehungspflege | Team-Koordination | Rechtliches |
| Nicht geeignet für | Schnelle Rückfragen | Verträge, Formales | Verträge, lange Infos | Dokumentation | Externes | Zeitkritisches |

- Kanalwahl-Logik: Wann welcher Kanal? (Kombination aus Inhalt + Persona + Dringlichkeit)
- Persona-Überschreibung: Kontakt hat `preferred_channel: whatsapp` → gilt das immer oder nur für bestimmte Inhalte?
- Multi-Channel: Wann Mail + Teams-Ping? (z.B. dringende Mail + Teams: "Habe dir gerade was geschickt")
- **Zukünftige Connectors:** Teams MCP, WhatsApp Business API, Slack MCP — Skill ist vorbereitet, Donna nutzt Regeln sobald Connector steht

**Warum MVP:** Donna muss bei jedem Draft wissen welcher Kanal angemessen ist. Ohne Regeln kommt alles per Mail.

---

### Skill 05: follow-up-management 🟡
**Ordner:** `skills/follow-up-management/`
**Genutzt von:** Donna (Follow-Up-Tracking), Harvey (Tagesplan-Hinweise)
**Zweck:** Wann, wie oft und in welchem Ton wird nachgefasst.

**Was definiert wird:**
- Zeitliche Staffelung:
  - Tag 5 ohne Antwort: Freundliche Erinnerung
  - Tag 10 ohne Antwort: Konkrete Nachfrage mit Frist
  - Tag 15 ohne Antwort: Eskalation (anderer Kanal oder höhere Ebene)
  - Tag 20+: User entscheidet (Agent erstellt Eskalations-Task)
- Ton pro Stufe: Formulierungsbeispiele für jede Eskalationsstufe
- Kanal-Wechsel-Logik: Mail ohne Antwort → Teams-Ping? Telefon?
- Persona-Berücksichtigung: Manche Kontakte sind grundsätzlich langsam → längere Fristen
- Ausnahmen: Wann KEIN Follow-Up? (rein informative Mails, CC-Mails, Newsletter-Antworten)
- Follow-Up-Ketten: Wie verhindert man dass aus einer Erinnerung ein endloser Loop wird?
- Interne vs. externe Kontakte: Unterschiedliche Regeln?

**Warum Stufe 1:** Donna trackt Follow-Ups ab Tag 1, aber die Qualität der Erinnerungen wird erst mit diesem Skill gut.

---

### Skill 06: eskalation-kommunikation 🟡
**Ordner:** `skills/eskalation-kommunikation/`
**Genutzt von:** Donna (Drafts), Rachel (Meeting-Vorbereitung bei Problemen)
**Zweck:** Wie kommunizierst du wenn etwas schiefläuft — Verzögerungen, Fehler, Fristüberschreitungen.

**Was definiert wird:**
- Eskalationsstufen: Hinweis → Warnung → Dringende Eskalation → Formelle Mitteilung
- Struktur: Sachverhalt → Auswirkung → Ursache (wenn bekannt) → Maßnahme → nächster Schritt
- Tonalität: Sachlich, lösungsorientiert, nie defensiv, nie schuldzuweisend
- Proaktiv vs. Reaktiv: "Wir haben bemerkt, dass..." vs. "Auf Ihre Nachfrage..."
- Kanal-Wahl bei Eskalation: Wann reicht Mail? Wann muss telefoniert werden?
- Verknüpfung mit Persona: Manche Kontakte reagieren gut auf Direktheit, andere brauchen diplomatisches Framing
- Templates/Beispiele pro Stufe
- Interne Eskalation: An wen eskalierst du (Vorgesetzter, Kollege, Rechtsanwalt)?

---

### Skill 07: brief-formal 🟢
**Ordner:** `skills/brief-formal/`
**Genutzt von:** Louis (Kündigungen, Bestätigungen), Donna (formelle Korrespondenz)
**Zweck:** Formelle deutsche Geschäftsbriefe nach DIN 5008.

**Was definiert wird:**
- DIN-5008-Konformes Layout (Absender, Datum, Betreff, Anrede, Grußformel)
- Briefkopf-Vorlage mit CI (Verknüpfung mit presentation-ci)
- Typen: Kündigung / Bestätigung / Mahnung / Aufforderung / Stellungnahme
- Pro Typ: Struktur, Pflichtinhalte, rechtliche Formulierungen
- Fristen-Referenzen: Wie referenziert man Vertragsklauseln korrekt?
- Zustellungsnachweis: Wann Einschreiben? Wann reicht Email?
- Beispiel-Briefe pro Typ

**Warum Stufe 3:** Briefe sind selten, aber wenn sie nötig sind, müssen sie perfekt sein.

---

## BLOCK 3: DOKUMENT-LIFECYCLE – Verträge, Rechnungen, Ablage

### Skill 08: vertrag-analyse 🟡
**Ordner:** `skills/vertrag-analyse/`
**Genutzt von:** Louis (primär)
**Zweck:** Domänenwissen für Vertragsverarbeitung — was Louis extrahieren und prüfen muss.

**Was definiert wird:**
- Pflichtfelder-Extraktion: Vertragspartner, Laufzeit, Kündigungsfrist, auto_renewal, Preisanpassung, Gerichtsstand
- Risiko-Flags: Automatische Verlängerung ohne Preisdeckel? Lange Kündigungsfristen? Exklusivitätsklauseln?
- Fristen-Berechnung: Wann muss gehandelt werden? (cancellation_deadline = valid_until - Kündigungsfrist - Puffer)
- Puffer-Regeln: Standard 30 Tage, bei großen Verträgen 60 Tage, bei Mietverträgen 90 Tage
- Vertragstypen und Besonderheiten:
  - Softwarelizenzen (SaaS): Jährlich, oft auto-renewal, Preisanpassung nach Nutzeranzahl
  - Dienstleistungsverträge: SLA-Prüfung, Haftungsklauseln
  - Mietverträge: Index-Mietanpassung, Staffelmiete, Schönheitsreparaturen
  - Versicherungen: Deckungssummen, Selbstbeteiligung
  - Wartungsverträge: Reaktionszeiten, Leistungsumfang
- Hausverwaltungs-spezifisch: WEG-Verträge, Verwalterverträge, Energielieferverträge
- Vergleich bei Verlängerung: Marktpreis-Check empfehlen?
- UEBERSICHT.md-Format: Wie die Gesamt-Vertragsübersicht aussehen soll

---

### Skill 09: rechnung-verarbeitung 🟡
**Ordner:** `skills/rechnung-verarbeitung/`
**Genutzt von:** Louis
**Zweck:** Wie Rechnungen geprüft, erfasst und abgelegt werden.

**Was definiert wird:**
- Pflichtfelder-Extraktion: Rechnungsnummer, Datum, Betrag (netto/brutto), USt, Fälligkeit, Absender
- Formale Prüfung: Pflichtangaben nach §14 UStG vorhanden? (Steuernummer, fortlaufende Nr, etc.)
- Zuordnung: Projekt-Slug + Area aus Inhalt/Absender ableiten
- Dublettenprüfung: Gleiche Rechnungsnummer + Absender = Duplikat?
- Bezahl-Status: `status: open | paid | overdue | disputed`
- Fälligkeits-Tracking: Task anlegen wenn Fälligkeit naht? (Oder ist das im Buchhaltungssystem?)
- Abweichungs-Erkennung: Betrag deutlich höher als letzte Rechnung gleichen Absenders → Flag
- Kosten-Aggregation: Wie summiert Louis pro Projekt, pro Monat, pro Anbieter?
- Archivierung: Wann wandert eine bezahlte Rechnung ins Archiv?
- GoBD-Hinweis: Verweis auf IDEEN.md — aktuell kein konformes Archiv, aber Prozess dokumentiert

---

### Skill 10: dokument-ablage 🔴
**Ordner:** `skills/dokument-ablage/`
**Genutzt von:** Alle Agents die Dateien erstellen oder ablegen
**Zweck:** Verbindliche Regeln für Benennung, Ablage, Versionierung und Archivierung aller Dateien.

**Was definiert wird:**
- Dateinamen-Konvention: `YYYY-MM-DD_{slug}.md` für datierte Einträge, `{slug}.md` für Stammdaten
- Ordner-Routing: Welcher Dateityp gehört wohin? (Entscheidungsbaum)
- Versionierung: Wann neue Datei vs. bestehende aktualisieren?
- Frontmatter-Pflichtfelder pro Typ (Master-Referenz, ergänzt ARCHITECTURE.md)
- Archivierungsregeln: Wann gilt eine Datei als archivierbar? Wer entscheidet?
- Shared-Ordner-Regeln: Was darf in `projects/{slug}/shared/`? Was nie?
- Sensitivity-Routing: Wohin dürfen confidential/restricted Dateien?
- Verwaiste Dateien: Binär ohne MD = unsichtbar → Harold warnt
- Löschregeln: Was wird nie gelöscht? Was kann nach X Monaten weg?

**Warum MVP:** Jeder Agent erstellt Dateien. Ohne einheitliche Ablageregeln wird der Workspace chaotisch.

---

## BLOCK 4: PROJEKTMANAGEMENT – Wie Projekte laufen

### Skill 11: projekt-kickstart 🟡
**Ordner:** `skills/projekt-kickstart/`
**Genutzt von:** Mike (Projektanlage), Harvey (erste Planung)
**Zweck:** Standardprozess für neue Projekte — was braucht jedes Projekt zum Start?

**Was definiert wird:**
- Checkliste: README.md, Stakeholder, erste Tasks, Verträge zuordnen, Kontakte verknüpfen
- README-Struktur: Scope, Ziel, Timeline, Meilensteine, Ansprechpartner, Risiken
- Standard-Tasks pro Projekttyp (Kickstart-Templates):
  - Migration: Datenexport → Mapping → Testmigration → Produktivmigration → Nachbetreuung
  - Evaluation: Anforderungen → Recherche → Bewertung → Empfehlung → Entscheidung
  - Onboarding (Kunde): Vertrag → Setup → Schulung → Übergabe → Hypercare
- Lifecycle-Phase initial setzen: `initiation` + `lifecycle_since`
- Task-Abhängigkeiten: Welche Standard-blocked_by-Ketten?
- Stakeholder-Mapping: Wer muss informiert werden? Wer entscheidet?
- Projekt-Abgrenzung: Was gehört zum Projekt, was nicht? (Scope-Definition)
- Kommunikationsplan: Wer bekommt Updates, wie oft, über welchen Kanal?

---

### Skill 12: projekt-status 🟡
**Ordner:** `skills/projekt-status/`
**Genutzt von:** Rachel (Statusberichte), Jessica (Wochenberichte), Harvey (Tagesplan)
**Zweck:** Wie der Projekt-Status getrackt, bewertet und kommuniziert wird.

**Was definiert wird:**
- Status-Bewertung: Wann ist ein Projekt "On Track" / "Attention" / "At Risk"?
  - On Track: Alle Meilensteine im Plan, keine überfälligen Tasks, Budget OK
  - Attention: 1-2 überfällige Tasks ODER Meilenstein in Gefahr ODER Kommunikationslücke
  - At Risk: Meilenstein verpasst ODER blockierende Abhängigkeit ODER Eskalation nötig
- Lifecycle-Phase-Regeln: Wann wechselt ein Projekt die Phase? Wer entscheidet?
- Interne vs. externe Statussicht: Was sieht der Kunde vs. was bleibt intern?
- Status-Update-Frequenz: Wöchentlich? Bei Meilenstein-Änderung? Ad hoc?
- README.md-Pflege: Wann wird README aktualisiert? Bei jedem Statuswechsel?
- Blockade-Eskalation: Wie lange darf ein Projekt blockiert sein bevor eskaliert wird?
- Risiko-Tracking: Wie werden Risiken erfasst und nachverfolgt?

---

### Skill 13: uebergabe-dokument 🟢
**Ordner:** `skills/uebergabe-dokument/`
**Genutzt von:** Mike (Übergabe-Dokumente)
**Zweck:** Struktur und Qualitätsstandard für Projekt-Übergaben.

**Was definiert wird:**
- Gliederung: Projektübersicht → Stakeholder (mit Persona) → Status → Offene Tasks → Entscheidungslog → Verträge → Risiken → Empfehlungen
- Was MUSS rein: Alles was ein Nachfolger braucht um ab morgen weiterzuarbeiten
- Was NICHT rein darf: Interne Journal-Einträge, persönliche Notizen, Zeiterfassungs-Rohdaten
- Sensitivity: Immer `internal` (enthält Persona-Daten)
- Kontakt-Informationen: Persona-Kurzversion (Stil, Dos/Don'ts) — nicht die volle CRM-Datei
- Lessons Learned: Was hat funktioniert, was nicht?
- Offene Risiken explizit benennen mit Empfehlung

---

## BLOCK 5: TASK-MANAGEMENT – Wie Aufgaben fließen

### Skill 14: task-erstellung 🔴
**Ordner:** `skills/task-erstellung/`
**Genutzt von:** Donna (aus Mails), Harvey (aus Briefings), Rachel (aus Meetings), alle Agents
**Zweck:** Wie Tasks formuliert, priorisiert und strukturiert werden.

**Was definiert wird:**
- Titel-Konvention: Aktionsverb + Objekt + Kontext. "Antwort an [Client-Example] zu Testmigration" statt "Mail [Client-Example]"
- Beschreibung: Was genau ist zu tun? Kontext: Woher kommt der Task?
- Erledigungskriterien: Wann ist der Task "done"? Immer mindestens 1 Kriterium.
- Prioritäts-Ableitung:
  - urgent: Frist <48h ODER explizit als dringend markiert
  - high: Frist diese Woche ODER blockiert andere Tasks ODER Kunde wartet
  - medium: Standard, keine besondere Dringlichkeit
  - low: Nice-to-have, kein externer Druck
- Projekt-Zuordnung: Wie wird der richtige Projekt-Slug abgeleitet? (→ verknüpft mit inbound-triage)
- Granularität: Wann ist ein Task zu groß und sollte aufgesplittet werden? (Richtwert: >4h → aufteilen)
- Recurring Tasks: Format, Frequenz-Optionen, auto_create-Logik
- Follow-Up-Tasks: Wie werden Mail-Follow-Ups als Tasks formuliert?
- Source-Tracking: Woher kam der Task? (mail, meeting, quick-capture, okr, etc.)

**Warum MVP:** Donna erstellt täglich Tasks. Ohne klare Regeln sind Titel nichtssagend und Prioritäten willkürlich.

---

### Skill 15: tagesplanung 🔴
**Ordner:** `skills/tagesplanung/`
**Genutzt von:** Harvey (primär), Katrina (Tagesabschluss als Gegenstück)
**Zweck:** Wie ein guter Arbeitstag geplant wird — Priorisierung, Zeitbudget, Fokusblöcke.

**Was definiert wird:**
- Priorisierungslogik: Überfällig > heute fällig > blockiert andere > urgent > Woche > Backlog
- Zeitbudget-Berechnung: 8h Arbeitstag − Termine − Puffer (30min) = verfügbar
- Überbucht-Regeln: Ab wann warnt Harvey? Was empfiehlt er zu verschieben?
- Deep-Work-Blöcke: Wie werden konzentrationslastige Tasks geblockt? Minimum 90min?
- Meeting-Tage vs. Fokus-Tage: Unterschiedliche Planung je nach Kalender?
- Carry-Over: Wie geht Harvey mit Tasks um die gestern nicht geschafft wurden?
- Blocking-Visualisierung: Wie stellt Harvey Abhängigkeiten dar?
- Energie-Management: Schwere Tasks morgens? Administrative nachmittags? (aus PROFILE.md)
- Staging-Integration: "X Einträge warten" immer im Tagesplan sichtbar
- Minimal-Modus: An stressigen Tagen nur die Top 3 zeigen

---

## BLOCK 6: MEETING-MANAGEMENT – Vor, während, nach

### Skill 16: meeting-vorbereitung 🟡
**Ordner:** `skills/meeting-vorbereitung/`
**Genutzt von:** Rachel (primär)
**Zweck:** Wie Meetings vorbereitet werden — Agenda, Kontext, Kommunikationshinweise.

**Was definiert wird:**
- Agenda-Struktur: Check-In (5min) → Status (10min) → Themen (Hauptteil) → Action Items (5min) → Nächster Termin
- Kontext-Tiefe: Wieviel Historie braucht das Briefing? (Letzte 2-3 Meetings, nicht alle)
- Persona-Integration: Kommunikationshinweis immer dabei, aber kurz (2-3 Sätze, kein Aufsatz)
- Entscheidungsbedarf: Offene Entscheidungen explizit als Agenda-Punkt formulieren
- Dokumente vorab: Welche Dokumente sollten vor dem Meeting geteilt werden?
- Meeting-Typen und ihre Struktur:
  - Status-Meeting: Fokus auf Fortschritt + Blocker
  - Entscheidungs-Meeting: Optionen vorbereiten, Pro/Contra
  - Kickoff: Vorstellung, Scope, Rollen, Timeline
  - Eskalations-Meeting: Problem, Auswirkung, Lösungsoptionen
- Zeitschätzung: Wie viel Zeit pro Agenda-Punkt?
- Vorbereitung OHNE Kontakt-Eintrag: Was tun wenn kein Persona vorhanden? → Lipschitz anfordern

---

### Skill 17: meeting-protokoll 🟡
**Ordner:** `skills/meeting-protokoll/`
**Genutzt von:** Rachel (Nachbereitung), Donna (wenn aus Mail extrahiert)
**Zweck:** Wie Meeting-Ergebnisse dokumentiert werden.

**Was definiert wird:**
- Protokoll-Struktur:
  ```
  ## Teilnehmer
  ## Besprochene Themen
  ## Entscheidungen
  ## Action Items (Wer? Was? Bis wann?)
  ## Offene Fragen
  ## Nächster Termin
  ```
- Action-Item-Format: Immer mit Verantwortlichem + Frist → wird zu eigenem Task
- Entscheidungen: Immer als `notes/knowledge/decisions/` referenzierbar? Oder nur bei strategischen?
- Transkriptions-Integration: Wenn Meetily/Transkription da ist — wie wird aus Transkript ein Protokoll?
- Verteilung: Protokoll an Teilnehmer? Über welchen Kanal? Automatisch oder nach Review?
- Frontmatter: Pflichtfelder (participants, projects, date, type: meeting-note)
- Internes vs. Kunden-Protokoll: Was bleibt intern? (Persona-Hinweise, interne Strategie)
- Fotos/Screenshots: Whiteboard-Fotos → `inbox/documents/` → Referenz im Protokoll

---

### Skill 18: meeting-nachbereitung 🟡
**Ordner:** `skills/meeting-nachbereitung/`
**Genutzt von:** Rachel (primär), Donna (Follow-Ups), Katrina (Task-Status)
**Zweck:** Der komplette Post-Meeting-Prozess — vom Protokoll bis zum Follow-Up.

**Was definiert wird:**
- Sofort nach Meeting (innerhalb 1h):
  1. Protokoll finalisieren (Skill 17)
  2. Action Items → eigene Tasks mit `source: meeting` + `source_ref`
  3. Entscheidungen → `notes/knowledge/decisions/` wenn strategisch
  4. Kontakte updaten: `last_contact`, Kommunikationslog
  5. Persona updaten wenn neue Erkenntnisse (→ Lipschitz)
- Innerhalb 24h:
  6. Protokoll/Zusammenfassung an Teilnehmer (Kanal aus Persona)
  7. Projekt-README updaten wenn Status sich geändert hat
  8. Offene Fragen als Tasks formulieren
- Follow-Up-Tracking:
  9. Action Items mit Frist → Donna trackt als Follow-Up
  10. Nächster Termin im Kalender? → Falls nicht, Task erstellen

**Warum Stufe 1:** Meetings ohne Nachbereitung = verlorene Zeit. Dieser Skill schließt den Loop.

---

## BLOCK 7: CRM & BEZIEHUNGSMANAGEMENT

### Skill 19: kontakt-persona 🟡
**Ordner:** `skills/kontakt-persona/`
**Genutzt von:** Lipschitz (primär), Rachel (liest Persona), Donna (liest für Drafts)
**Zweck:** Wie Kontakt-Personas aufgebaut, gepflegt und genutzt werden.

**Was definiert wird:**
- Persona-Datenmodell: Was wird erfasst?
  - Kommunikationsstil: direkt / formal / casual / diplomatisch / analytisch
  - Anrede: Du / Sie / Wechsel je nach Kontext
  - Präferenzen: Was schätzt die Person? (Pünktlichkeit, Genauigkeit, kurze Wege?)
  - Trigger: Was nervt? (Unpünktlichkeit, lange Mails, fehlende Vorbereitung?)
  - Small Talk: Themen die funktionieren (Familie, Sport, Reisen, Technik?)
  - Bevorzugter Kanal + Reaktionsgeschwindigkeit
  - Entscheidungsstil: Schnell / braucht Bedenkzeit / braucht Daten?
- Beziehungs-Lifecycle: Erstgespräch → Aktiv → Ruhend → Reaktivierung
- Quellen: Woraus leitet Lipschitz die Persona ab? (Meetings, Mails, User-Input)
- Aktualisierung: Wann wird eine Persona refreshed? (Nach jedem Meeting? Monatlich?)
- Konfidenz: [HIGH] vollständig / [MED] Lücken / [LOW] Entwurf
- Datenschutz: Was darf NICHT in einer Persona stehen? (Art. 9 DSGVO, → PRIVACY.md)
- Nutzung durch andere Agents: Kurzformat für Rachel (3 Sätze), Draft-Regeln für Donna

---

## BLOCK 8: REPORTING & ANALYSE

### Skill 20: reporting 🟡
**Ordner:** `skills/reporting/`
**Genutzt von:** Jessica (Wochenberichte), Rachel (Kundenberichte), Mike (Analysen)
**Zweck:** Struktur und Qualitätsstandards für alle Arten von Berichten.

**Was definiert wird:**
- **Interner Wochenbericht** (Jessica):
  - Struktur: Highlights → Erledigte Tasks → Offene Risiken → OKR-Fortschritt → Zeiterfassung → Ausblick
  - Länge: 1-2 Seiten, keine Rohdaten
  - Tonalität: Analytisch, strategisch, vorausschauend
  - Empfänger: Nur du (später: Vorgesetzter)

- **Kunden-Statusbericht** (Rachel):
  - Struktur: Status-Ampel → Zuletzt erledigt → Nächste Meilensteine → Offene Punkte → Risiken
  - Was NICHT rein darf: Interne Slugs, Frontmatter, Zeiterfassung, Persona-Daten
  - Tonalität: Professionell, positiv aber ehrlich
  - Format: Reines Deutsch, kein Markdown-Syntax für Kunden

- **Querschnittsanalyse** (Mike):
  - Struktur: Scope → Findings → Anomalien → Empfehlungen
  - Immer mit Handlungsempfehlung — keine reinen Datentabellen
  - Anomalie-Bewertung: Was ist normal, was ist auffällig?

- **Monats-Retro** (Jessica):
  - Struktur: Was lief gut → Was lief schlecht → Was ändern → Metriken-Trend → Agent-Qualität
  - Ziel: Systemverbesserung, nicht Selbstkritik

- **CI-Grundlagen** (alle Berichte):
  - Farben, Logo, Schriften → Verweis auf presentation-ci
  - Wenn Export als PDF/HTML: CI anwenden

---

## BLOCK 9: PROZESS & WISSENSMANAGEMENT

### Skill 21: sop-erstellung 🟡
**Ordner:** `skills/sop-erstellung/`
**Genutzt von:** Mike (primär), Jessica (Retro-Kontext)
**Zweck:** Standard Operating Procedures dokumentieren UND Automatisierungskandidaten identifizieren.
**Herkunft:** Notion `/sop-plus-automation` Command → Workspace-Äquivalent

**Was definiert wird:**
- SOP-Template-Struktur:
  ```
  ## Prozessname
  ## Ziel / Warum existiert dieser Prozess?
  ## Trigger (wann startet der Prozess?)
  ## Schritte (nummeriert, mit Verantwortlichem)
  ## Inputs / Outputs
  ## Werkzeuge / Systeme
  ## Ausnahmen & Eskalation
  ## Automatisierungspotenzial
  ```
- Automatisierungs-Bewertung pro Schritt:
  - Manuell (nicht automatisierbar) / Teilautomatisiert (Agent unterstützt) / Vollautomatisiert (Agent autonom)
  - Score: Impact × Häufigkeit / Aufwand (analog zur Modul-1-Matrix)
- Ablage: `notes/knowledge/howto/{prozess-slug}.md`
- Verknüpfung: Wenn Automatisierung identifiziert → Task mit `source: sop`
- Review-Zyklus: SOPs alle 6 Monate durch Jessica prüfen lassen (veraltet?)
- Prozessaufnahme-Methodik: Wie wird ein Ist-Prozess aufgenommen? (Interview-Leitfaden, Beobachtung, Log-Analyse)

---

### Skill 22: cross-source-recherche 🟢
**Ordner:** `skills/cross-source-recherche/`
**Genutzt von:** Mike (primär), Donna (bei komplexen Anfragen)
**Zweck:** Strukturierte Recherche über mehrere Quellen hinweg — Workspace + MCP-Server.
**Herkunft:** Langdock semantische Suche über Slack + Drive + Mail + Calendar

**Was definiert wird:**
- Quellen-Hierarchie: Wo wird in welcher Reihenfolge gesucht?
  1. INDEX.md → Frontmatter-basierte Filterung (schnellste Quelle)
  2. Workspace grep → Volltextsuche in allen Markdown-Dateien
  3. M365 MCP → Mails + Kalender (wenn Workspace-Suche nicht reicht)
  4. Notion MCP → Nur in Übergangsphase (bis Notion abgeschaltet)
  5. Zukünftig: Teams, Slack, WhatsApp (wenn Connectors stehen)
- Ergebnis-Aggregation: Wie werden Treffer aus verschiedenen Quellen zusammengeführt?
  - Deduplizierung (gleiche Info aus Mail + Task → einmal zeigen)
  - Kontext-Anreicherung (Treffer + zugehöriges Projekt + Kontakt)
  - Konfidenz: [HIGH] exakter Treffer / [MED] verwandte Treffer / [LOW] heuristisch
- Suchmuster:
  - Personen-Suche: contacts/ → Mails → Meetings → Tasks
  - Themen-Suche: INDEX.md → Knowledge → Meetings → Mails
  - Projekt-Suche: projects/ → Tasks → Verträge → Kontakte → Mails
- Ausgabe: Immer mit Quelle + Datum + Kontext-Snippet — keine losen Treffer
- Zukunft: Semantische Suche über Embeddings (wenn Modelle günstiger werden)

---

### Skill 23: wissens-capture 🟡
**Ordner:** `skills/wissens-capture/`
**Genutzt von:** Donna (Brain Dumps, Claude-Chats), Mike (Analysen), alle Agents
**Zweck:** Wie Wissen aus verschiedenen Quellen extrahiert, klassifiziert und dauerhaft abgelegt wird.
**Herkunft:** Notion `/capture-idea` + `inbox/claude-chats/` Pipeline

**Was definiert wird:**
- Wissens-Typen und ihre Ablageorte:
  | Typ | Ablage | Frontmatter type |
  |-----|--------|-----------------|
  | How-To / Anleitung | notes/knowledge/howto/ | knowledge |
  | Entscheidung | notes/knowledge/decisions/ | decision |
  | Lesson Learned | notes/knowledge/learnings/ | learning |
  | Technische Doku | notes/knowledge/tech/ | knowledge |
  | Idee | notes/ideas/ | idea |
  | SOP / Prozess | notes/knowledge/howto/ | sop |
- Extraktions-Regeln: Wie wird aus einem Brain Dump / Claude-Chat strukturiertes Wissen?
  - Tasks extrahieren → tasks/ (mit source: claude-chat oder mobile)
  - Entscheidungen extrahieren → decisions/ (mit Kontext: Warum? Alternativen?)
  - Ideen extrahieren → ideas/ (mit Verknüpfung zu Projekt wenn erkennbar)
  - Fakten/Anleitungen → knowledge/ (mit topic: und tags:)
- Verknüpfungspflicht: Jedes Wissens-Item braucht mindestens `projects: []` oder `areas: []`
- Aktualitäts-Tracking: `last_validated:` Datum — Jessica prüft quartalsweise ob noch aktuell
- Claude-Chat-Pipeline: inbox/claude-chats/ → Donna liest → extrahiert → ablegt → archiviert Original

---

### Skill 24: correction-tracking 🟡
**Ordner:** `skills/correction-tracking/`
**Genutzt von:** Alle Agents (lesen), Jessica (analysieren), Harold (Health)
**Zweck:** Schließt die Rückkopplungsschleife. Jede User-Korrektur an einem
Agent-Output wird als Learning gespeichert und bei der nächsten ähnlichen
Ausführung als Kontext mitgegeben.
**Herkunft:** Systemisches Denken – Rückkopplungsschleifen

**Was definiert wird:**
- Correction-Format:
  ```yaml
  ---
  date: YYYY-MM-DD
  agent: donna
  type: correction  # correction | feedback | preference
  context: "Mail-Draft an [Client-Example]"
  original: "Kurze Zusammenfassung was der Agent produziert hat"
  correction: "Was der User geändert hat und warum"
  pattern: "Formeller Ton bei Erstanfragen"  # Abstrahiertes Learning
  applied_count: 0  # Wie oft wurde dieses Learning bereits angewandt
  ---
  ```
- Trigger: User sagt "Korrektur: [was falsch war]" ODER Agent erkennt Diskrepanz
  zwischen eigenem Output und User-Edit
- Ablageort: agents/{agent-name}/corrections/
- Lese-Regel: Vor jeder Ausführung liest der Agent seine letzten 10 Corrections
  und die 5 häufigsten Patterns (nach applied_count sortiert)
- Analyse: Jessica wertet corrections/ monatlich aus:
  → Wiederkehrende Patterns → Skill-Anpassung oder Prompt-Update vorschlagen
  → Rückläufige Corrections → Agent lernt, positive Rückmeldung im Report
  → Neue Correction-Typen → Ggf. neuer Skill nötig (→ Skill 25)
- Health-Integration: Harold zählt Corrections pro Agent pro Woche.
  Steigende Correction-Rate → Health Score sinkt → Alarm

---

### Skill 25: skill-vorschlag 🟡
**Ordner:** `skills/skill-vorschlag/`
**Genutzt von:** Alle Agents (erkennen), Harold (prüfen), Mike (ausarbeiten)
**Zweck:** Das System kann sich selbst erweitern. Wenn ein Agent wiederkehrende
Muster erkennt die kein existierender Skill abdeckt, erstellt er einen
Skill-Entwurf. Das Erstellen neuer Fähigkeiten ist selbst eine Fähigkeit.
**Herkunft:** Systemisches Denken – Emergenz

**Was definiert wird:**
- Erkennungs-Trigger: Agent stößt auf Situation wo er improvisiert und denkt
  "Das habe ich schon mehrfach ähnlich gemacht aber kein Skill beschreibt es"
- Schwelle: Mindestens 3 ähnliche Situationen bevor Vorschlag erstellt wird
  (verhindert Einmal-Vorschläge)
- Vorschlag-Format:
  ```yaml
  ---
  type: skill-vorschlag
  proposed_by: donna
  date: YYYY-MM-DD
  title: "kundentyp-erkennung"
  problem: "Keine Regel wie verschiedene Kundentypen unterschiedlich
  angesprochen werden (Bestandskunde vs. Interessent vs. Partner)"
  evidence:
    - "2026-03-01: Mail an Neukunde mit Bestandskunden-Ton beantwortet"
    - "2026-03-05: Angebot für Partner wie für Endkunden formuliert"
    - "2026-03-12: User korrigierte Anrede bei Erstanfrage"
  proposed_content: |
    Kundentyp aus Kontakt-Persona ableiten.
    Bestandskunde: persönlich, Referenz auf letzte Interaktion.
    Interessent: professionell, Mehrwert betonen.
    Partner: kollegial, auf Augenhöhe.
  affected_agents: [donna, rachel, lipschitz]
  affected_skills: [email-stil, kanalregeln, kontakt-persona]
  status: vorschlag  # vorschlag | approved | rejected | merged
  ---
  ```
- Ablageort: inbox/.staging/skills/
- Workflow:
  1. Agent erkennt Pattern → erstellt Vorschlag in inbox/.staging/skills/
  2. Harold meldet im Health Check: "N neue Skill-Vorschläge"
  3. User reviewt: "Staging zeigen" → sieht Vorschlag mit Evidence
  4. Bestätigt → Mike arbeitet Vorschlag zum vollständigen Skill aus
  5. Abgelehnt → Vorschlag archiviert mit Begründung
- Feedback-Loop: Wenn ein Skill-Vorschlag approved wird und als neuer Skill
  aktiv ist, trackt Jessica ob die Correction-Rate in dem Bereich sinkt.
  Falls ja → Emergenz bestätigt. Falls nein → Skill nachbessern.

---

## ÜBERSICHT: Skill-Map nach Agent

```
                    01  02  03  04  05  06  07  08  09  10  11  12  13  14  15  16  17  18  19  20  21  22  23
                    IN  DOK EML KAN FOL ESK BRF VER REC ABL KIC STA ÜBG TSK TAG MVB MPR MNB PER REP SOP XSR WIS
Donna              ██  ██  ██  ██  ██  ██  ░░  ░░  ░░  ██  ░░  ░░  ░░  ██  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ██
Harvey             ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ██  ░░  ██  ██  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░
Mike               ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ██  ██  ██  ██  ░░  ░░  ░░  ░░  ░░  ░░  ██  ██  ██  ░░
Louis              ░░  ██  ░░  ░░  ░░  ░░  ██  ██  ██  ██  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░
Rachel             ░░  ░░  ░░  ██  ░░  ██  ░░  ░░  ░░  ░░  ░░  ██  ░░  ░░  ░░  ██  ██  ██  ██  ██  ░░  ░░  ░░
Katrina            ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ██  ██  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░
Jessica            ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ██  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ██  ██  ░░  ██
Harold             ██  ██  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ██  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░
Lipschitz          ░░  ░░  ░░  ██  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ░░  ██  ░░  ░░  ░░  ░░

██ = nutzt diesen Skill aktiv    ░░ = nutzt diesen Skill nicht
```

---

## IMPLEMENTIERUNGS-EMPFEHLUNG

### Phase MVP (vor/mit Tag 5): 6 Skills
```
🔴 01 inbound-triage        → Donna braucht das ab dem ersten Mail-Run
🔴 02 dokument-eingang      → Jedes Dokument muss sauber ankommen
🔴 03 email-stil            → Donna erstellt ab Tag 1 Drafts
🔴 04 kanalregeln           → Kanalwahl bei jedem Draft
🔴 10 dokument-ablage       → Jeder Agent erstellt Dateien
🔴 14 task-erstellung       → Donna erstellt ab Tag 1 Tasks
```

### Phase Stufe 1 (Woche 2–3): +9 Skills
```
🟡 05 follow-up-management  → Donna Follow-Up-Tracking wird aktiv
🟡 06 eskalation-komm.      → Erste Probleme tauchen auf
🟡 08 vertrag-analyse       → Louis wird aktiv
🟡 09 rechnung-verarbeitung → Louis wird aktiv
🟡 15 tagesplanung          → Harvey wird täglich genutzt, Feintuning
🟡 16 meeting-vorbereitung  → Rachel wird aktiv
🟡 17 meeting-protokoll     → Meetings werden dokumentiert
🟡 19 kontakt-persona       → Lipschitz Kickstart
🟡 23 wissens-capture       → Donna verarbeitet Brain Dumps + Claude-Chats
```

### Phase Stufe 2 (Woche 4–6): +5 Skills
```
🟡 11 projekt-kickstart     → Neue Projekte standardisiert anlegen
🟡 12 projekt-status        → Jessica Wochenberichte brauchen Status-Regeln
🟡 18 meeting-nachbereitung → Meeting-Loop schließen
🟡 20 reporting             → Jessica + Rachel Berichte
🟡 21 sop-erstellung        → Mike kann Prozesse dokumentieren + Automation-Kandidaten identifizieren
```

### Phase Stufe 3+ (Monat 3): +3 Skills
```
🟢 07 brief-formal          → Wenn Louis Verträge kündigt
🟢 13 uebergabe-dokument    → Wenn Projekte abgeschlossen werden
🟢 22 cross-source-recherche → Aggregierte Suche über alle MCP-Quellen
```

---

## ZUKÜNFTIGE CONNECTORS (kein Skill, aber beeinflusst Skills 04, 05, 06)

### Teams MCP
- Liest/schreibt Teams-Nachrichten + Kanäle
- Beeinflusst: kanalregeln (Skill 04), follow-up-management (Skill 05)
- Donna kann Teams-Nachrichten wie Mails verarbeiten
- Azure AD Permissions erweitern: `Chat.ReadWrite`, `ChannelMessage.Read.All`

### WhatsApp Business API
- Liest/schreibt WhatsApp Business Nachrichten
- Beeinflusst: kanalregeln (Skill 04), follow-up-management (Skill 05)
- Donna verarbeitet WhatsApp wie einen weiteren Inbound-Kanal
- Setup: WhatsApp Business Account + API + Webhook → MCP Server wrappen
- Datenschutz: WhatsApp-Nachrichten enthalten oft persönliches → Sensitivity beachten

### Slack MCP
- Für Teams/Kunden die Slack nutzen (nicht eigener primärer Kanal)
- Beeinflusst: kanalregeln (Skill 04)
- Niedrigere Priorität — nur wenn konkrete Kunden Slack nutzen

### Reihenfolge (Empfehlung):
1. Teams MCP (Q3 2026) — bereits in M365 Ökosystem, Permissions einfach
2. WhatsApp (Q4 2026) — höherer Setup-Aufwand, aber hoher Kommunikationswert
3. Slack (on demand) — nur wenn Bedarf entsteht
