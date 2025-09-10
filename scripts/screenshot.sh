#!/bin/bash
# ===========================================
# SCREENSHOT SCRIPT FOR HYPRLAND
# ===========================================

# Renk kodları
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Создать каталог для скриншотов
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

# Дата и время
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

# Функции скриншотов
screenshot_area() {
    print_status "Выбор области..."
    grimblast copy area "$SCREENSHOT_DIR/screenshot_${TIMESTAMP}.png"
    print_success "Скриншот сделан: $SCREENSHOT_DIR/screenshot_${TIMESTAMP}.png"
}

screenshot_screen() {
    print_status "Создание скриншота экрана..."
    grimblast copy screen "$SCREENSHOT_DIR/screenshot_${TIMESTAMP}.png"
    print_success "Скриншот сделан: $SCREENSHOT_DIR/screenshot_${TIMESTAMP}.png"
}

screenshot_window() {
    print_status "Создание скриншота окна..."
    grimblast copy active "$SCREENSHOT_DIR/screenshot_${TIMESTAMP}.png"
    print_success "Скриншот сделан: $SCREENSHOT_DIR/screenshot_${TIMESTAMP}.png"
}

# Основная функция
main() {
    case "${1:-area}" in
        "area")
            screenshot_area
            ;;
        "screen")
            screenshot_screen
            ;;
        "window")
            screenshot_window
            ;;
        *)
            echo "Использование: $0 [area|screen|window]"
            echo "  area   - Выбор области (по умолчанию)"
            echo "  screen - Весь экран"
            echo "  window - Активное окно"
            exit 1
            ;;
    esac
}

main "$@"
