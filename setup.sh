#!/usr/bin/env bash
# ===================================================
#   COS HUB - Linux & macOS Setup Script
# ===================================================
set -e

CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${CYAN}===================================================${NC}"
echo -e "${CYAN}  COS HUB - Setup & Dependency Installer (Unix)    ${NC}"
echo -e "${CYAN}===================================================${NC}"
echo ""

# Check if Flutter exists in PATH
if ! command -v flutter >/dev/null 2>&1; then
    echo -e "${RED}[ERROR] 'flutter' command not found in your PATH.${NC}"
    echo -e "${YELLOW}Please install the Flutter SDK before running this setup:${NC}"
    echo -e "  - macOS: brew install --cask flutter OR visit https://docs.flutter.dev/get-started/install/macos"
    echo -e "  - Linux: snap install flutter --classic OR visit https://docs.flutter.dev/get-started/install/linux"
    echo ""
    echo -e "If Flutter is already installed in a custom directory, add it to your PATH:"
    echo -e "  export PATH=\"\$HOME/development/flutter/bin:\$PATH\""
    exit 1
fi

echo -e "${GREEN}[1/3] Checking Flutter environment...${NC}"
flutter --version

echo ""
echo -e "${GREEN}[2/3] Fetching Flutter dependencies (flutter pub get)...${NC}"
flutter pub get

echo ""
echo -e "${GREEN}[3/3] Setup complete!${NC}"
echo ""
echo -e "${CYAN}===================================================${NC}"
echo -e "${CYAN}  How to run COS HUB:                              ${NC}"
echo -e "${CYAN}===================================================${NC}"
echo -e "  - Web (Chrome):"
echo -e "      flutter run -d chrome --web-port=4200"
echo ""

# Detect OS
OS_TYPE="$(uname -s)"
if [ "$OS_TYPE" = "Darwin" ]; then
    echo -e "  - macOS Desktop App:"
    echo -e "      flutter run -d macos"
elif [ "$OS_TYPE" = "Linux" ]; then
    echo -e "  - Linux Desktop App:"
    echo -e "      flutter run -d linux"
fi

echo ""
echo -e "  - Share over Internet with ngrok:"
echo -e "      ngrok http 4200 --url renewed-oriole-exotic.ngrok-free.app"
echo -e "${CYAN}===================================================${NC}"
echo ""
