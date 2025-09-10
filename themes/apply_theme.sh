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

# Tema uygulama fonksiyonu
apply_theme() {
    local theme_name="$1"
    local theme_file="themes/${theme_name}.conf"
    
    if [ ! -f "$theme_file" ]; then
        print_error "Файл темы не найден: $theme_file"
        exit 1
    fi
    
    print_status "Применение темы $theme_name..."
    
    # Tema dosyasını kaynak olarak yükle
    source "$theme_file"
    
    # Hyprland konfigürasyonunu güncelle
    if [ -f ~/.config/hypr/hyprland.conf ]; then
        # Mevcut konfigürasyonu yedekle
        cp ~/.config/hypr/hyprland.conf ~/.config/hypr/hyprland.conf.backup
        
        # Renkleri güncelle
        sed -i "s/col\.active_border = .*/col.active_border = $col_active_border/" ~/.config/hypr/hyprland.conf
        sed -i "s/col\.inactive_border = .*/col.inactive_border = $col_inactive_border/" ~/.config/hypr/hyprland.conf
        
        print_success "Hyprland konfigürasyonu güncellendi!"
    fi
    
    # Waybar konfigürasyonunu güncelle
    if [ -f ~/.config/waybar/style.css ]; then
        # Mevcut CSS'i yedekle
        cp ~/.config/waybar/style.css ~/.config/waybar/style.css.backup
        
        # Renkleri güncelle
        sed -i "s/background: .*/background: $waybar_bg;/" ~/.config/waybar/style.css
        sed -i "s/color: .*/color: $waybar_fg;/" ~/.config/waybar/style.css
        
        print_success "Waybar konfigürasyonu güncellendi!"
    fi
    
    # Hyprland'i yeniden yükle
    if pgrep -x "Hyprland" > /dev/null; then
        hyprctl reload
        print_success "Hyprland yeniden yüklendi!"
    fi
    
    print_success "$theme_name teması başarıyla uygulandı!"
}

# Mevcut temaları listele
list_themes() {
    echo "Mevcut temalar:"
    for theme in themes/*.conf; do
        if [ -f "$theme" ]; then
            echo "  - $(basename "$theme" .conf)"
        fi
    done
}

# Ana fonksiyon
main() {
    case "${1:-help}" in
        "catppuccin"|"dracula"|"nord")
            apply_theme "$1"
            ;;
        "list")
            list_themes
            ;;
        "help"|*)
            echo "Kullanım: $0 [tema_adi|list|help]"
            echo
            echo "Komutlar:"
            echo "  catppuccin  - Catppuccin temasını uygula"
            echo "  dracula     - Dracula temasını uygula"
            echo "  nord        - Nord temasını uygula"
            echo "  list        - Mevcut temaları listele"
            echo "  help        - Bu yardım mesajını göster"
            echo
            list_themes
            ;;
    esac
}

main "$@"
