# Skill: task-erstellung
**Version:** 1.0 | **Stand:** 2026-02-23 | **Genutzt von:** Donna, Harvey, Rachel, alle Agents

---

## ZWECK
Definiert wie Tasks formuliert, priorisiert und strukturiert werden.
Ohne diesen Skill sind Titel nichtssagend und Prioritäten willkürlich.

---

## TITEL-FORMAT

**Schema: Aktionsverb + Objekt + Kontext**

```
[Was tun] [Was / Wen] [Wo / Für was]
```

### Beispiele

| Falsch ❌ | Richtig ✅ |
|----------|----------|
| "Mail [Client-Example]" | "Antworten auf Anfrage – [Client-Example] temporal-project-01" |
| "Angebot prüfen" | "Angebot prüfen und freigeben – [Client-05] Software-Lizenz" |
| "Thomas anrufen" | "Anrufen – [Vendor Contact A] wegen temporal-project-03 Update" |
| "Rechnung" | "Rechnung prüfen und bezahlen – [ERP System] Q1 2026" |
| "OKR" | "OKR-Status aktualisieren – jessica weekly" |

### Aktionsverben (Standard-Vokabular)
- **Antworten** – auf eingehende Mails, Anfragen
- **Prüfen / Freigeben** – Dokumente, Angebote, Rechnungen
- **Erstellen / Schreiben** – neue Dokumente, Mails, Protokolle
- **Nachfassen** – bei ausbleibenden Antworten
- **Besprechen / Klären** – für Telefonat oder Meeting
- **Übermitteln / Weiterleiten** – Dokumente, Infos
- **Aktualisieren** – bestehende Daten, Status, Dateien
- **Einrichten / Konfigurieren** – technische Setups
- **Analysieren / Bewerten** – Recherche, Entscheidungsvorbereitung

---

## PRIORITÄTS-ABLEITUNG

### urgent (Reaktion <48h)
- Explizite Frist ≤ heute oder morgen
- Kündigung, rechtliche Frist, Abmahnung
- Direkte GF-Anfrage ([CEO], [CRO], [COO], [CSO])
- Blockiert kritisches anderes Projekt ohne Alternative

### high (diese Woche)
- Frist innerhalb der nächsten 5 Werktage
- Blockiert andere wichtige Tasks
- Kunde wartet auf Antwort
- Meilenstein-kritisch für aktives Projekt

### medium (Standard)
- Kein externer Druck
- Keine unmittelbare Konsequenz wenn 1-2 Wochen später
- Routinearbeiten

### low
- Nice-to-have, kein externer Druck
- "Irgendwann mal" Items
- Ideas ohne festen Termin

---

## PFLICHTFELDER PRO TASK

```yaml
---
title: "[Aktionsverb] [Objekt] – [Kontext]"
status: open
priority: medium          # urgent | high | medium | low
due_date: YYYY-MM-DD      # wenn bekannt, sonst weglassen
projects:
  - slug                  # mindestens 1 Projekt-Slug
created: YYYY-MM-DD
source: [mail|meeting|quick-capture|okr|manual]
---
```

Optionale aber nützliche Felder:
```yaml
contacts:                 # beteiligte Personen
  - vorname-nachname
blocked_by:               # Task-Abhängigkeiten
  - anderer-task-dateiname
source_ref: "Message-ID oder Meeting-Datum"
```

---

## GRANULARITÄT

**Richtwert: Tasks > 4h → aufteilen**

```
Zu groß ❌: "temporal-project-01 bei [Client-Example] vorbereiten" (>20h)
Richtig ✅:
  - "Anforderungen aufnehmen – [Client-Example] temporal-project-01"
  - "Testmigration durchführen – [Client-Example] temporal-project-01"
  - "Schulung planen – [Client-Example] temporal-project-01"
```

Ausnahmen: Research-Tasks dürfen größer sein wenn kein klares Ende absehbar.
Dann Folgentask: "Ergebnis dokumentieren – [Thema]"

---

## RECURRING TASKS

Format:
```yaml
recur: weekly     # daily | weekly | monthly | quarterly
recur_day: monday # bei weekly: Wochentag; bei monthly: Tag als Zahl
```

Beispiele:
- Harvey-Tagesplan → kein expliziter Task (läuft automatisch)
- Jessica Wochenbericht → `recur: friday`
- OKR-Review → `recur: quarterly`

---

## SOURCE-TRACKING

| source | Wann | Beispiel source_ref |
|--------|------|-------------------|
| mail | Aus eingehender Mail | Message-ID oder "Mail von Name, YYYY-MM-DD" |
| meeting | Aus Meeting-Protokoll | "Meeting mit X, YYYY-MM-DD" |
| quick-capture | Aus "! Text" Eingabe | Dateiname in inbox/quick-capture/ |
| okr | Aus OKR Key Result | KR-Nummer, z.B. "O1-K3" |
| manual | Manuell angelegt | (kein source_ref nötig) |
| backfill | Mail-Backfill Step 7b | Message-ID der ursprünglichen Mail |

---

## FOLLOW-UP-TASKS

Wenn Daniel auf eine Mail nicht geantwortet hat und Antwort erwartet wird:

```yaml
title: "Nachfassen – [Originalbetreff / Kontakt]"
priority: high    # wenn >7 Tage
source: mail
source_ref: "[Message-ID oder Datum der letzten Mail]"
follow_up_since: YYYY-MM-DD
```

Donna erstellt Follow-Up-Tasks automatisch nach dem inbound-triage-Prozess.
