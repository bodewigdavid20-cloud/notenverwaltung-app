# 🚀 GitHub Upload - Die RICHTIGE Reihenfolge

## ⚠️ Wichtig: Workflows werden erst nach Upload erkannt!

---

## 📋 Methode 1: Via GitHub Web (Empfohlen vom Handy)

### Schritt 1: Repository erstellen
1. Gehe zu: https://github.com/new
2. Repository name: `notenverwaltung-app`
3. ✅ Public
4. ❌ **NICHTS ANDERES anklicken!**
5. **"Create repository"** klicken

### Schritt 2: Komplettes Projekt hochladen

**WICHTIG: Du musst die ZIP richtig hochladen!**

#### Option A: Entpacken und einzeln hochladen (Am sichersten)

1. **Entpacke notenverwaltung_app.zip auf deinem Gerät**
2. In GitHub klicke: **"uploading an existing file"**
3. **Ziehe ALLE entpackten Dateien** in das Upload-Feld
   - ALLE .md Dateien
   - ALLE Ordner (lib, android, ios, .github!)
   - pubspec.yaml
   - build_mobile.sh
   - ALLES!
4. **Wichtig:** Der `.github` Ordner MUSS mit dabei sein!
5. Warte bis Upload fertig
6. Commit message: "Initial commit"
7. **"Commit changes"** klicken

#### Option B: Via Git Clone (Vom PC, sicherer)

```bash
# 1. Repository klonen
git clone https://github.com/DEIN_USERNAME/notenverwaltung-app.git
cd notenverwaltung-app

# 2. Alle Dateien hineinkopieren
# Kopiere ALLE Dateien aus notenverwaltung_app/ hierher
# Inklusive .github Ordner!

# 3. Hochladen
git add .
git commit -m "Initial commit with GitHub Actions"
git push
```

### Schritt 3: Workflows aktivieren

1. **Gehe zu deinem Repository**
2. **Klicke oben auf "Actions"**
3. Du solltest jetzt sehen:
   - **"Build Android APK"**
   - **"Create Release"**
4. Falls eine Nachricht erscheint: **"I understand my workflows, go ahead and enable them"** → Klicken!

### Schritt 4: Build starten

1. **Links** auf "Build Android APK" klicken
2. **Rechts** auf "Run workflow" Dropdown
3. **Grüner Button** "Run workflow" klicken
4. ⏳ Warte 8-10 Minuten
5. Seite aktualisieren bis ✅ grün erscheint

### Schritt 5: APK downloaden

1. Auf den **grünen Build** klicken
2. **Nach unten scrollen** zu "Artifacts"
3. Download **app-arm64-v8a-release**
4. ZIP entpacken → APK installieren

---

## 🐛 Troubleshooting

### "Actions" Tab ist leer oder zeigt keine Workflows

**Ursache:** `.github/workflows/` Ordner wurde nicht hochgeladen

**Lösung:**
1. Prüfe ob `.github` Ordner im Repository ist
2. Prüfe ob darin `workflows/` Ordner ist
3. Prüfe ob `build-apk.yml` und `release.yml` darin sind

**So prüfen:**
- Gehe zu Repository
- Klicke durch die Ordner: `.github` → `workflows`
- Solltest `build-apk.yml` und `release.yml` sehen

### .github Ordner ist nicht sichtbar

**Versteckte Ordner auf Windows:**
1. Ordner öffnen
2. Ansicht → Optionen
3. Ansicht Tab
4. ✅ "Ausgeblendete Dateien anzeigen"

**Versteckte Ordner auf Mac:**
- `Cmd + Shift + .` drücken

### Workflows erscheinen erst nach Stunden

**Lösung:** 
1. Mache eine kleine Änderung (z.B. README.md bearbeiten)
2. Committe die Änderung
3. GitHub erkennt dann die Workflows

---

## ✅ Checkliste: Was muss hochgeladen sein?

```
✅ .github/
   ✅ workflows/
      ✅ build-apk.yml
      ✅ release.yml
✅ .gitignore
✅ android/ (Ordner)
✅ ios/ (Ordner)
✅ lib/ (Ordner)
✅ pubspec.yaml
✅ README.md
✅ Alle anderen .md Dateien
```

**Wenn .github fehlt = Keine Workflows!**

---

## 🎯 Einfachste Methode (100% sicher)

### Via GitHub Desktop (PC/Mac)

1. **Download GitHub Desktop:** https://desktop.github.com
2. **Installieren und anmelden**
3. **"Add Local Repository"**
4. **Wähle den entpackten notenverwaltung_app Ordner**
5. **"Publish repository"**
6. Fertig! Workflows sind automatisch dabei!

---

## 📱 Alternative: Via GitHub Mobile App

1. **GitHub App installieren:**
   - Android: https://play.google.com/store/apps/details?id=com.github.android
   - iOS: https://apps.apple.com/app/github/id1477376905

2. **In der App:**
   - Neues Repository erstellen
   - Dateien können direkt hochgeladen werden
   - Workflows werden automatisch erkannt

---

## 🎬 Video-Anleitung Alternative

Falls du es visuell bevorzugst:
1. YouTube: Suche "GitHub Actions Flutter APK"
2. Folge einem Tutorial
3. Nutze unsere Workflow-Dateien statt der aus dem Video

---

## 💡 Schnellster Weg zum Erfolg

**Option 1: PC/Laptop verfügbar?**
→ Nutze GitHub Desktop (5 Minuten, 100% sicher)

**Option 2: Nur Handy?**
→ Entpacke ZIP komplett, lade ALLE Dateien einzeln hoch (10 Minuten)

**Option 3: Command Line?**
→ Git clone + copy + push (3 Minuten für Profis)

---

## 🔄 Wenn immer noch keine Workflows:

### Manuelle Datei-Erstellung in GitHub:

1. **Im Repository, klicke "Add file" → "Create new file"**

2. **Dateiname:** `.github/workflows/build-apk.yml`
   (Ordner werden automatisch erstellt!)

3. **Inhalt kopieren aus:** `notenverwaltung_app/.github/workflows/build-apk.yml`

4. **"Commit new file"**

5. **Wiederhole für:** `.github/workflows/release.yml`

6. **Actions Tab aktualisieren** → Workflows sollten erscheinen!

---

## 🆘 Immer noch Probleme?

**Schicke mir einen Screenshot von:**
1. Deiner Repository-Hauptseite
2. Dem Actions-Tab
3. Der Ordnerstruktur

Dann kann ich dir genau sagen, was fehlt!

---

## ✅ Wenn alles funktioniert:

Du siehst im Actions Tab:
- ✅ Build Android APK
- ✅ Create Release

Dann kannst du loslegen mit dem Build! 🚀
