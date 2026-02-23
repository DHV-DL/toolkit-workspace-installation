# PRIVACY.md – Datenschutz-Selbstdokumentation

> Zweck: Persönliche Dokumentation für eigene Nachvollziehbarkeit und
> rechtliche Absicherung. Kein offizielles Datenschutzdokument für Dritte.
> Zuletzt aktualisiert: SETUP

---

## Was verarbeitet dieses System

### Interne Daten
- Eigene Projektnotizen, Tasks, Entscheidungen
- Interne Meeting-Notes und Action Items
- Unternehmensstrategische Dokumente (COMPANY.md)
- Eigenes Profil und Arbeitsstil (PROFILE.md)

### Externe Kontaktdaten
- Namen, E-Mail-Adressen, Telefonnummern von Geschäftskontakten
- Kommunikationsstil-Profile (CRM-äquivalent zu Salesforce, HubSpot etc.)
- Kommunikationshistorie (Datum + Kanal + Zusammenfassung)
- ⚠️ KEINE: Gesundheitsdaten, politische/religiöse Überzeugungen,
  besondere Kategorien gem. Art. 9 DSGVO

### Mail- und Kalenderdaten
- Eigenes M365 Postfach (nur Mails an/von mir)
- Eigener Kalender (Termine + Teilnehmer)
- Mail-Inhalte werden via Donna an Anthropic API gesendet zur Verarbeitung

---

## Welche Daten berühren Anthropic-Server

Bei jedem Agent-Run der via `claude -p` läuft:

| Was wird gesendet | Wann | Zweck |
|-------------------|------|-------|
| Mail-Inhalte + Absender | Donna (täglich) | Kategorisierung, Draft-Erstellung |
| Task-Inhalte | Harvey, Katrina | Priorisierung, Zeiterfassung |
| Meeting-Notes | Rachel | Vorbereitung |
| Kontakt-Persona (name, stil) | Rachel, Lipschitz | Kommunikationshinweise |
| Vertragsauszüge | Louis | Fristen-Extraktion |

Was NICHT an Anthropic gesendet wird:
- Binärdateien (PDFs, Dokumente) – nur Markdown-Inhalt
- PROFILE.md Inhalt wird nur lokal referenziert wenn harvey liest
- sensitivity: restricted Dateien → kein Agent-Zugriff

---

## Rechtliche Basis

- **AVV mit Anthropic:** ✅ Vorhanden seit [DATUM EINSETZEN]
- **Rechtsgrundlage Kontakt-Profile:** Art. 6 Abs. 1 lit. f DSGVO
  (berechtigtes Interesse: interne Arbeitsorganisation, Kundenpflege)
- **Vergleichbarer Standard:** Jedes professionelle CRM-System
  (Salesforce, HubSpot, Pipedrive) tut dasselbe
- **Einschränkung:** Keine besonderen Kategorien (Art. 9 DSGVO)

---

## Zugriffsschutz

| Schutzmaßnahme | Status |
|----------------|--------|
| Google Drive: 2-Faktor-Authentifizierung | ✅ Aktiv |
| Google Drive: kein unkontrolliertes Sharing | ✅ Aktiv |
| Claude Code: API-Key via Account (kein lokaler Key) | ✅ |
| Anthropic API: Kein Training by default (API-Key) | ✅ |
| sensitivity-Labels: organisatorischer Schutz | ✅ (kein technischer Encrypt) |
| ai_processing: false Opt-Out für Kontakte | ✅ verfügbar |

---

## Opt-Out für Kontakte

Wenn eine Person nicht via KI-API verarbeitet werden soll:

```yaml
# contacts/{slug}.md Frontmatter
ai_processing: false
```

Alle Agents prüfen dieses Flag und überspringen die Person bei API-Calls.
Die Datei selbst bleibt im Workspace, nur die KI-Verarbeitung wird deaktiviert.

---

## Was dieses System NICHT verarbeitet

- Gesundheits- oder medizinische Daten
- Politische, religiöse oder weltanschauliche Überzeugungen
- Gewerkschaftszugehörigkeit
- Genetische oder biometrische Daten
- Strafrechtliche Verurteilungen
- Alles was als "besondere Kategorie" gem. Art. 9 DSGVO gilt

---

## Wenn jemand fragt: "Was speicherst du über mich?"

Antwort-Checkliste:
1. Öffne `contacts/{slug}.md` → zeigt alle gespeicherten Felder
2. Durchsuche `notes/meetings/` nach Erwähnungen → alle Meeting-Notes
3. Durchsuche `tasks/` nach `contacts: [{slug}]` → alle zugeordneten Tasks
4. Kommunikationslog in der Kontakt-Datei → alle protokollierten Interaktionen

Löschung auf Anfrage:
→ `ai_processing: false` setzen (sofort) + Kontakt-Datei löschen + Snap
→ Git-History enthält noch die Datei → bei vollständiger Löschung: `git filter-branch`
