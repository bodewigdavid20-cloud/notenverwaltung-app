# 📱 GitHub Upload vom Handy - Ultra-Schnellanleitung

## 5 Minuten bis zur fertigen APK! ⚡

---

## Schritt 1: GitHub Account (2 Min)

1. **Handy-Browser öffnen** (Chrome, Firefox, Safari)
2. Gehe zu: **https://github.com/signup**
3. **E-Mail, Passwort, Username** eingeben
4. **E-Mail bestätigen**
5. ✅ Fertig!

---

## Schritt 2: Projekt hochladen (3 Min)

### A) ZIP-Datei erstellen

Auf deinem Computer/Handy:
1. Öffne den Ordner `notenverwaltung_app`
2. **Alle Dateien markieren**
3. **"Komprimieren" oder "ZIP erstellen"** (Rechtsklick)
4. Nenne es: `notenverwaltung-app.zip`

### B) Zu GitHub hochladen

Im Handy-Browser auf GitHub:

1. **Neues Repository:**
   - Gehe zu: https://github.com/new
   - Name: `notenverwaltung-app`
   - Public ✅
   - **"Create repository"**

2. **Dateien hochladen:**
   - Klicke: **"uploading an existing file"**
   - **ZIP-Datei auswählen** (oder ziehen)
   - Warte bis Upload fertig (1-3 Min)
   - Klicke: **"Commit changes"**

---

## Schritt 3: Build starten (1 Klick)

1. **Oben auf "Actions"** klicken
2. **"I understand my workflows, go ahead and enable them"** klicken
3. Links: **"Build Android APK"** wählen
4. Rechts: **"Run workflow"** klicken
5. Grüner Button: **"Run workflow"** klicken
6. ⏳ **Warten 7-10 Minuten**

---

## Schritt 4: APK downloaden (30 Sek)

1. **Warte bis grüner Haken** ✅ erscheint
2. **Auf den grünen Build klicken**
3. **Nach unten scrollen** zu "Artifacts"
4. **Download:** `app-arm64-v8a-release`
5. **ZIP entpacken** → APK ist drin!

---

## Schritt 5: Installieren

1. APK auf Handy kopieren
2. Öffnen
3. "Unbekannte Quellen" aktivieren
4. **Installieren**
5. 🎉 **Fertig!**

---

## 🎯 Noch einfacher: Release-Link

### Öffentlichen Download-Link erstellen:

1. In GitHub: **"Actions"**
2. Workflow: **"Create Release"**
3. **"Run workflow"**
4. Version eingeben: `v1.0.0`
5. **"Run workflow"**
6. Warten 10 Min
7. **"Releases"** → APK downloaden

Jetzt kann **jeder** die APK runterladen unter:
```
https://github.com/DEIN_USERNAME/notenverwaltung-app/releases
```

---

## 💡 Pro-Tipp

**GitHub App installieren** (optional):
- Android: https://play.google.com/store/apps/details?id=com.github.android
- iOS: https://apps.apple.com/app/github/id1477376905

Dann Build direkt in der App starten! 📱

---

## ❓ Häufige Fragen

**Q: Kostet GitHub Actions etwas?**
A: Nein! 2000 Minuten/Monat kostenlos (1 Build = ~10 Min)

**Q: Ist das sicher?**
A: Ja! GitHub ist von Microsoft und wird von Millionen genutzt

**Q: Kann ich das Repo privat machen?**
A: Ja! Funktioniert auch mit privaten Repos

**Q: Muss ich Git kennen?**
A: Nein! ZIP hochladen reicht komplett

**Q: Wie oft kann ich bauen?**
A: Unlimited! (innerhalb der 2000 Min/Monat)

---

## ⚡ Zusammenfassung

```
1. GitHub Account (2 Min)
2. ZIP hochladen (3 Min)
3. Build starten (1 Klick)
4. Warten (10 Min) ☕
5. APK downloaden (30 Sek)
= FERTIG! 🎉
```

**Keine Installation, kein Flutter, kein Android Studio nötig!** 🚀

Los geht's: https://github.com/signup
