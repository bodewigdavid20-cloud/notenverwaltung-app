# 📱 Android APK - Schritt-für-Schritt Anleitung

## Schnellstart (wenn Flutter bereits installiert ist)

```bash
cd notenverwaltung_app
flutter pub get
flutter build apk --release
```

Die APK findet du dann in: `build/app/outputs/flutter-apk/app-release.apk`

---

## Detaillierte Anleitung für Anfänger

### 1️⃣ Flutter installieren (Windows)

1. **Download Flutter SDK**
   - Gehe zu: https://docs.flutter.dev/get-started/install/windows
   - Lade "flutter_windows_xxx-stable.zip" herunter

2. **Entpacken**
   - Erstelle Ordner `C:\src`
   - Entpacke ZIP nach `C:\src\flutter`

3. **Umgebungsvariable setzen**
   - Windows-Taste + R → "sysdm.cpl" eingeben
   - Tab "Erweitert" → "Umgebungsvariablen"
   - Bei "Path" auf "Bearbeiten" klicken
   - "Neu" → `C:\src\flutter\bin` hinzufügen
   - Alles mit OK bestätigen

4. **Testen**
   - Neue Eingabeaufforderung öffnen
   - `flutter --version` eingeben
   - Sollte Version anzeigen

### 2️⃣ Android Studio installieren

1. **Download**
   - https://developer.android.com/studio
   - Installer herunterladen und ausführen

2. **Installation**
   - Standard-Installation wählen
   - Android SDK wird automatisch installiert
   - Warten bis "Finish" erscheint

3. **SDK Command-line Tools**
   - Android Studio öffnen
   - "More Actions" → "SDK Manager"
   - Tab "SDK Tools"
   - ☑️ "Android SDK Command-line Tools" aktivieren
   - "Apply" klicken
   - Warten bis Installation fertig

### 3️⃣ Flutter Setup abschließen

1. **Flutter Doctor ausführen**
   ```bash
   flutter doctor
   ```

2. **Lizenzen akzeptieren**
   ```bash
   flutter doctor --android-licenses
   ```
   - Alle mit "y" bestätigen

3. **Nochmal prüfen**
   ```bash
   flutter doctor
   ```
   - Android toolchain sollte ✓ haben

### 4️⃣ App-Projekt vorbereiten

1. **In Projekt-Ordner wechseln**
   ```bash
   cd C:\Pfad\zu\notenverwaltung_app
   ```

2. **Dependencies installieren**
   ```bash
   flutter pub get
   ```
   - Warte bis "Got dependencies!" erscheint

### 5️⃣ APK bauen

**Option A: Einfacher Build (größere Datei)**
```bash
flutter build apk --release
```

**Option B: Optimierter Build (kleinere Dateien)**
```bash
flutter build apk --release --split-per-abi
```

**Dauer:** 3-10 Minuten beim ersten Mal

### 6️⃣ APK finden und testen

1. **APK-Datei finden**
   - Öffne: `build\app\outputs\flutter-apk\`
   - Bei Option A: `app-release.apk` (~20 MB)
   - Bei Option B: `app-arm64-v8a-release.apk` (~15 MB) ← Diese für moderne Handys

2. **Auf Handy installieren**
   
   **Methode 1: USB-Kabel**
   ```bash
   # USB-Debugging auf Handy aktivieren
   # Handy per USB verbinden
   adb install build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
   ```

   **Methode 2: Datei-Transfer**
   - APK auf Handy kopieren (USB, E-Mail, Cloud)
   - Auf Handy die Datei öffnen
   - "Aus unbekannten Quellen installieren" zulassen
   - Installation bestätigen

---

## 🚀 Build-Script verwenden (Einfacher!)

**Windows:**
```powershell
.\build_mobile.ps1
```

**Linux/Mac:**
```bash
./build_mobile.sh
```

Dann einfach Option wählen!

---

## ⚡ Häufige Probleme

### "Flutter command not found"
**Lösung:**
- Eingabeaufforderung neu starten
- PATH-Variable prüfen
- Flutter neu installieren

### "Android SDK not found"
**Lösung:**
```bash
flutter doctor --android-licenses
```

### "Gradle build failed"
**Lösung:**
```bash
cd android
.\gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk --release
```

### Build sehr langsam
**Lösung:**
- Beim ersten Mal dauert es länger (3-10 Min)
- Antivirus ausschalten während Build
- SSD verwenden statt HDD

### APK zu groß
**Lösung:**
```bash
# Split per ABI verwenden
flutter build apk --release --split-per-abi
```

---

## 📦 Verschiedene Build-Varianten

### 1. Debug (zum Testen)
```bash
flutter build apk --debug
# → app-debug.apk (~45 MB)
# Größer, aber mit Debug-Informationen
```

### 2. Release (Standard)
```bash
flutter build apk --release
# → app-release.apk (~20 MB)
# Optimiert, keine Debug-Info
```

### 3. Split per ABI (Empfohlen!)
```bash
flutter build apk --release --split-per-abi
# → Mehrere APKs:
# - app-armeabi-v7a-release.apk (~15 MB, alte Geräte)
# - app-arm64-v8a-release.apk (~15 MB, moderne Geräte) ← Diese verwenden!
# - app-x86_64-release.apk (~15 MB, Emulatoren)
```

### 4. App Bundle (für Play Store)
```bash
flutter build appbundle --release
# → app-release.aab (~15 MB)
# Nur für Play Store Upload
```

---

## 🎯 Was soll ich verwenden?

**Für eigenes Handy:** 
→ `app-arm64-v8a-release.apk`

**Für viele verschiedene Handys:** 
→ `app-release.apk`

**Für Google Play Store:** 
→ `app-release.aab`

---

## 📱 APK auf Handy installieren

### Schritt 1: Unbekannte Quellen erlauben

**Android 8+:**
1. Einstellungen → Apps & Benachrichtigungen
2. Erweitert → Spezieller App-Zugriff
3. Apps aus unbekannten Quellen installieren
4. Datei-Manager oder Chrome auswählen
5. "Aus dieser Quelle zulassen" aktivieren

**Android 7 und älter:**
1. Einstellungen → Sicherheit
2. "Unbekannte Quellen" aktivieren

### Schritt 2: APK übertragen

**Option A: Google Drive**
1. APK zu Google Drive hochladen
2. Auf Handy in Drive-App öffnen
3. Herunterladen & Installieren

**Option B: USB-Kabel**
1. APK in einen Ordner auf dem PC kopieren
2. Handy per USB verbinden
3. Datei auf Handy kopieren
4. Auf Handy mit Datei-Manager öffnen

**Option C: ADB (für Entwickler)**
```bash
adb install app-release.apk
```

---

## ✅ Checkliste

- [ ] Flutter installiert
- [ ] Android Studio installiert
- [ ] `flutter doctor` erfolgreich
- [ ] `flutter pub get` ausgeführt
- [ ] APK gebaut
- [ ] APK auf Handy übertragen
- [ ] App installiert
- [ ] App funktioniert

---

## 🎉 Fertig!

Die App sollte jetzt auf deinem Handy laufen!

**App-Name:** Notenverwaltung  
**Icon:** Musik-Note 🎵

Bei Problemen: BUILD_MOBILE.md für detaillierte Hilfe lesen.
