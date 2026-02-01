# Installation & Setup Guide

## Schritt-für-Schritt Anleitung

### 1. Flutter Installation

#### Windows
1. Downloade Flutter SDK: https://flutter.dev/docs/get-started/install/windows
2. Entpacke das ZIP in `C:\src\flutter`
3. Füge `C:\src\flutter\bin` zu den Umgebungsvariablen hinzu
4. Öffne CMD und führe aus: `flutter doctor`

#### macOS
```bash
# Mit Homebrew
brew install flutter

# Oder manuell
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"
```

#### Linux
```bash
# Download Flutter
cd ~
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.x.x-stable.tar.xz
tar xf flutter_linux_3.x.x-stable.tar.xz

# PATH setzen
export PATH="$PATH:$HOME/flutter/bin"
```

### 2. Dependencies Prüfen
```bash
flutter doctor
```

Stelle sicher, dass folgendes installiert ist:
- ✅ Flutter SDK
- ✅ Android Studio (für Android)
- ✅ Xcode (für iOS/macOS, nur auf Mac)
- ✅ VS Code oder Android Studio (empfohlen)

### 3. Projekt Setup

```bash
# In den Projekt-Ordner wechseln
cd notenverwaltung_app

# Dependencies installieren
flutter pub get

# Für Desktop (aktivieren falls noch nicht geschehen)
flutter config --enable-windows-desktop  # Windows
flutter config --enable-macos-desktop    # macOS
flutter config --enable-linux-desktop    # Linux
```

### 4. App Starten

#### Entwicklungsmodus
```bash
# Liste verfügbarer Geräte
flutter devices

# App auf spezifischem Gerät starten
flutter run -d windows        # Windows
flutter run -d macos          # macOS
flutter run -d linux          # Linux
flutter run -d chrome         # Web Browser
```

#### Produktions-Build

**Windows:**
```bash
flutter build windows --release
# Ausgabe: build/windows/runner/Release/
```

**macOS:**
```bash
flutter build macos --release
# Ausgabe: build/macos/Build/Products/Release/
```

**Linux:**
```bash
flutter build linux --release
# Ausgabe: build/linux/x64/release/bundle/
```

**Android APK:**
```bash
flutter build apk --release
# Ausgabe: build/app/outputs/flutter-apk/app-release.apk
```

### 5. IDE Setup

#### VS Code (empfohlen)
1. Installiere VS Code: https://code.visualstudio.com/
2. Installiere Extensions:
   - Flutter
   - Dart
3. Öffne den Projekt-Ordner
4. Drücke `F5` zum Debuggen

#### Android Studio
1. Installiere Android Studio: https://developer.android.com/studio
2. Installiere Flutter Plugin: File → Settings → Plugins → Flutter
3. Öffne das Projekt
4. Klicke auf "Run" (grüner Pfeil)

### 6. Troubleshooting

#### "Flutter not found"
```bash
# PATH prüfen
echo $PATH  # Linux/Mac
echo %PATH%  # Windows

# Flutter bin Ordner muss enthalten sein
```

#### "No devices found"
```bash
# Für Desktop: Enable Desktop support
flutter config --enable-windows-desktop
flutter config --enable-macos-desktop
flutter config --enable-linux-desktop

# Für Android: USB-Debugging aktivieren
# Für iOS: Xcode installieren
```

#### Build Fehler
```bash
# Clean und neu builden
flutter clean
flutter pub get
flutter run
```

#### Dependencies Probleme
```bash
# Pub Cache löschen
flutter pub cache repair
flutter pub get
```

### 7. Erste Nutzung

Nach der Installation:

1. **App starten**
2. **Kategorien anlegen**: Klicke auf das 📁 Symbol oben rechts
3. **Erstes Lied hinzufügen**: Klicke auf "+ Neues Lied"
4. **Lied testen**: Wähle das Lied aus und klicke auf "Beamer"

### 8. Deployment

#### Windows Installer erstellen
```bash
# Mit MSIX (empfohlen)
flutter pub add msix
flutter pub run msix:create

# Oder mit Inno Setup
# https://jrsoftware.org/isinfo.php
```

#### macOS DMG erstellen
```bash
# Build erstellen
flutter build macos --release

# DMG mit create-dmg
npm install --global create-dmg
create-dmg 'build/macos/Build/Products/Release/notenverwaltung_app.app'
```

#### Linux AppImage
```bash
flutter build linux --release

# Mit appimagetool
# https://github.com/AppImage/AppImageKit
```

### 9. Updates

```bash
# Flutter aktualisieren
flutter upgrade

# Dependencies aktualisieren
flutter pub upgrade

# App neu builden
flutter clean
flutter pub get
flutter run
```

### 10. Backup & Export

Die App speichert Daten in:
- **Windows**: `%APPDATA%\com.example\notenverwaltung_app`
- **macOS**: `~/Library/Application Support/com.example.notenverwaltung_app`
- **Linux**: `~/.local/share/com.example.notenverwaltung_app`

Für Backups:
1. In den Einstellungen "Alle exportieren" nutzen
2. Oder den Speicherort-Ordner kopieren

## Support

Bei Problemen:
1. Prüfe `flutter doctor`
2. Lese die Flutter-Dokumentation: https://flutter.dev/docs
3. Erstelle ein Issue im Repository

## Systemanforderungen

**Minimum:**
- 4 GB RAM
- 2 GB freier Speicherplatz
- 64-bit Betriebssystem

**Empfohlen:**
- 8 GB RAM
- 5 GB freier Speicherplatz
- SSD
- Dedizierte Grafikkarte (für bessere Performance)
