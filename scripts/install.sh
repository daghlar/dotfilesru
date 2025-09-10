#!/bin/bash
# ===========================================
# СКРИПТ УСТАНОВКИ HYPRLAND DOTFILES
# ===========================================

set -e

echo "🚀 Запуск установки Hyprland Dotfiles..."

# Цветовые коды
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Функции
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Проверить необходимые пакеты
check_dependencies() {
    print_status "Проверка необходимых пакетов..."
    
    local packages=(
        "hyprland"
        "waybar"
        "rofi"
        "kitty"
        "swaylock"
        "grimblast"
        "wl-clipboard"
        "hyprpaper"
        "polkit-gnome"
        "brightnessctl"
        "pavucontrol"
        "thunar"
    )
    
    local missing_packages=()
    
    for package in "${packages[@]}"; do
        if ! pacman -Qi "$package" &>/dev/null; then
            missing_packages+=("$package")
        fi
    done
    
    if [ ${#missing_packages[@]} -ne 0 ]; then
        print_warning "Найдены отсутствующие пакеты: ${missing_packages[*]}"
        print_status "Установка пакетов..."
        sudo pacman -S --needed "${missing_packages[@]}"
    else
        print_success "Все необходимые пакеты установлены!"
    fi
}

# Копировать конфигурационные файлы
install_configs() {
    print_status "Копирование конфигурационных файлов..."
    
    # Создать основные каталоги
    mkdir -p ~/.config/{hypr,waybar,rofi,kitty,swaylock,wofi,gtk-3.0,gtk-4.0}
    
    # Копировать конфигурационные файлы
    cp -r .config/* ~/.config/
    
    # Копировать скрипты
    mkdir -p ~/.local/bin
    cp scripts/* ~/.local/bin/
    chmod +x ~/.local/bin/*
    
    print_success "Конфигурационные файлы скопированы!"
}

# Настроить обои
setup_wallpaper() {
    print_status "Настройка обоев..."
    
    # Создать каталог для обоев
    mkdir -p ~/Pictures/Wallpapers
    
    # Скачать пример обоев (опционально)
    if [ ! -f ~/Pictures/Wallpapers/default.jpg ]; then
        print_status "Скачивание примера обоев..."
        curl -L "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=1920&h=1080&fit=crop" -o ~/Pictures/Wallpapers/default.jpg
    fi
    
    # Конфигурация Hyprpaper
    cat > ~/.config/hypr/hyprpaper.conf << EOF
preload = ~/Pictures/Wallpapers/default.jpg
wallpaper = DP-1,~/Pictures/Wallpapers/default.jpg
wallpaper = HDMI-A-1,~/Pictures/Wallpapers/default.jpg
EOF
    
    print_success "Обои настроены!"
}

# Настроить GTK тему
setup_gtk() {
    print_status "Настройка GTK темы..."
    
    # Настройки GTK-3.0
    cat > ~/.config/gtk-3.0/settings.ini << EOF
[Settings]
gtk-theme-name=Adwaita-dark
gtk-icon-theme-name=Papirus-Dark
gtk-font-name=JetBrains Mono 10
gtk-cursor-theme-name=Adwaita
gtk-toolbar-style=GTK_TOOLBAR_BOTH
gtk-toolbar-icon-size=GTK_ICON_SIZE_LARGE_TOOLBAR
gtk-button-images=1
gtk-menu-images=1
gtk-enable-event-sounds=1
gtk-enable-input-feedback-sounds=1
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintfull
EOF

    # Настройки GTK-4.0
    cat > ~/.config/gtk-4.0/settings.ini << EOF
[Settings]
gtk-theme-name=Adwaita-dark
gtk-icon-theme-name=Papirus-Dark
gtk-font-name=JetBrains Mono 10
gtk-cursor-theme-name=Adwaita
EOF
    
    print_success "GTK тема настроена!"
}

# Конфигурация Swaylock
setup_swaylock() {
    print_status "Настройка конфигурации Swaylock..."
    
    cat > ~/.config/swaylock/config << EOF
# Конфигурация Swaylock
daemonize
ignore-empty-password
show-failed-attempts
clock
screenshot
effect-blur=7x5
effect-vignette=0.5:0.5
color=1e1e2e
font=JetBrains Mono
indicator-radius=100
indicator-thickness=7
line-color=89b4fa
ring-color=6c7086
inside-color=1e1e2e
key-hl-color=89b4fa
separator-color=6c7086
text-color=cdd6f4
text-caps-lock-color=cdd6f4
inside-clear-color=1e1e2e
text-clear-color=cdd6f4
ring-clear-color=6c7086
inside-ver-color=1e1e2e
text-ver-color=cdd6f4
ring-ver-color=6c7086
inside-wrong-color=1e1e2e
text-wrong-color=cdd6f4
ring-wrong-color=f38ba8
EOF
    
    print_success "Конфигурация Swaylock настроена!"
}

# Основная функция установки
main() {
    echo "==========================================="
    echo "    ПРОФЕССИОНАЛЬНЫЕ DOTFILES HYPRLAND"
    echo "==========================================="
    echo
    
    check_dependencies
    install_configs
    setup_wallpaper
    setup_gtk
    setup_swaylock
    
    echo
    echo "==========================================="
    print_success "Установка завершена!"
    echo "==========================================="
    echo
    echo "Использование:"
    echo "  - Для запуска Hyprland: Hyprland"
    echo "  - Для перезагрузки конфигурации: hyprctl reload"
    echo "  - Для перезапуска Waybar: pkill waybar && waybar &"
    echo
    print_warning "Рекомендуется перезагрузить систему."
}

# Запустить скрипт
main "$@"
