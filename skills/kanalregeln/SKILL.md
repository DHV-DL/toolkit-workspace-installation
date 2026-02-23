# Skill: kanalregeln
**Version:** 1.0 | **Stand:** 2026-02-23 | **Genutzt von:** Donna, Rachel, Lipschitz

---

## ZWECK
Regeln pro Kommunikationskanal – welcher Kanal wann, wie lang, wie formal.
Donna nutzt diesen Skill bei jedem Draft um den richtigen Kanal zu wählen.

---

## KANAL-ÜBERSICHT

| Dimension | Email | Teams | WhatsApp | Telefon | Slack |
|-----------|-------|-------|----------|---------|-------|
| **Primär für** | Alles Formelle, Dokumentation | Interne Abstimmung | Informelles, kurze Rückfragen | Dringendes, Sensitives | [ERP Vendor]-Kommunikation |
| **Max. Länge** | 250 Wörter | 50 Wörter | 2-3 Sätze | unbegrenzt | 80 Wörter |
| **Formalität** | mittel–hoch | niedrig–mittel | niedrig | mittel | niedrig–mittel |
| **Anrede** | Hallo / Sehr geehrte/r | Vorname | Vorname | je Persona | Vorname |
| **Reaktionszeit** | 24–48h erwartet | 2–4h | 1–2h | sofort | 4–8h |
| **Geeignet für** | Verträge, Angebote, Protokolle, Entscheidungen | Schnelle Abstimmung intern | Erinnerungen, kurze Infos | Eskalation, Beziehungspflege | [ERP Vendor]: Tickets, Updates, Rückfragen |
| **Nicht für** | Schnelle Rückfragen, Brainstorming | Verträge, externe Empfänger | Vertrauliches, Dokumente | Dokumentation | Externe (nur [ERP Vendor]-intern) |

---

## KANAL-DETAILS

### 📧 E-Mail (primär)
**Wann:** Standard für alle nicht-zeitkritischen Themen. Immer wenn Dokumentation wichtig ist.
- Kunden-Töchter: Email als Hauptkanal
- Externe Dienstleister: Email als Hauptkanal
- Behörden/Recht: nur Email (dokumentiert)
- Angebote, Verträge, Rechnungen: immer Email
- Protokolle, Beschlüsse: immer Email

**Besonderheit:** Email ist die verbindliche Kommunikationsform. Telefon/Teams-Abstimmungen
sollten in Email-Zusammenfassung münden wenn Entscheidungen getroffen wurden.

---

### 💬 Microsoft Teams
**Wann:** Interne schnelle Abstimmung innerhalb [YourCo].
- [CEO], [CRO], [COO], [CSO] → Teams OK für Internes
- Kollegen [YourCo] Holding → Teams
- NICHT für externe Kunden-Töchter (haben eigene Systeme)
- NICHT für [ERP Vendor] (Slack verwenden!)

**Format:** kurz, informell, kein langer Fließtext. Bei >50 Wörtern → Email bevorzugen.

---

### 📱 WhatsApp
**Wann:** Nur wenn Kontakt diesen Kanal aktiv nutzt und Thema informell ist.
- Nur bei Kontakten mit `preferred_channel: whatsapp` oder bekanntem WhatsApp-Austausch
- Erinnerungen zu laufenden Themen ("Hast du kurz Zeit für ein Gespräch?")
- Terminabstimmung wenn Telefon bevorzugt wird
- NICHT für Verträge, Dokumente, vertrauliche Informationen
- NICHT bei unbekannten Kontakten

---

### 📞 Telefon
**Wann:**
- Dringende Abstimmung (<2h Reaktionszeit benötigt)
- Sensitive Themen (personalrechtlich, Eskalation, Konflikt)
- Komplexe Themen die viel Hin-und-her erfordern
- Wenn Email-Thread zu lang wird und direkte Klärung effizienter ist

**Nach Telefonat:** Entscheidungen und Ergebnisse per Email zusammenfassen + versenden.

---

### 💼 Slack ([ERP Vendor])
**Wann:** Ausschließlich für die Kommunikation mit [ERP Vendor] GmbH.
- Projekt: temporal-project-01, temporal-project-02, temporal-project-03
- [ERP Vendor]-Kontakte: [Vendor Contact A], [Vendor Contact B], sonstige [ERP Vendor]-Mitarbeiter
- Tickets, Supportanfragen, Projektabstimmungen im [ERP Vendor]-Kontext
- Status-Updates zum Rollout

**Format:** informell-professionell, direkt. Slack-typische Kürze ist OK.
Keine Formalität nötig, aber klar und handlungsorientiert.

**NICHT auf Slack:**
- Formelle Entscheidungen (Email!)
- Vertragsthemen (Email!)
- Interne [YourCo] Themen ohne [ERP Vendor]-Bezug

> Hinweis: Slack MCP noch nicht eingerichtet. Bis zum Connector: Slack-Inhalte
> über Teams-Tab oder direkte App. Skill ist vorbereitet sobald Connector steht.

---

## KANALWAHL-ENTSCHEIDUNGSBAUM

```
Eingehende/ausgehende Kommunikation
│
├─ [ERP Vendor]-Kontakt?
│   └─ JA → Slack (außer bei Formalem → Email)
│
├─ Intern [YourCo]?
│   └─ JA → Teams (kurz) oder Email (dokumentationspflichtig)
│
├─ Extern / Kunden-Tochter?
│   ├─ Zeitkritisch (<2h)? → Telefon
│   ├─ Informell + WhatsApp-Kontakt? → WhatsApp
│   └─ Standard → Email
│
└─ Unbekannter Absender → Email
```

---

## MULTI-CHANNEL-REGELN

**Dringende Mail + Teams-Ping:** OK wenn Empfänger intern und Mail >24h unbeantwortet.
Format: "Habe dir gerade eine Mail geschickt zu [Thema]."

**WhatsApp-Erinnerung zu Email:** OK bei bekannten Kontakten wenn >2 Tage keine Antwort.

**Telefon + Email-Nachfass:** Standard. Nach jedem wichtigen Telefonat Email-Summary.

---

## PERSONA-ÜBERSCHREIBUNG

Wenn `preferred_channel` im Kontaktprofil gesetzt ist, gilt dieser Kanal für informelle Kontakte.
Ausnahmen:
- Vertragsrelevantes → immer Email, unabhängig von preferred_channel
- Sensitivity: confidential → Telefon, nie WhatsApp/Slack

---

## ZUKÜNFTIGE CONNECTORS

| Connector | Status | Timeline | Auswirkung |
|-----------|--------|----------|------------|
| Slack MCP | ausstehend | Q3 2026 | Donna liest [ERP Vendor]-Slack wie Email |
| Teams MCP | ausstehend | nach M365 Admin-Consent | Donna liest interne Teams-Nachrichten |
| WhatsApp Business API | ausstehend | Q4 2026 | Donna verarbeitet WhatsApp-Inbound |
