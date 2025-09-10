#!/bin/bash
# ===========================================
# КОМПЛЕКСНЫЙ СКРИПТ НАСТРОЙКИ DOTFILES
# ===========================================

set -e

# Цветовые коды
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

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

# Проверить и установить необходимые пакеты
install_dependencies() {
    print_status "Проверка необходимых пакетов..."
    
    local packages=(
        "hyprland"
        "waybar"
        "rofi"
        "kitty"
        "swaylock"
        "wlogout"
        "grimblast"
        "wl-clipboard"
        "hyprpaper"
        "polkit-gnome"
        "brightnessctl"
        "pavucontrol"
        "thunar"
        "neovim"
        "zsh"
        "oh-my-zsh"
        "powerlevel10k"
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
        "zsh-completions"
        "fontconfig"
        "noto-fonts"
        "noto-fonts-emoji"
        "ttf-jetbrains-mono"
        "ttf-font-awesome"
        "papirus-icon-theme"
        "catppuccin-gtk-theme-mocha"
        "catppuccin-cursors-mocha"
        "firefox"
        "chromium"
        "mpv"
        "vlc"
        "htop"
        "btop"
        "neofetch"
        "git"
        "curl"
        "wget"
        "unzip"
        "zip"
        "tree"
        "rsync"
        "fzf"
        "ripgrep"
        "fd"
        "bat"
        "exa"
        "delta"
        "lazygit"
        "github-cli"
    )
    
    local missing_packages=()
    
    for package in "${packages[@]}"; do
        if ! pacman -Qi "$package" &>/dev/null; then
            missing_packages+=("$package")
        fi
    done
    
    if [ ${#missing_packages[@]} -ne 0 ]; then
        print_warning "Eksik paketler bulundu: ${missing_packages[*]}"
        print_status "Paketler yükleniyor..."
        sudo pacman -S --needed "${missing_packages[@]}"
    else
        print_success "Tüm gerekli paketler yüklü!"
    fi
}

# Konfigürasyon dosyalarını kopyala
install_configs() {
    print_status "Konfigürasyon dosyaları kopyalanıyor..."
    
    # Ana dizinleri oluştur
    mkdir -p ~/.config/{hypr,waybar,rofi,kitty,swaylock,wlogout,wofi,gtk-3.0,gtk-4.0,fontconfig,hyprpaper,nvim}
    mkdir -p ~/.local/share/{fonts,applications}
    mkdir -p ~/Pictures/Wallpapers
    mkdir -p ~/.oh-my-zsh/custom/themes
    mkdir -p ~/.oh-my-zsh/custom/plugins
    
    # Konfigürasyon dosyalarını kopyala
    cp -r .config/* ~/.config/
    cp .bashrc ~/
    cp .zshrc ~/
    cp .gitconfig ~/
    cp .inputrc ~/
    cp .gitignore_global ~/
    
    # Script dosyalarını kopyala
    cp scripts/* ~/.local/bin/
    chmod +x ~/.local/bin/*
    
    print_success "Konfigürasyon dosyaları kopyalandı!"
}

# Fontları yükle
install_fonts() {
    print_status "Fontlar yükleniyor..."
    
    # Nerd Fonts
    if [ ! -d ~/.local/share/fonts/NerdFonts ]; then
        mkdir -p ~/.local/share/fonts/NerdFonts
        cd ~/.local/share/fonts/NerdFonts
        curl -fLo "JetBrains Mono Nerd Font Complete.ttf" \
            "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Regular/complete/JetBrains%20Mono%20Nerd%20Font%20Complete.ttf"
        cd - > /dev/null
    fi
    
    # Font cache'i yenile
    fc-cache -fv
    
    print_success "Fontlar yüklendi!"
}

# Oh My Zsh kurulumu
install_oh_my_zsh() {
    print_status "Oh My Zsh kuruluyor..."
    
    if [ ! -d ~/.oh-my-zsh ]; then
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    
    # Powerlevel10k temasını yükle
    if [ ! -d ~/.oh-my-zsh/custom/themes/powerlevel10k ]; then
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
    fi
    
    # Zsh eklentilerini yükle
    if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]; then
        git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
    fi
    
    if [ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
    fi
    
    print_success "Oh My Zsh kuruldu!"
}

# Neovim eklentilerini yükle
install_neovim_plugins() {
    print_status "Neovim eklentileri yükleniyor..."
    
    if command -v nvim &> /dev/null; then
        nvim --headless -c 'autocmd User LazyDone quitall' -c 'Lazy sync'
        print_success "Neovim eklentileri yüklendi!"
    else
        print_warning "Neovim bulunamadı, eklentiler yüklenemedi."
    fi
}

# Servisleri etkinleştir
enable_services() {
    print_status "Servisler etkinleştiriliyor..."
    
    # libvirt servisini etkinleştir (eğer yüklüyse)
    if systemctl list-unit-files | grep -q libvirtd; then
        sudo systemctl enable --now libvirtd
        sudo usermod -a -G libvirt $USER
    fi
    
    print_success "Servisler etkinleştirildi!"
}

# Wallpaper indir
download_wallpapers() {
    print_status "Wallpaper'lar indiriliyor..."
    
    cd ~/Pictures/Wallpapers
    
    # Örnek wallpaper'lar indir
    if [ ! -f default.jpg ]; then
        curl -L "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=1920&h=1080&fit=crop" -o default.jpg
    fi
    
    if [ ! -f catppuccin.jpg ]; then
        curl -L "https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=1920&h=1080&fit=crop" -o catppuccin.jpg
    fi
    
    if [ ! -f dracula.jpg ]; then
        curl -L "https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=1920&h=1080&fit=crop" -o dracula.jpg
    fi
    
    if [ ! -f nord.jpg ]; then
        curl -L "https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=1920&h=1080&fit=crop" -o nord.jpg
    fi
    
    cd - > /dev/null
    
    print_success "Wallpaper'lar indirildi!"
}

# Ana kurulum fonksiyonu
main() {
    echo "==========================================="
    echo "    PROFESSIONAL DOTFILES SETUP"
    echo "==========================================="
    echo
    
    install_dependencies
    install_configs
    install_fonts
    install_oh_my_zsh
    install_neovim_plugins
    enable_services
    download_wallpapers
    
    echo
    echo "==========================================="
    print_success "Kurulum tamamlandı!"
    echo "==========================================="
    echo
    echo "Sonraki adımlar:"
    echo "1. Sistemi yeniden başlatın"
    echo "2. Zsh'i varsayılan shell yapın: chsh -s /bin/zsh"
    echo "3. Hyprland'i başlatın"
    echo "4. P10k konfigürasyonu yapın: p10k configure"
    echo
    print_warning "Sistemi yeniden başlatmanız önerilir."
}

# Scripti çalıştır
main "$@"
