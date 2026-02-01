# Notenverwaltung App

Professionelle Flutter-App zur Verwaltung von Musiknoten mit Beamer-/Projektor-Funktion.

## Features

### ✨ Kernfunktionen
- **Liederverwaltung**: Titel, Komponist, Tonart, Notizen, Liedtext
- **Kategoriesystem**: Flexible Kategorisierung mit Checkboxen
- **Doppelte Bewertung**: "Wie gut können wir das?" & "Wie gerne mögen wir das?" (je 5 Sterne)
- **Strophen-System**: Liedtext in Absätze/Strophen aufteilen

### 📽️ Beamer/Projektor-Funktion
- Vollbild-Anzeige für Projektion
- Strophen einzeln auf schwarzem Hintergrund anzeigen
- Blackout-Funktion zum schnellen Ausblenden
- Lied-Auswahl direkt im Projektor-Modus
- Filter & Sortierung auch im Projektor

### 💾 Speicheroptionen
- **Lokal**: Im App-Speicher
- **Ordner**: Automatische Synchronisation mit einem lokalen Ordner
- **Google Drive**: Cloud-Speicherung (in Entwicklung)

### 📄 Dateiformat (.txt)
Lieder werden im strukturierten TXT-Format gespeichert:
```
Titel: Liedtitel
Komponist: Name
Tonart: C-Dur
Notizen: Zusätzliche Infos
Können: ★★★★☆
Mögen: ★★★★★
Kategorien: Klassik, Konzert

Erste Strophe
Text der ersten Strophe

Zweite Strophe
Text der zweiten Strophe

Refrain
Text des Refrains
```

### 🔧 Lied-Aktionen
- **Bearbeiten**: Alle Felder nachträglich ändern
- **Duplizieren**: Kopie eines Liedes erstellen
- **Exportieren**: Als .txt-Datei speichern
- **Löschen**: Mit Bestätigung

### 📊 Filter & Sortierung
- Nach Kategorien filtern
- Sortieren nach: Titel, Komponist, Datum, Können, Beliebtheit

## Installation

### Voraussetzungen
- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / VS Code mit Flutter Plugin

### Setup
```bash
# 1. Repository klonen oder Dateien entpacken
cd notenverwaltung_app

# 2. Dependencies installieren
flutter pub get

# 3. App starten
flutter run
```

### Build für verschiedene Plattformen

**Desktop (Windows/macOS/Linux):**
```bash
flutter build windows
flutter build macos
flutter build linux
```

**Mobile (Android/iOS):**
```bash
flutter build apk          # Android
flutter build ios          # iOS
```

## Verwendung

### Erste Schritte
1. **Kategorien anlegen**: Klicke auf 📁 in der App-Leiste
2. **Erstes Lied hinzufügen**: Klicke auf den "+ Neues Lied" Button
3. **Lied projizieren**: Lied auswählen und "Beamer" klicken

### Beamer-Bedienung
1. Lied im Hauptscreen auswählen
2. Strophe durch Klick markieren (rechtes Panel)
3. "Beamer" Button klicken
4. Auf dem Projektor erscheint die ausgewählte Strophe zentriert auf schwarzem Hintergrund
5. Im Beamer-Modus:
   - Oben links: Neues Lied auswählen
   - Oben rechts: Blackout-Funktion
   - Filter & Sortierung verfügbar

### Import/Export
- **Einzelnes Lied importieren**: Einstellungen → Import & Export → "Lied importieren"
- **Ordner importieren**: Alle .txt-Dateien aus einem Ordner auf einmal
- **Alle exportieren**: Komplette Sammlung in einen Ordner speichern

### Speicherort-Verwaltung
1. Einstellungen öffnen (⚙️)
2. Gewünschten Speicherort wählen:
   - **Lokal**: Automatisch, keine weitere Konfiguration
   - **Ordner**: Ordner auswählen, Dateien werden automatisch synchronisiert
   - **Google Drive**: Mit Google-Konto verbinden (in Entwicklung)

## Projekt-Struktur

```
lib/
├── main.dart                    # App-Einstiegspunkt
├── models/
│   └── song.dart               # Song-Datenmodell
├── providers/
│   ├── song_provider.dart      # State Management für Lieder
│   └── settings_provider.dart  # Einstellungen-Verwaltung
└── screens/
    ├── home_screen.dart        # Hauptbildschirm mit Lieder-Liste
    ├── song_edit_screen.dart   # Lied erstellen/bearbeiten
    ├── projector_screen.dart   # Beamer/Projektor-Ansicht
    ├── category_management_screen.dart  # Kategorien verwalten
    └── settings_screen.dart    # Einstellungen
```

## Technische Details

### Verwendete Packages
- **provider**: State Management
- **shared_preferences**: Lokale Datenspeicherung
- **path_provider**: Dateisystem-Zugriff
- **file_picker**: Datei- und Ordnerauswahl
- **google_sign_in**: Google-Authentifizierung (für Drive)
- **googleapis**: Google Drive API

### Datenformat
Lieder werden sowohl im JSON-Format (lokal) als auch im TXT-Format (Export/Import) gespeichert.

## Keyboard Shortcuts (geplant)
- `B`: Blackout ein/aus
- `ESC`: Beamer schließen
- `←/→`: Strophe wechseln
- `Space`: Strophe anzeigen/verbergen

## Zukünftige Features
- ✅ Vollständige Google Drive Integration
- ⏳ PDF-Export der Lieder
- ⏳ Setlisten erstellen
- ⏳ Transponierung
- ⏳ Akkorde-Unterstützung
- ⏳ Mehrere Beamer-Ausgänge

## Lizenz
© 2024 - Notenverwaltung App

## Support
Bei Fragen oder Problemen bitte ein Issue erstellen.
