#!/bin/bash
# ===========================================
# СКРИПТ ОБНОВЛЕНИЯ HYPRLAND DOTFILES
# ===========================================

set -e

echo "🔄 Обновление Hyprland Dotfiles..."

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

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Создать резервную копию
create_backup() {
    print_status "Создание резервной копии текущей конфигурации..."
    
    local backup_dir="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    
    if [ -d "$HOME/.config/hypr" ]; then
        cp -r "$HOME/.config/hypr" "$backup_dir/"
    fi
    if [ -d "$HOME/.config/waybar" ]; then
        cp -r "$HOME/.config/waybar" "$backup_dir/"
    fi
    if [ -d "$HOME/.config/rofi" ]; then
        cp -r "$HOME/.config/rofi" "$backup_dir/"
    fi
    if [ -d "$HOME/.config/kitty" ]; then
        cp -r "$HOME/.config/kitty" "$backup_dir/"
    fi
    
    print_success "Резервная копия создана: $backup_dir"
}

# Обновить конфигурации
update_configs() {
    print_status "Обновление конфигураций..."
    
    # Копировать новые конфигурации
    cp -r .config/* ~/.config/
    
    # Обновить скрипты
    cp scripts/* ~/.local/bin/
    chmod +x ~/.local/bin/*
    
    print_success "Конфигурации обновлены!"
}

# Перезагрузить Hyprland
reload_hyprland() {
    print_status "Перезагрузка Hyprland..."
    
    if pgrep -x "Hyprland" > /dev/null; then
        hyprctl reload
        print_success "Hyprland перезагружен!"
    else
        print_warning "Hyprland не запущен, запустите вручную."
    fi
}

# Основная функция обновления
main() {
    echo "==========================================="
    echo "    ОБНОВЛЕНИЕ HYPRLAND DOTFILES"
    echo "==========================================="
    echo
    
    create_backup
    update_configs
    reload_hyprland
    
    echo
    echo "==========================================="
    print_success "Обновление завершено!"
    echo "==========================================="
}

main "$@"
