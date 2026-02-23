# Skill: inbound-triage
**Version:** 1.0 | **Stand:** 2026-02-23 | **Genutzt von:** Donna (primär), Louis, Harold

---

## ZWECK
Master-Routing für ALLE eingehenden Informationen. Definiert wie Donna jede Mail,
jeden Inbound-Kanal-Eingang und jede Quick-Capture zuordnet.

---

## PRIORITÄTS-ENTSCHEIDUNG

### Stufe: URGENT – sofortige Reaktion (<2h)

Alle drei Kriterien können independent urgent auslösen:

1. **Kündigung / Rechtliches**
   - Signal-Wörter: "kündigung", "kündigen", "rechtsanwalt", "abmahnung", "fristlos",
     "klage", "einstweilige verfügung", "mahnbescheid", "gerichtsstand"
   - Anhang: Dokument von Rechtsanwalt, Kanzlei, Gericht
   - Absender-Domain-Muster: @ra-*, @kanzlei-*, @rechtsanwaelte-*

2. **Frist / Deadline heute oder morgen**
   - Signal-Wörter: "bis heute", "bis morgen", "bis [Datum nahe Zukunft]", "deadline",
     "Frist läuft ab", "letzter Tag", "spätestens"
   - Datumscheck: Erwähnte Fristen mit aktuellem Datum vergleichen

3. **Direkte GF-Anfrage**
   - Absender: [CEO], [CRO], [COO], [CSO]
     (E-Mail: @[company.de] – [ceo-email], [cro-email], [coo-email], [cso-email])
   - Auch: wenn GF in CC und explizite Anfrage an Daniel

### Stufe: HIGH – gleicher Tag

- Kunden-Töchter mit konkreter Anfrage (nicht nur Info)
- Tasks mit `priority: high` in Betreff-Schlüsselwörtern: "Angebot", "Entscheidung", "freigabe"
- Follow-Up-Thread wo Daniel letzter Empfänger war (>5 Tage offen)
- [ERP Vendor]-Kollegen (Slack-äquivalent via Mail): [Vendor Contact A], [Vendor Contact B]

### Stufe: MEDIUM – diese Woche

- Standard-Anfragen von bekannten Kontakten
- Protokolle, Berichte, Statusmeldungen
- Neue Kontakte ohne Dringlichkeit

### Stufe: LOW → Staging / ignorieren

- Newsletter, Marketing-Mails
- Automatische Notifications (JIRA, GitHub, Systemmails)
- CC-Mails ohne explizite Handlungsaufforderung an Daniel
- Leere Sende-Bestätigungen

---

## PROJEKT-ERKENNUNG

### Über Absender-Domain
| Domain / Muster | Projekt-Slug |
|-----------------|-------------|
| @[company.de] | intern (int-*) |
| @[client-01.de] / [Client-01] | kd-[Client-01] |
| @[client-02.de] / [Client-02] / [Client-02] | kd-client-02 |
| [Client-03 Group] / @[client-03.de] | kd-client-03 |
| @[client-04.de] / [Client-04] | kd-client-04 |
| @[client-05.de] / [Client-05] | kd-[Client-05] |
| @[client-06.de] / [Client-06] | kd-[Client-06] |
| [Client-07] | kd-client-07 |
| [Client-08] | kd-client-08 |
| [Client-09] | kd-[Client-09] |
| [Client-10] | kd-[Client-10] |
| [Client-11] | kd-[Client-11] |
| [Client-12] | kd-[Client-12] |
| [Client-13] | kd-[Client-13] |
| [Client-14] | kd-[Client-14] |
| [Client-15] | kd-[Client-15] |
| [Client-16] | kd-[Client-16] |
| [Client-17] | kd-[Client-17] |
| [Client-18] | kd-client-18 |
| [Client-19] | kd-[Client-19] |
| [Client-20] | kd-[Client-20] |
| @[ERP Vendor].io / @[ERP Vendor].de | temporal-project-01 |
| [ERP System] / [Legacy System] / ERP-Themen | temporal-project-02 |

### Über Betreff-Schlüsselwörter
- "OKR", "Quartalsziele", "KPI", "Bericht" → int-strategie oder int-investoren
- "Rechnung", "Mahnung", "Zahlung" → int-finance + Projekt wenn erkennbar
- "HR", "Stelle", "Bewerbung", "Mitarbeiter" → int-hr
- "Datenschutz", "DSGVO", "Einwilligung" → int-datenschutz
- "IT", "Server", "Software", "Lizenz" → int-it-infra

### Fallback
- Domain unbekannt, kein Betreff-Treffer → [MED] → Staging mit Vorschlag
- User entscheidet über Projektzuordnung

---

## DUPLIKAT-ERKENNUNG

Eine Mail ist ein Update zu bestehendem Task wenn:
- Betreff mit "AW:", "RE:", "Fwd:" beginnt AND Originalbetreff im System bekannt
- Gleicher Thread-Index (message-id chain)
→ In diesem Fall: Existierenden Task updaten, nicht neuen Task erstellen

Neue Mail wenn:
- Gleicher Absender + neues Thema → neuer Task / neues Item

---

## ATTACHMENT-ROUTING

| Attachment-Typ | Aktion |
|---------------|--------|
| PDF – Vertrag/Rechnung (erkennbar an Inhalt/Dateiname) | → Louis Pipeline |
| PDF – Protokoll / Bericht | → notes/meetings/ anlegen |
| PDF – Allgemein | → documents/ ablegen, MD-Companion erstellen |
| XLSX / CSV – Daten | → documents/ + Mike wenn Analyse nötig |
| DOCX / Word | → documents/ + MD-Companion |
| Bild/Foto | → documents/ (kein MD-Companion nötig) |
| ZIP / Archiv | → [LOW] → User fragen was damit zu tun ist |
| Scan schlecht lesbar | → [LOW] → User informieren, nicht verarbeiten |

---

## WEGWERF-ERKENNUNG (automatisch ignorieren)

Folgende Muster = sofort ignorieren (kein Task, kein Staging):
- Absender enthält: "noreply", "no-reply", "newsletter", "marketing", "notification"
- Betreff enthält: "Unsubscribe", "Bestätigung Ihrer Anmeldung", "Your receipt"
- Automatische System-Mails: JIRA, GitHub Actions, Monitoring-Alerts (wenn nicht explizit abonniert)
- Leere Mails (kein Body) = Sendebestätigung / Outlook-Artefakt

---

## ESKALATIONS-REGELN

Donna eskaliert zu [MED] (Staging) wenn:
- Konfidenz bei Projektzuordnung < 70%
- Unbekannter Absender + geschäftlicher Inhalt
- Sensitivity-Indikator im Inhalt (persönliche Daten, Gehaltsinfos, Vertragsdetails)
- Anhang mit "Kündigung", "Vertrag", "Anwalt" aber [MED] Konfidenz

Donna eskaliert zu [LOW] (fragen) wenn:
- Völlig unbekannter Kontext
- Attachment ZIP/Archiv
- Scan unlesbar
