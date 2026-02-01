# 🔧 GitHub Actions Build-Fehler beheben

## ❌ "Process completed with exit code 1"

Dieser Fehler bedeutet, dass der Build fehlgeschlagen ist. Hier sind die Lösungen:

---

## 🎯 Lösung 1: Aktualisierte Dateien hochladen

Ich habe **fehlende Android-Konfigurationsdateien** hinzugefügt:

### Neue Dateien:
- ✅ `android/build.gradle` (Root build file)
- ✅ `android/gradle/wrapper/gradle-wrapper.properties`
- ✅ `android/app/proguard-rules.pro`
- ✅ `android/local.properties`

### Was du tun musst:

**Option A: Kompletter Neu-Upload (Einfachste Methode)**

1. **Lösche dein aktuelles Repository:**
   - Gehe zu Repository Settings (ganz unten)
   - "Delete this repository"
   - Bestätige mit Repository-Namen

2. **Erstelle neues Repository:**
   - https://github.com/new
   - Name: `notenverwaltung-app`
   - "Create repository"

3. **Lade die NEUE ZIP hoch:**
   - Download: `notenverwaltung_app_fixed.zip`
   - Entpacken
   - ALLE Dateien zu GitHub hochladen (inkl. `.github` Ordner!)

4. **Build erneut starten**

**Option B: Nur neue Dateien hinzufügen (Fortgeschrittene)**

1. Erstelle diese Dateien manuell in GitHub:

**Datei 1:** `android/build.gradle`
```gradle
buildscript {
    ext.kotlin_version = '1.9.0'
    repositories {
        google()
        mavenCentral()
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:8.1.1'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = '../build'
subprojects {
    project.buildDir = "${rootProject.buildDir}/${project.name}"
}
subprojects {
    project.evaluationDependsOn(':app')
}

tasks.register("clean", Delete) {
    delete rootProject.buildDir
}
```

**Datei 2:** `android/gradle/wrapper/gradle-wrapper.properties`
```properties
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-8.3-all.zip
```

**Datei 3:** `android/app/proguard-rules.pro`
```proguard
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }
```

---

## 🔍 Lösung 2: Workflow anpassen

Falls der Fehler weiterhin besteht, passe den Workflow an:

### Vereinfachter Workflow (mehr Debugging):

Ersetze `.github/workflows/build-apk.yml` mit:

```yaml
name: Build Android APK

on:
  workflow_dispatch:

jobs:
  build:
    name: Build APK
    runs-on: ubuntu-latest
    
    steps:
    - name: 📥 Checkout repository
      uses: actions/checkout@v4
    
    - name: ☕ Setup Java
      uses: actions/setup-java@v4
      with:
        distribution: 'zulu'
        java-version: '17'
    
    - name: 🐦 Setup Flutter
      uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.19.6'
        channel: 'stable'
    
    - name: 📦 Get dependencies
      run: flutter pub get
    
    - name: 🔨 Build APK
      run: flutter build apk --release --verbose
    
    - name: 📤 Upload APK
      uses: actions/upload-artifact@v4
      if: success()
      with:
        name: app-release
        path: build/app/outputs/flutter-apk/app-release.apk
```

Dieser Workflow:
- ✅ Baut nur eine Universal-APK (einfacher)
- ✅ Zeigt mehr Debug-Informationen (`--verbose`)
- ✅ Startet nur manuell (weniger Fehler)

---

## 🐛 Lösung 3: Häufige spezifische Fehler

### Fehler: "SDK version not found"

**In `android/app/build.gradle` ändern:**
```gradle
android {
    compileSdkVersion 34  // Statt flutter.compileSdkVersion
    
    defaultConfig {
        minSdkVersion 21
        targetSdkVersion 34
    }
}
```

### Fehler: "Kotlin version mismatch"

**In `android/build.gradle` ändern:**
```gradle
ext.kotlin_version = '1.9.0'  // Neuere Version
```

### Fehler: "Gradle sync failed"

**Lösung:** Füge in `android/settings.gradle` hinzu:
```gradle
pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
```

---

## 📊 Debug-Informationen sammeln

Um das genaue Problem zu finden:

1. **Gehe zum fehlgeschlagenen Build**
2. **Klicke auf "Build APK" Step**
3. **Suche nach:**
   - `FAILURE: Build failed with an exception.`
   - `What went wrong:`
   - `* Exception is:`
4. **Kopiere die Fehlermeldung**
5. **Google:** "Flutter GitHub Actions [DEINE FEHLERMELDUNG]"

---

## ✅ Finale Checkliste

Stelle sicher, dass im Repository vorhanden sind:

```
✅ .github/workflows/build-apk.yml
✅ android/app/build.gradle
✅ android/app/src/main/AndroidManifest.xml
✅ android/build.gradle (NEU!)
✅ android/gradle/wrapper/gradle-wrapper.properties (NEU!)
✅ android/settings.gradle
✅ android/app/proguard-rules.pro (NEU!)
✅ lib/main.dart
✅ pubspec.yaml
```

---

## 🚀 Nach dem Fix:

1. **Neue Dateien hochladen**
2. **Actions → Build Android APK**
3. **Run workflow**
4. **Warten 10 Min**
5. **Sollte jetzt ✅ grün sein!**

---

## 💡 Alternative: Vereinfachter Workflow

Falls es immer noch nicht funktioniert, nutze diesen super-einfachen Workflow:

```yaml
name: Simple APK Build

on:
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    - uses: actions/setup-java@v4
      with:
        distribution: 'zulu'
        java-version: '17'
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.19.6'
    - run: flutter pub get
    - run: flutter build apk
    - uses: actions/upload-artifact@v4
      with:
        name: apk
        path: build/app/outputs/flutter-apk/*.apk
```

---

## 📞 Weitere Hilfe

**Wenn immer noch Fehler:**
1. Zeige mir die **genaue Fehlermeldung** aus den Logs
2. Zeige mir welche **Dateien in deinem Repository** sind
3. Ich helfe dir dann gezielt!

**Tipp:** Nutze die neue `notenverwaltung_app_fixed.zip` - dort sind alle Fixes drin! 🎯
