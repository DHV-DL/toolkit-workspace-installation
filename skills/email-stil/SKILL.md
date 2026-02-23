# Skill: email-stil
**Version:** 1.0 | **Stand:** 2026-02-23 | **Genutzt von:** Donna, Rachel, Louis

---

## ZWECK
Definiert Daniels persönlichen E-Mail-Stil als verbindliche Vorlage für alle Agent-Drafts.
Jeder Draft der von einem Agent erstellt wird, muss diesem Skill entsprechen.

---

## SIGNATUR

### Textversion (für Agents)
```
Mit freundlichen Grüßen,

[Your Name]
[Your Role]

M [Your Phone]
[your.email@company.de]

[Your Company GmbH]
[Company Street & Number]
[Postal Code City]
[yourcompany.com]

[Local Court & Registration Number]
Geschäftsführung: [CEO], [CRO], [COO], [CSO]
```

### Bildkomponenten (vorhanden in `documents/signatures/`)
| Datei | Inhalt | Platzierung |
|-------|--------|-------------|
| `linkedin-badge.png` | LinkedIn-Profilbadge | Nach Namen/Titel |
| `[company]-banner.png` | [YourCo] Firmenbanner | Nach LinkedIn |
| `[company]-logo.png` | [YourCo] Unternehmenslogo | Vor Handelsregisterdaten |
| `outlook-booking-btn.png` | "Termin buchen" Button | Abschluss, Link: [Calendar Booking Link] |

> Hinweis: Bilder werden nur in HTML-Mail-Clients gerendert.
> Für Agents gilt die Textversion als Pflicht. Bilder sind supplementär.

---

## ANREDE-REGELN

### Standard: Du
**Für fast alle Kontakte.** [YourCo] hat eine Du-Kultur – sowohl intern als auch bei den
Hausverwaltungs-Töchtern (kd-* Projekte). Du ist der Defaultwert.

```
Hallo [Vorname],
Hi [Vorname],        ← bei bekannten Kontakten
```

### Ausnahmen: Sie
Nur wenn explizit bekannt oder im Kontaktprofil vermerkt (`salutation: Sie`).
Unbekannte externe Kontakte (kein Eintrag in contacts/) → zunächst Sie, dann lernen.

```
Sehr geehrte/r Frau/Herr [Nachname],   ← Erstansprache extern ohne Kontakteintrag
Guten Tag Frau/Herr [Nachname],        ← nach einem Austausch, noch unbekannt
```

### Rückschluss aus Kontext
- Hat die Person in ihrer Mail geduzt → Du zurück
- Langfristiger Kontakt ohne Hinweis → immer Du (Erfahrungswert)
- Erster Kontakt ohne Kontakteintrag → Sie, bis geklärt

---

## STIL & TONALITÄT

### Grundregel: Kurz & direkt
- **Länge:** 80–150 Wörter im Regelfall
- **Max:** 250 Wörter (nur bei komplexen Sachverhalten)
- **Kein:** Smalltalk-Opener, kein ausschweifendes Intro
- Kommt direkt zum Punkt: Kontext (1 Satz) → Kern → Handlungsaufforderung

### Struktur
```
[Begrüßung]

[Kontext in 1 Satz, falls nötig]

[Kern / Was ich brauche oder mitteile]

[Nächster Schritt / Bitte / Frage]

[Gruß]
[Signatur]
```

### Tonalität-Spektrum
| Situation | Ton | Beispiel-Anrede |
|-----------|-----|-----------------|
| Interne Kollegen | locker, direkt | "Hi [CEO]," |
| Kunden-Töchter (bekannt) | freundlich-professionell | "Hi [Vorname]," |
| Erstansprache extern | professionell | "Guten Tag Frau/Herr X," |
| Eskalation | sachlich, klar | "Hallo [Vorname]," + neutral |
| Formell/Rechtlich | förmlich | "Sehr geehrte/r ..." |

---

## VERBOTENE FORMULIERUNGEN

Diese Floskeln kommen in keinem Draft vor:

| Verboten | Warum |
|----------|-------|
| "Ich hoffe, diese E-Mail findet Sie gut" / "Ich hoffe, dir geht es gut" | Generisch, klingt nach Vorlage |
| "Wie besprochen, ..." | Klingt passive-aggressive |
| "Bitte zögern Sie nicht, mich zu kontaktieren" | Calque aus dem Englischen |
| "Hochachtungsvoll" | Zu formell, altmodisch |
| "Im Anhang finden Sie ..." | → stattdessen: "Anbei: [Was]" oder "Ich habe [X] angehängt." |
| "Für Rückfragen stehe ich jederzeit zur Verfügung" | Standardfloskel, immer weglassen |

---

## GRUSSFORMEL

Standard: **"Mit freundlichen Grüßen,"**

Varianten je nach Kontext:
- `"Viele Grüße,"` – bei bekannten Kontakten, locker
- `"Beste Grüße,"` – neutrale Alternative zu "Viele Grüße"
- `"Mit freundlichen Grüßen,"` – immer korrekt, auch formal

Nie: "Hochachtungsvoll", "Freundliche Grüße" (ohne Adjektiv-Steigerung – klingt abgehackt)

---

## ANHÄNGE

- Verweis: `"Anbei: [Dateiname / Beschreibung]"` ganz am Anfang der Mail
- Nie am Ende verstecken
- Bei mehreren Anhängen: kurze Liste

---

## SPRACH-SWITCH

Englisch nur wenn:
- Empfänger hat auf Englisch geschrieben
- Kontakt hat `language: en` im Profil
- Thema erfordert es (z.B. Software-Docs)

Englischer Stil: gleiche Kürze, "Kind regards," statt "Best regards,"

---

## BEISPIEL-MAILS

### Beispiel 1: Rückfrage an Kunden-Tochter
```
Hi Anna,

ich wollte kurz nachhaken wegen der offenen Freigabe für den temporal-project-01.
Bis wann können wir damit rechnen?

Viele Grüße,
Daniel
```

### Beispiel 2: Erstansprache externer Dienstleister
```
Guten Tag Herr Müller,

ich melde mich bezüglich Ihrer Anfrage zur IT-Infrastruktur.
Könnten Sie mir bitte bis Freitag ein Angebot zukommen lassen?

Mit freundlichen Grüßen,
[Your Name]
[Signatur]
```

### Beispiel 3: Interne Kurzmitteilung
```
Hi [CEO],

kurze Info: der temporal-project-01 bei [Client-Example] verschiebt sich auf Q2.
Ich halte dich auf dem Laufenden.

VG
Daniel
```
