# 📱 Mobile Build Guide - Android & iOS

## Detaillierte Anleitung zum Erstellen der APK/IPA

---

## 🤖 Android Build

### Voraussetzungen
- ✅ Flutter SDK installiert
- ✅ Android Studio installiert
- ✅ Android SDK (mindestens API 21)
- ✅ Java JDK 11 oder höher

### Schritt 1: Android Studio Setup

1. **Android Studio installieren**
   ```
   https://developer.android.com/studio
   ```

2. **Android SDK installieren**
   - Android Studio öffnen
   - Tools → SDK Manager
   - Android SDK Command-line Tools installieren
   - Android SDK Platform 34 installieren

3. **Flutter mit Android verbinden**
   ```bash
   flutter doctor --android-licenses
   # Alle Lizenzen mit 'y' akzeptieren
   ```

### Schritt 2: App-Signierung einrichten (für Release)

1. **Keystore erstellen**
   ```bash
   # Windows
   keytool -genkey -v -keystore C:\Users\DEIN_NAME\notenverwaltung-key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias notenverwaltung

   # macOS/Linux
   keytool -genkey -v -keystore ~/notenverwaltung-key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias notenverwaltung
   ```

2. **key.properties erstellen**
   
   Erstelle `android/key.properties`:
   ```properties
   storePassword=DEIN_PASSWORT
   keyPassword=DEIN_PASSWORT
   keyAlias=notenverwaltung
   storeFile=C:/Users/DEIN_NAME/notenverwaltung-key.jks
   # Oder für Mac/Linux:
   # storeFile=/Users/DEIN_NAME/notenverwaltung-key.jks
   ```

3. **build.gradle anpassen**
   
   Bearbeite `android/app/build.gradle`:
   ```gradle
   def keystoreProperties = new Properties()
   def keystorePropertiesFile = rootProject.file('key.properties')
   if (keystorePropertiesFile.exists()) {
       keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
   }

   android {
       ...
       signingConfigs {
           release {
               keyAlias keystoreProperties['keyAlias']
               keyPassword keystoreProperties['keyPassword']
               storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
               storePassword keystoreProperties['storePassword']
           }
       }
       buildTypes {
           release {
               signingConfig signingConfigs.release
           }
       }
   }
   ```

### Schritt 3: APK Bauen

**Für Testing (Debug):**
```bash
cd notenverwaltung_app
flutter build apk --debug
```
Ausgabe: `build/app/outputs/flutter-apk/app-debug.apk`

**Für Veröffentlichung (Release):**
```bash
flutter build apk --release
```
Ausgabe: `build/app/outputs/flutter-apk/app-release.apk`

**Optimierte APK (kleinere Datei):**
```bash
flutter build apk --release --split-per-abi
```
Erstellt separate APKs für verschiedene Prozessor-Architekturen:
- `app-armeabi-v7a-release.apk` (32-bit ARM)
- `app-arm64-v8a-release.apk` (64-bit ARM) ← **Empfohlen für moderne Geräte**
- `app-x86_64-release.apk` (64-bit x86)

### Schritt 4: App Bundle für Play Store

```bash
flutter build appbundle --release
```
Ausgabe: `build/app/outputs/bundle/release/app-release.aab`

**Vorteile von App Bundle:**
- ✅ Kleinere Download-Größe
- ✅ Automatische Optimierung pro Gerät
- ✅ Erforderlich für Play Store

### Schritt 5: Installation testen

**Via USB:**
```bash
# Gerät per USB verbinden, USB-Debugging aktivieren
flutter install

# Oder manuell
adb install build/app/outputs/flutter-apk/app-release.apk
```

**Via Datei-Sharing:**
1. APK auf Gerät kopieren
2. Auf Gerät öffnen
3. Installation bestätigen (erfordert "Unbekannte Quellen" in Einstellungen)

---

## 🍎 iOS Build

### Voraussetzungen
- ✅ macOS Computer (iOS Build nur auf Mac möglich!)
- ✅ Xcode 14+ installiert
- ✅ Apple Developer Account ($99/Jahr für App Store)
- ✅ CocoaPods installiert

### Schritt 1: Xcode Setup

1. **Xcode installieren**
   ```bash
   # Aus App Store oder:
   xcode-select --install
   ```

2. **CocoaPods installieren**
   ```bash
   sudo gem install cocoapods
   ```

3. **iOS Simulator setup**
   ```bash
   xcodebuild -downloadPlatform iOS
   ```

### Schritt 2: Projekt konfigurieren

1. **Bundle Identifier setzen**
   - Öffne `ios/Runner.xcworkspace` in Xcode
   - Wähle "Runner" im Project Navigator
   - Unter "General" → Bundle Identifier: `com.deinname.notenverwaltung`

2. **Team auswählen**
   - In Xcode unter "Signing & Capabilities"
   - Team auswählen (Apple Developer Account erforderlich)
   - Automatisches Signing aktivieren

3. **Deployment Target**
   - Mindestens iOS 12.0 einstellen
   - In `ios/Podfile`:
   ```ruby
   platform :ios, '12.0'
   ```

### Schritt 3: Dependencies installieren

```bash
cd notenverwaltung_app/ios
pod install
cd ..
```

### Schritt 4: IPA Bauen

**Für Simulator (Testing):**
```bash
flutter build ios --simulator
```

**Für echte Geräte (Development):**
```bash
flutter build ios --debug --no-codesign
```

**Für App Store (Release):**
```bash
flutter build ios --release
```

### Schritt 5: IPA erstellen (für Verteilung)

1. **In Xcode:**
   - Öffne `ios/Runner.xcworkspace`
   - Wähle "Product" → "Archive"
   - Warte bis Archivierung fertig ist
   - Window → Organizer öffnet sich
   - "Distribute App" wählen

2. **Verteilungsoptionen:**
   - **Ad Hoc**: Für Testing auf registrierten Geräten
   - **App Store**: Für Veröffentlichung
   - **Development**: Für lokales Testing

### Schritt 6: TestFlight (empfohlen für Testing)

1. **IPA zu TestFlight hochladen**
   - In Xcode Organizer: "Distribute App"
   - "App Store Connect" wählen
   - "Upload" wählen
   - Warten auf Verarbeitung (kann 30+ Minuten dauern)

2. **Tester einladen**
   - https://appstoreconnect.apple.com
   - App auswählen → TestFlight
   - Interne/Externe Tester hinzufügen

---

## 🔧 Troubleshooting

### Android

**Problem: "SDK location not found"**
```bash
# Erstelle android/local.properties:
sdk.dir=C:\\Users\\DEIN_NAME\\AppData\\Local\\Android\\sdk
# Oder auf Mac:
sdk.dir=/Users/DEIN_NAME/Library/Android/sdk
```

**Problem: "Gradle build failed"**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk
```

**Problem: "Execution failed for task ':app:lintVitalRelease'"**
```gradle
# In android/app/build.gradle:
android {
    lintOptions {
        checkReleaseBuilds false
    }
}
```

### iOS

**Problem: "CocoaPods not installed"**
```bash
sudo gem install cocoapods
pod setup
```

**Problem: "Signing requires a development team"**
- In Xcode: Signing & Capabilities → Team auswählen
- Kostenloses Apple ID funktioniert für lokales Testing

**Problem: "Module not found"**
```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter build ios
```

---

## 📦 Dateigrößen (ca.)

### Android
- **Debug APK**: ~45 MB
- **Release APK**: ~20 MB
- **App Bundle**: ~15 MB
- **Split APK (arm64)**: ~15 MB

### iOS
- **Debug Build**: ~100 MB
- **Release IPA**: ~40 MB
- **App Store Compressed**: ~25 MB

---

## 🚀 Build-Befehle Zusammenfassung

### Android
```bash
# Debug (Testing)
flutter build apk --debug

# Release (Veröffentlichung)
flutter build apk --release

# Optimiert (empfohlen)
flutter build apk --release --split-per-abi

# App Bundle (Play Store)
flutter build appbundle --release
```

### iOS
```bash
# Simulator
flutter build ios --simulator

# Debug (Gerät)
flutter build ios --debug

# Release
flutter build ios --release

# Dann in Xcode: Product → Archive → Distribute
```

---

## 📱 Installation auf Geräten

### Android (ohne Play Store)

1. **USB-Verbindung:**
   ```bash
   adb install app-release.apk
   ```

2. **Direkter Download:**
   - APK auf Webserver hochladen
   - Auf Gerät herunterladen
   - "Unbekannte Quellen" aktivieren
   - APK installieren

### iOS (ohne App Store)

**Optionen:**
1. **TestFlight** (empfohlen)
2. **Ad Hoc Distribution** (max. 100 Geräte)
3. **Development Build** (Gerät in Apple Developer Portal registrieren)

---

## 🏪 Store-Veröffentlichung

### Google Play Store
1. Play Console Account erstellen ($25 einmalig)
2. App Bundle hochladen
3. Store Listing ausfüllen
4. Screenshots hochladen (min. 2)
5. Bewertung durchlaufen (~24h)

### Apple App Store
1. Apple Developer Account ($99/Jahr)
2. App Store Connect konfigurieren
3. Screenshots für alle Gerätegrößen
4. App Review Guidelines beachten
5. Bewertung durchlaufen (~24-48h)

---

## ⚙️ Optimierungen

### APK-Größe reduzieren
```bash
# Obfuscation aktivieren
flutter build apk --release --obfuscate --split-debug-info=build/app/outputs/symbols

# Unused resources entfernen
flutter build apk --release --target-platform android-arm64 --shrink
```

### Performance
```bash
# Profile mode für Performance-Testing
flutter build apk --profile
flutter run --profile
```

---

## 🔒 Sicherheit

**Wichtig vor Veröffentlichung:**
- [ ] Alle Debug-Logs entfernen
- [ ] API-Keys verschlüsseln
- [ ] ProGuard/R8 aktivieren (Android)
- [ ] Obfuscation aktivieren
- [ ] SSL/TLS für Netzwerk-Zugriffe
- [ ] Permissions minimieren

---

## 📞 Support

Bei Problemen:
- Flutter Doctor: `flutter doctor -v`
- Android: Android Studio Logcat
- iOS: Xcode Console
- Flutter Issues: https://github.com/flutter/flutter/issues

**Hilfreiche Befehle:**
```bash
flutter clean
flutter pub get
flutter pub upgrade
flutter doctor -v
```

Viel Erfolg! 🎉
