#!/bin/bash
# ===========================================
# СКРИПТ ПРИМЕНЕНИЯ ТЕМ
# ===========================================

set -e

# Цветовые коды
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

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Функция применения темы
apply_theme() {
    local theme_name="$1"
    local theme_file="themes/${theme_name}.conf"
    
    if [ ! -f "$theme_file" ]; then
        print_error "Файл темы не найден: $theme_file"
        exit 1
    fi
    
    print_status "Применение темы $theme_name..."
    
    # Загрузить файл темы как источник
    source "$theme_file"
    
    # Обновить конфигурацию Hyprland
    if [ -f ~/.config/hypr/hyprland.conf ]; then
        # Создать резервную копию текущей конфигурации
        cp ~/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf.backup
        
        # Обновить цвета
        sed -i "s/col\.active_border = .*/col.active_border = $col_active_border/" ~/.config/hypr/hyprland.conf
        sed -i "s/col\.inactive_border = .*/col.inactive_border = $col_inactive_border/" ~/.config/hypr/hyprland.conf
        
        print_success "Конфигурация Hyprland обновлена!"
    fi
    
    # Обновить конфигурацию Waybar
    if [ -f ~/.config/waybar/style.css ]; then
        # Создать резервную копию текущего CSS
        cp ~/.config/waybar/style.css ~/.config/waybar/style.css.backup
        
        # Обновить цвета
        sed -i "s/background: .*/background: $waybar_bg;/" ~/.config/waybar/style.css
        sed -i "s/color: .*/color: $waybar_fg;/" ~/.config/waybar/style.css
        
        print_success "Конфигурация Waybar обновлена!"
    fi
    
    # Перезагрузить Hyprland
    if pgrep -x "Hyprland" > /dev/null; then
        hyprctl reload
        print_success "Hyprland перезагружен!"
    fi
    
    print_success "Тема $theme_name успешно применена!"
}

# Список доступных тем
list_themes() {
    echo "Доступные темы:"
    for theme in themes/*.conf; do
        if [ -f "$theme" ]; then
            echo "  - $(basename "$theme" .conf)"
        fi
    done
}

# Основная функция
main() {
    case "${1:-help}" in
        "catppuccin"|"dracula"|"nord")
            apply_theme "$1"
            ;;
        "list")
            list_themes
            ;;
        "help"|*)
            echo "Использование: $0 [имя_темы|list|help]"
            echo
            echo "Команды:"
            echo "  catppuccin  - Применить тему Catppuccin"
            echo "  dracula     - Применить тему Dracula"
            echo "  nord        - Применить тему Nord"
            echo "  list        - Показать доступные темы"
            echo "  help        - Показать это сообщение помощи"
            echo
            list_themes
            ;;
    esac
}

main "$@"
