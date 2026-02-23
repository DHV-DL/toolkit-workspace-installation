# Skill: dokument-ablage
**Version:** 1.0 | **Stand:** 2026-02-23 | **Genutzt von:** Alle Agents die Dateien erstellen

---

## ZWECK
Verbindliche Regeln für Benennung, Ablage, Versionierung und Archivierung aller Dateien.
Jeder Agent erstellt Dateien – ohne einheitliche Regeln wird der Workspace chaotisch.

---

## DATEINAMEN-KONVENTION

### Datierte Einträge (Ereignis- oder Zeitbezug)
```
YYYY-MM-DD_{slug}.md
```
Beispiele:
- `2026-02-15_[Client-Example]-erstgespraech.md` (Meeting-Note)
- `2026-02-20_aareon-rechnung-q1.md` (Rechnungs-Companion)

### Stammdaten (kein spezifisches Datum)
```
{slug}.md
```
Beispiele:
- `thomas-klews.md` (Kontakt)
- `temporal-project-01.md` (Projekt-README)
- `django-rest-framework.md` (Knowledge)

### Aufzählungen / Versionen
- Keine Versions-Suffixe wie `_v2`, `_final`, `_neu`
- Stattdessen: Git-History zeigt Änderungshistorie
- Ausnahme: Dokumente die als separate Versionen erhalten bleiben müssen:
  `YYYY-MM-DD_{slug}_v{n}.pdf` (Originaldokumente, nie MD-Dateien)

### Allgemeine Regeln
- Nur lowercase
- Worttrennung: Bindestrich `-` (kein Underscore außer Datum-Trenner)
- Keine Umlaute: ä→ae, ö→oe, ü→ue, ß→ss
- Keine Sonderzeichen außer `-` und `_`
- Maximale Länge: 60 Zeichen (ohne Endung)

---

## ORDNER-ROUTING

```
Welcher Dateityp gehört wohin?
─────────────────────────────────────────────────────────

tasks/                     ← Alle Task-Dateien (task.md Template)
  ├─ {slug}.md

contacts/                  ← Alle Kontakt-Dateien (contact.md Template)
  ├─ {vorname-nachname}.md

notes/
  ├─ meetings/             ← Meeting-Protokolle (type: meeting-note)
  │   └─ YYYY-MM-DD_{slug}.md
  ├─ knowledge/
  │   ├─ tech/             ← Technische Doku, Frameworks, Konzepte
  │   ├─ howto/            ← Wiederkehrende Prozesse, SOPs
  │   ├─ decisions/        ← Strategische Entscheidungen (Warum?)
  │   └─ learnings/        ← Postmortems, Projekt-Learnings
  └─ ideas/                ← Ideen ohne festen Projektstatus

projects/{slug}/
  ├─ README.md             ← Projekt-Stammdaten
  ├─ docs/                 ← Projektspezifische Artefakte, Pläne, Reviews
  └─ shared/               ← Für Kunden/externe sichtbar (sensitivity: public)

documents/
  ├─ vertraege/            ← Verträge (Louis-Pipeline)
  ├─ rechnungen/           ← Rechnungen (Louis-Pipeline)
  ├─ finanzen/             ← Finanzberichte, Budgets
  ├─ nachweise/            ← Behördenpost, Zertifikate
  ├─ signatures/           ← Signatur-Bilder
  └─ sonstiges/            ← Alles was nicht zuordenbar ist

goals/                     ← OKRs
inbox/
  ├─ .staging/             ← Approval Queue
  └─ quick-capture/        ← "!" Eingaben
```

---

## FRONTMATTER-PFLICHTFELDER

Je nach Datei-Typ unterschiedliche Pflichtfelder:

### Task
```yaml
---
title: str
status: open|in_progress|done
priority: urgent|high|medium|low
created: YYYY-MM-DD
projects: [slug]
---
```

### Kontakt
```yaml
---
name: "Vorname Nachname"
email: str
company: str
projects: [slug]
created: YYYY-MM-DD
---
```

### Meeting-Note
```yaml
---
title: str
type: meeting-note
date: YYYY-MM-DD
participants: [vorname-nachname]
projects: [slug]
---
```

### Knowledge
```yaml
---
title: str
type: knowledge|decision|learning
date: YYYY-MM-DD
areas: [area]
projects: [slug]      # wenn projektspezifisch
---
```

---

## SENSITIVITY-ROUTING

| Sensitivity | Erlaubte Ordner | NICHT erlaubt |
|------------|----------------|---------------|
| public | projects/{slug}/shared/ | – |
| internal | Überall im Workspace | Shared-Ordner |
| restricted | tasks/, notes/, projects/{slug}/ | contacts/ (kein Massen-Zugriff) |
| confidential | Nur projects/{slug}/ | Überall sonst |

Confidential-Projekte: kd-vertraege, int-investoren, prv-finances, prv-health
Restricted-Projekte: int-strategie, int-m-a, int-hr

---

## NEUE DATEI vs. UPDATE

**Neue Datei erstellen wenn:**
- Anderes Datum (Meeting gestern vs. heute)
- Anderes Projekt
- Strukturell anderer Typ (neuer Vertrag ≠ Update altem Vertrag)

**Bestehende Datei updaten wenn:**
- Gleicher Stammdaten-Eintrag (Kontakt, Projekt-README)
- Frontmatter-Update (Status, Priorität)
- Ergänzung bestehenden Protokolls am gleichen Tag

**Nie ohne Staging überschreiben:**
- Dateien mit sensitivity: confidential
- Projekt-READMEs (Staging-Vorschlag, User bestätigt)
- Kontakte (außer Frontmatter-Updates)

---

## VERWAISTE DATEIEN

Binärdokument ohne MD-Companion = **unsichtbar für das System**.
Harold warnt wöchentlich über verwaiste Binärdateien in documents/.

MD-Datei ohne zugehörige Binärdatei = OK (Beschreibung des nicht-mehr-vorhandenen Originals).

---

## LÖSCHREGELN

**Niemals löschen (ohne User-Bestätigung):**
- Verträge und Rechnungen (10 Jahre GoBD-Pflicht)
- Projekt-READMEs aktiver Projekte
- Alle Dateien mit sensitivity: confidential

**Nach Ablauf archivierbar (Staging, User bestätigt):**
- Meeting-Notes >2 Jahre ohne Referenz
- Tasks mit status: done >1 Jahr
- Knowledge-Einträge ohne Aktualisierung >2 Jahre
