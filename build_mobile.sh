#!/bin/bash

# Notenverwaltung App - Mobile Build Script
# Dieses Script automatisiert den Build-Prozess für Android und iOS

set -e  # Exit on error

echo "🎵 Notenverwaltung App - Mobile Build Script"
echo "============================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo -e "${RED}❌ Flutter ist nicht installiert!${NC}"
    echo "Bitte installiere Flutter: https://flutter.dev/docs/get-started/install"
    exit 1
fi

echo -e "${GREEN}✅ Flutter gefunden${NC}"
echo ""

# Show menu
echo "Wähle Build-Option:"
echo "1) Android APK (Debug)"
echo "2) Android APK (Release)"
echo "3) Android APK (Release - Split per ABI)"
echo "4) Android App Bundle (Play Store)"
echo "5) iOS (Simulator)"
echo "6) iOS (Release)"
echo "7) Alle Android Builds"
echo "8) Flutter Clean & Pub Get"
echo "9) Exit"
echo ""
read -p "Eingabe (1-9): " choice

case $choice in
    1)
        echo -e "${YELLOW}📱 Baue Android APK (Debug)...${NC}"
        flutter build apk --debug
        echo -e "${GREEN}✅ Fertig!${NC}"
        echo "Datei: build/app/outputs/flutter-apk/app-debug.apk"
        ;;
    2)
        echo -e "${YELLOW}📱 Baue Android APK (Release)...${NC}"
        flutter build apk --release
        echo -e "${GREEN}✅ Fertig!${NC}"
        echo "Datei: build/app/outputs/flutter-apk/app-release.apk"
        ;;
    3)
        echo -e "${YELLOW}📱 Baue Android APK (Release - Optimiert)...${NC}"
        flutter build apk --release --split-per-abi
        echo -e "${GREEN}✅ Fertig!${NC}"
        echo "Dateien in: build/app/outputs/flutter-apk/"
        ls -lh build/app/outputs/flutter-apk/*.apk
        ;;
    4)
        echo -e "${YELLOW}📱 Baue Android App Bundle (Play Store)...${NC}"
        flutter build appbundle --release
        echo -e "${GREEN}✅ Fertig!${NC}"
        echo "Datei: build/app/outputs/bundle/release/app-release.aab"
        ;;
    5)
        echo -e "${YELLOW}🍎 Baue iOS (Simulator)...${NC}"
        if [[ "$OSTYPE" != "darwin"* ]]; then
            echo -e "${RED}❌ iOS Build nur auf macOS möglich!${NC}"
            exit 1
        fi
        flutter build ios --simulator
        echo -e "${GREEN}✅ Fertig!${NC}"
        ;;
    6)
        echo -e "${YELLOW}🍎 Baue iOS (Release)...${NC}"
        if [[ "$OSTYPE" != "darwin"* ]]; then
            echo -e "${RED}❌ iOS Build nur auf macOS möglich!${NC}"
            exit 1
        fi
        flutter build ios --release
        echo -e "${GREEN}✅ Fertig!${NC}"
        echo "Öffne Xcode: open ios/Runner.xcworkspace"
        echo "Dann: Product → Archive → Distribute App"
        ;;
    7)
        echo -e "${YELLOW}📱 Baue alle Android Builds...${NC}"
        echo ""
        echo "1/3 - Debug APK..."
        flutter build apk --debug
        echo ""
        echo "2/3 - Release APK..."
        flutter build apk --release
        echo ""
        echo "3/3 - App Bundle..."
        flutter build appbundle --release
        echo ""
        echo -e "${GREEN}✅ Alle Builds fertig!${NC}"
        echo ""
        echo "Dateien:"
        echo "- build/app/outputs/flutter-apk/app-debug.apk"
        echo "- build/app/outputs/flutter-apk/app-release.apk"
        echo "- build/app/outputs/bundle/release/app-release.aab"
        ;;
    8)
        echo -e "${YELLOW}🧹 Führe Flutter Clean & Pub Get aus...${NC}"
        flutter clean
        flutter pub get
        echo -e "${GREEN}✅ Fertig!${NC}"
        ;;
    9)
        echo "Auf Wiedersehen! 👋"
        exit 0
        ;;
    *)
        echo -e "${RED}❌ Ungültige Eingabe!${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}🎉 Build erfolgreich abgeschlossen!${NC}"
