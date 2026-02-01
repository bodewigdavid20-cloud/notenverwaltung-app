# 🎵 Notenverwaltung App - Schnellstart

## 🚀 Installation in 3 Schritten

### 1️⃣ Flutter installieren
**Windows:** https://flutter.dev/docs/get-started/install/windows
**macOS:** `brew install flutter` oder Manual Download
**Linux:** Download von flutter.dev

### 2️⃣ App starten
```bash
cd notenverwaltung_app
flutter pub get
flutter run
```

### 3️⃣ Fertig! 🎉

## ✨ Wichtigste Features

### Lieder verwalten
- ✅ Titel, Komponist, Tonart, Notizen
- ⭐ Doppelte Bewertung (Können & Mögen)
- 📁 Kategorien-System
- 📝 Liedtext in Strophen

### Beamer-Funktion
1. Lied auswählen
2. Strophe im rechten Panel anklicken
3. "Beamer" Button → Strophe erscheint auf schwarzem Hintergrund
4. Im Beamer: Neue Lieder auswählen, Blackout-Funktion

### 3-Punkte-Menü (⋮)
- ✏️ Bearbeiten
- 📋 Duplizieren
- 💾 Exportieren
- 🗑️ Löschen

### Speicheroptionen
- 💻 **Lokal** - Im App-Speicher
- 📂 **Ordner** - Automatische .txt Synchronisation
- ☁️ **Google Drive** - Cloud-Speicherung (in Entwicklung)

## 📄 Dateiformat

Lieder werden als .txt gespeichert:
```
Titel: Amazing Grace
Komponist: John Newton
Tonart: G-Dur
Können: ★★★★☆
Mögen: ★★★★★
Kategorien: Klassik, Gospel

Amazing grace, how sweet the sound
That saved a wretch like me

I once was lost, but now am found
Was blind but now I see
```

## 🎯 Workflow

1. **Kategorien anlegen** (📁 Icon oben)
2. **Lied hinzufügen** (+ Button)
3. **Strophe auswählen** (Im rechten Panel anklicken)
4. **Projizieren** (Beamer Button)
5. Im Beamer: Strophe wechseln durch Anklicken

## 🔧 Build für Produktion

**Windows:**
```bash
flutter build windows --release
# → build/windows/runner/Release/
```

**macOS:**
```bash
flutter build macos --release
# → build/macos/Build/Products/Release/
```

**Linux:**
```bash
flutter build linux --release
# → build/linux/x64/release/bundle/
```

## 📱 Bedienung

### Hauptscreen
- **Links:** Lieder-Liste mit Filter & Sortierung
- **Rechts:** Ausgewähltes Lied mit allen Strophen
- **Strophe anklicken:** Markiert für Beamer-Anzeige

### Beamer-Modus
- **Oben links:** Lied-Auswahl (mit Filter & Sortierung)
- **Oben rechts:** Blackout-Button
- **Auf Gerät:** Alle Strophen sichtbar zum Anklicken
- **Auf Beamer:** Nur ausgewählte Strophe, zentriert, schwarz

### Tastatur (geplant)
- `B` - Blackout
- `ESC` - Beamer schließen

## 💾 Import/Export

**Einzelnes Lied:** Einstellungen → "Lied importieren"
**Ordner importieren:** Alle .txt auf einmal
**Alle exportieren:** Komplette Sammlung in Ordner

## 🆘 Probleme?

```bash
# Alles neu installieren
flutter clean
flutter pub get
flutter run

# Flutter prüfen
flutter doctor

# Cache reparieren
flutter pub cache repair
```

## 📚 Mehr Infos

- **README.md** - Vollständige Feature-Liste
- **INSTALLATION.md** - Detaillierte Installation
- **Flutter Docs** - https://flutter.dev/docs

Viel Erfolg! 🎶
