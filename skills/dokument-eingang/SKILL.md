# Skill: dokument-eingang
**Version:** 1.0 | **Stand:** 2026-02-23 | **Genutzt von:** Donna (Erstverarbeitung), Louis (Tiefenverarbeitung)

---

## ZWECK
Definiert wie eingehende Dokumente verarbeitet, benannt, abgelegt und als MD-Companion erschlossen werden.
Ohne diesen Skill landen Dokumente in falschen Ordnern, ohne Frontmatter, und sind für Suche/Louis unsichtbar.

---

## TYP-ERKENNUNG

| Typ | Erkennungs-Merkmale | Ziel |
|-----|-------------------|------|
| **Vertrag** | "Vertrag", "Vereinbarung", "§§", "Kündigungsfrist", "Laufzeit", Unterschriften-Block | Louis-Pipeline |
| **Rechnung** | "Rechnung Nr.", "Invoice", Betrag + MwSt, Bankdaten | Louis-Pipeline |
| **Angebot** | "Angebot", "Kostenvoranschlag", "Quote", kein Unterschriften-Block | Projekt-Docs |
| **Protokoll / Meeting-Note** | "Protokoll", "Meeting", Datum + Teilnehmerliste, Action Items | notes/meetings/ |
| **Bericht / Report** | "Bericht", "Report", Zeitraum-Angabe, keine Unterschriften | Projekt-Docs oder notes/ |
| **Präsentation** | .pptx, "Präsentation", Slide-Struktur | Projekt-Docs |
| **Behördenpost** | Absender: Behörde, Gericht, Finanzamt | documents/nachweise/ |
| **Nachweis / Zertifikat** | Zertifikat, Bescheinigung, Nachweis | documents/nachweise/ |
| **Scan (allgemein)** | handschriftlich, schlecht strukturiert | documents/sonstiges/ |

---

## BENENNUNGSKONVENTION

**Schema:** `YYYY-MM-DD_{absender-slug}_{thema-kurz}.{ext}`

Beispiele:
```
2026-02-15_aareon_wartungsvertrag-[ERP Vendor].pdf
2026-01-31_aareon_rechnung-q4-2025.pdf
2026-02-20_[Client-Example]_onboarding-angebot.pdf
2026-02-10_ra-mueller_kuendigung-aufforderung.pdf
```

Regeln:
- Datum: immer aus Dokumentinhalt, nicht aus Eingangsdatum (Ausnahme: kein Datum im Dokument)
- Absender-Slug: lowercase, kebab-case, aus Absendername ableiten
- Thema: max 3-4 Wörter, beschreibend, keine Nummern
- Umlaute ersetzen: ä→ae, ö→oe, ü→ue, ß→ss

---

## MD-COMPANION PFLICHT

Jedes Binärdokument (PDF, DOCX, XLSX) bekommt eine MD-Begleitdatei.

**Dateiname:** wie Originaldokument, aber `.md` Endung
```
2026-02-15_aareon_wartungsvertrag-[ERP Vendor].pdf
2026-02-15_aareon_wartungsvertrag-[ERP Vendor].md   ← MD-Companion
```

**MD-Companion Mindeststruktur:**
```yaml
---
title: "[Dokumenttitel]"
type: [contract|invoice|offer|protocol|report|other]
date: YYYY-MM-DD
created: YYYY-MM-DD
sender: vorname-nachname      # Kontakt-Slug wenn vorhanden
projects:
  - projekt-slug
sensitivity: internal         # internal | confidential | restricted
---

## Zusammenfassung
[1-3 Sätze: Was ist das Dokument, worum geht es?]

## Wichtige Felder
- [Schlüsselinfos je nach Typ: Vertragsdauer, Betrag, etc.]

## Original-Datei
`./[dateiname].pdf`
```

**Source of Truth:** MD = Inhalt und Metadaten. Binär = Original/Beleg.

---

## ROUTING: DONNA → LOUIS

Louis bekommt das Dokument wenn:
- Typ = Vertrag (erkennbar an Merkmalen oben)
- Typ = Rechnung
- Typ = Angebot (wenn Freigabe nötig)
- Absender ist Rechtsanwalt / Kanzlei
- Dokument enthält Unterschriften-Block (= rechtlich bindend)

Donna legt die Datei ab + erstellt MD-Companion + erstellt Task für Louis:
```
title: "Vertrag prüfen – [Absender] [Thema]"
priority: high
projects: [zugehöriger-slug]
```

Direktablage ohne Louis (keine weitere Prüfung nötig):
- Protokolle
- Berichte ohne rechtliche Relevanz
- Präsentationen
- Nachweise/Zertifikate ohne Vertragsbezug

---

## SCAN-QUALITÄT

Wenn Scan schlecht lesbar (pixelig, gedreht, zu dunkel):
- [LOW] → User informieren: "Scan von [Absender] vom [Datum] ist schwer lesbar. Bitte erneut scannen."
- Datei trotzdem ablegen (mit Qualitäts-Flag in MD-Companion)
- Kein MD-Companion mit falschen Daten erstellen

---

## ARCHIVIERUNG

Wann wandert ein verarbeitetes Dokument ins Archiv:
- Vertrag: nach Ablauf + 10 Jahre (GoBD)
- Rechnung: nach Bezahlung + 10 Jahre (GoBD)
- Protokoll: nach 2 Jahren ohne Referenz
- Sonstiges: nach 1 Jahr ohne Referenz

Archivierungsentscheidung: immer User bestätigen (Staging).
