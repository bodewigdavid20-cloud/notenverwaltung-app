# 🚀 GitHub Actions - Automatischer APK Build

## Schritt-für-Schritt Anleitung

Mit GitHub Actions baut GitHub **automatisch** deine APK in der Cloud - **kostenlos**! Du musst Flutter NICHT auf deinem Handy oder PC installieren.

---

## 📋 Voraussetzungen

- ✅ GitHub Account (kostenlos auf https://github.com)
- ✅ Internetverbindung
- ✅ Das war's! 🎉

---

## 🎯 Schritt 1: GitHub Account erstellen

1. Gehe zu **https://github.com**
2. Klicke auf **"Sign up"**
3. Erstelle Account mit E-Mail, Passwort, Username
4. E-Mail bestätigen

---

## 📤 Schritt 2: Repository erstellen

### Option A: Via GitHub Website (Einfachste Methode)

1. **Neues Repository erstellen:**
   - Gehe zu https://github.com/new
   - Repository name: `notenverwaltung-app`
   - Description: `Professionelle Notenverwaltung mit Beamer-Funktion`
   - ✅ Public (oder Private, beides funktioniert)
   - ❌ KEIN "Add README" (wir haben schon eines)
   - Klicke **"Create repository"**

2. **Code hochladen:**
   
   **Via Upload (am einfachsten vom Handy):**
   - Klicke auf **"uploading an existing file"**
   - Packe alle Dateien aus dem `notenverwaltung_app` Ordner in eine ZIP-Datei
   - Ziehe die ZIP auf die Upload-Seite
   - Warte bis Upload fertig
   - Klicke **"Commit changes"**

   **Via GitHub Desktop (empfohlen vom PC):**
   - Downloade GitHub Desktop: https://desktop.github.com
   - "File" → "Add local repository"
   - Wähle `notenverwaltung_app` Ordner
   - "Publish repository"

   **Via Git (für Entwickler):**
   ```bash
   cd notenverwaltung_app
   git init
   git add .
   git commit -m "Initial commit"
   git branch -M main
   git remote add origin https://github.com/DEIN_USERNAME/notenverwaltung-app.git
   git push -u origin main
   ```

---

## 🔨 Schritt 3: APK automatisch bauen lassen

**Die APK wird automatisch gebaut, wenn du Code hochlädst!**

### Manuellen Build starten:

1. Gehe zu deinem Repository auf GitHub
2. Klicke auf **"Actions"** (oben im Menü)
3. Links auf **"Build Android APK"**
4. Rechts auf **"Run workflow"**
5. Klicke grünen **"Run workflow"** Button
6. Warte 5-10 Minuten ⏳

### Build-Status prüfen:

- 🟡 **Gelb/Orange** = Build läuft
- ✅ **Grün** = Build erfolgreich
- ❌ **Rot** = Fehler (selten)

---

## 📥 Schritt 4: APK herunterladen

### Nach erfolgreichem Build:

1. **Gehe zu "Actions"**
2. **Klicke auf den neuesten grünen Build**
3. **Scrolle nach unten zu "Artifacts"**
4. **Download die gewünschte APK:**
   - `app-arm64-v8a-release` ← **Empfohlen** (moderne Handys)
   - `app-armeabi-v7a-release` (ältere Geräte)
   - `app-x86_64-release` (Emulatoren)

### APK entpacken:
- Die heruntergeladene Datei ist eine ZIP
- Entpacken → APK-Datei darin
- Diese APK auf dein Handy kopieren

---

## 🎉 Schritt 5: Release erstellen (Optional, aber cool!)

**Erstelle einen Download-Link für andere!**

### Via GitHub Website:

1. **Gehe zu deinem Repository**
2. **Klicke rechts auf "Releases"**
3. **"Create a new release"**
4. **Tag:** `v1.0.0`
5. **Title:** `Notenverwaltung v1.0.0`
6. **Klicke "Publish release"**

**GitHub baut automatisch die APK und hängt sie an den Release an!**

### Oder: Manueller Release-Workflow

1. **Gehe zu "Actions"**
2. **"Create Release" Workflow**
3. **"Run workflow"**
4. **Version eingeben:** z.B. `v1.0.0`
5. **"Run workflow"**

Nach 5-10 Minuten findest du unter "Releases" alle APKs zum Download!

---

## 📱 Workflow-Übersicht

### Zwei Workflows sind eingerichtet:

#### 1. **Build Android APK** (`build-apk.yml`)
- ✅ Läuft bei jedem Push/Commit
- ✅ Läuft manuell über "Actions"
- 📦 Erstellt APKs als Artifacts
- ⏱️ Dauer: ~5-10 Minuten

#### 2. **Create Release** (`release.yml`)
- 🎉 Erstellt öffentlichen Release
- 📥 APKs direkt downloadbar
- 🏷️ Wird bei Git Tags ausgelöst
- ⏱️ Dauer: ~5-10 Minuten

---

## 🔧 Workflows anpassen

### Build-Häufigkeit ändern

Bearbeite `.github/workflows/build-apk.yml`:

```yaml
# Nur bei manueller Ausführung:
on:
  workflow_dispatch:

# Bei jedem Push:
on:
  push:

# Bei bestimmten Branches:
on:
  push:
    branches: [ main ]
```

### Flutter-Version ändern

In beiden Workflow-Dateien:

```yaml
- name: 🐦 Setup Flutter
  uses: subosito/flutter-action@v2
  with:
    flutter-version: '3.19.0'  # Hier Version ändern
```

---

## 💡 Tipps & Tricks

### 1. **Build-Zeit verkürzen**
- Erste Build dauert 8-10 Minuten
- Weitere Builds nur 5-7 Minuten (Cache!)

### 2. **Private Repository**
- Funktioniert auch mit privaten Repos
- Nur du kannst die Artifacts sehen
- Für öffentliche APKs: Public Repo + Releases

### 3. **Mehrere Versionen**
- Erstelle Tags für verschiedene Versionen
- `v1.0.0`, `v1.1.0`, `v2.0.0`
- Jeder Tag = eigener Release

### 4. **APK automatisch per E-Mail**
Füge in `build-apk.yml` hinzu:
```yaml
- name: Send email
  uses: dawidd6/action-send-mail@v3
  with:
    server_address: smtp.gmail.com
    server_port: 465
    username: ${{secrets.EMAIL_USERNAME}}
    password: ${{secrets.EMAIL_PASSWORD}}
    subject: APK Build fertig!
    to: deine@email.com
    from: GitHub Actions
    attachments: build/app/outputs/flutter-apk/*.apk
```

---

## 🐛 Troubleshooting

### Problem: "No Flutter SDK found"
**Lösung:** Warte 1-2 Minuten, GitHub lädt Flutter herunter

### Problem: "Build failed"
**Lösung:** 
1. Prüfe "Actions" Log
2. Häufigster Fehler: Fehlende Dateien
3. Stelle sicher, ALLE Dateien sind hochgeladen

### Problem: "Artifacts not found"
**Lösung:**
- Warte bis Build ✅ grün ist
- Scrolle in der Build-Ansicht nach unten
- Artifacts erscheinen erst nach erfolgreichem Build

### Problem: "Download ZIP ist leer"
**Lösung:**
- GitHub packt APK nochmal in ZIP
- ZIP entpacken → APK ist darin

---

## 📊 Build-Status Badge (Optional)

Füge in `README.md` hinzu:

```markdown
![Build Status](https://github.com/DEIN_USERNAME/notenverwaltung-app/workflows/Build%20Android%20APK/badge.svg)
```

Zeigt grünen Badge wenn Build erfolgreich! ✅

---

## 🎯 Zusammenfassung

1. ✅ GitHub Account erstellen
2. ✅ Repository erstellen
3. ✅ Code hochladen
4. ✅ Zu "Actions" gehen
5. ✅ "Build Android APK" → "Run workflow"
6. ✅ Warten (5-10 Min)
7. ✅ Artifacts herunterladen
8. ✅ APK auf Handy installieren

**Fertig! Keine lokale Installation nötig! 🎉**

---

## 📞 Weitere Hilfe

**GitHub Actions Dokumentation:**
https://docs.github.com/en/actions

**Flutter Build Dokumentation:**
https://docs.flutter.dev/deployment/android

**Support:**
- GitHub Issues im Repository erstellen
- Flutter Community Discord
- Stack Overflow

---

## 🚀 Los geht's!

Jetzt hast du alles was du brauchst:
- ✅ GitHub Actions Workflows (automatisch)
- ✅ Detaillierte Anleitung
- ✅ Troubleshooting Guide

**Erstelle jetzt dein GitHub Repository und lass die APK bauen! 🎵📱**
