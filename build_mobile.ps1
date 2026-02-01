# Notenverwaltung App - Mobile Build Script (Windows)
# PowerShell Script für Windows Nutzer

Write-Host "🎵 Notenverwaltung App - Mobile Build Script" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan
Write-Host ""

# Check if Flutter is installed
if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Flutter ist nicht installiert!" -ForegroundColor Red
    Write-Host "Bitte installiere Flutter: https://flutter.dev/docs/get-started/install/windows"
    exit 1
}

Write-Host "✅ Flutter gefunden" -ForegroundColor Green
Write-Host ""

# Show menu
Write-Host "Wähle Build-Option:"
Write-Host "1) Android APK (Debug)"
Write-Host "2) Android APK (Release)"
Write-Host "3) Android APK (Release - Split per ABI)"
Write-Host "4) Android App Bundle (Play Store)"
Write-Host "5) Alle Android Builds"
Write-Host "6) Flutter Clean & Pub Get"
Write-Host "7) Exit"
Write-Host ""

$choice = Read-Host "Eingabe (1-7)"

switch ($choice) {
    "1" {
        Write-Host "📱 Baue Android APK (Debug)..." -ForegroundColor Yellow
        flutter build apk --debug
        Write-Host "✅ Fertig!" -ForegroundColor Green
        Write-Host "Datei: build\app\outputs\flutter-apk\app-debug.apk"
    }
    "2" {
        Write-Host "📱 Baue Android APK (Release)..." -ForegroundColor Yellow
        flutter build apk --release
        Write-Host "✅ Fertig!" -ForegroundColor Green
        Write-Host "Datei: build\app\outputs\flutter-apk\app-release.apk"
    }
    "3" {
        Write-Host "📱 Baue Android APK (Release - Optimiert)..." -ForegroundColor Yellow
        flutter build apk --release --split-per-abi
        Write-Host "✅ Fertig!" -ForegroundColor Green
        Write-Host "Dateien in: build\app\outputs\flutter-apk\"
        Get-ChildItem build\app\outputs\flutter-apk\*.apk | Format-Table Name, Length
    }
    "4" {
        Write-Host "📱 Baue Android App Bundle (Play Store)..." -ForegroundColor Yellow
        flutter build appbundle --release
        Write-Host "✅ Fertig!" -ForegroundColor Green
        Write-Host "Datei: build\app\outputs\bundle\release\app-release.aab"
    }
    "5" {
        Write-Host "📱 Baue alle Android Builds..." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "1/3 - Debug APK..."
        flutter build apk --debug
        Write-Host ""
        Write-Host "2/3 - Release APK..."
        flutter build apk --release
        Write-Host ""
        Write-Host "3/3 - App Bundle..."
        flutter build appbundle --release
        Write-Host ""
        Write-Host "✅ Alle Builds fertig!" -ForegroundColor Green
        Write-Host ""
        Write-Host "Dateien:"
        Write-Host "- build\app\outputs\flutter-apk\app-debug.apk"
        Write-Host "- build\app\outputs\flutter-apk\app-release.apk"
        Write-Host "- build\app\outputs\bundle\release\app-release.aab"
    }
    "6" {
        Write-Host "🧹 Führe Flutter Clean & Pub Get aus..." -ForegroundColor Yellow
        flutter clean
        flutter pub get
        Write-Host "✅ Fertig!" -ForegroundColor Green
    }
    "7" {
        Write-Host "Auf Wiedersehen! 👋"
        exit 0
    }
    default {
        Write-Host "❌ Ungültige Eingabe!" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "🎉 Build erfolgreich abgeschlossen!" -ForegroundColor Green
