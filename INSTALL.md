# 📋 Подробное руководство по установке

Это руководство содержит пошаговые инструкции для установки профессиональных Dotfiles для Hyprland на вашу систему.

## 🔍 Системные требования

### Минимальные требования
- **Процессор**: архитектура x86_64
- **ОЗУ**: минимум 4GB (рекомендуется 8GB)
- **Хранилище**: минимум 10GB свободного места
- **Графика**: GPU с поддержкой Wayland

### Поддерживаемые дистрибутивы
- ✅ Arch Linux
- ✅ Manjaro
- ✅ EndeavourOS
- ⚠️ Ubuntu (требуется ручная установка)
- ⚠️ Fedora (требуется ручная установка)

## 📦 Установка пакетов

### 1. Базовые пакеты

```bash
# Установите AUR helper (рекомендуется yay)
sudo pacman -S --needed base-devel git
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```

### 2. Hyprland и зависимости

```bash
# Основные пакеты
sudo pacman -S hyprland waybar rofi kitty swaylock grimblast wl-clipboard hyprpaper polkit-gnome brightnessctl pavucontrol thunar

# AUR пакеты
yay -S grimblast-git
```

### 3. Дополнительные пакеты (опционально)

```bash
# Медиа-плееры
sudo pacman -S mpv vlc

# Инструменты разработки
sudo pacman -S code firefox chromium

# Шрифты
sudo pacman -S ttf-jetbrains-mono ttf-font-awesome papirus-icon-theme

# Дополнительные инструменты
sudo pacman -S neofetch htop btop
```

## 🚀 Шаги установки

### 1. Скачайте репозиторий

```bash
# Клонируйте через Git
git clone https://github.com/daghlar/dotfilesru.git ~/dotfiles
cd ~/dotfiles

# Или скачайте вручную
wget https://github.com/daghlar/dotfilesru/archive/main.zip
unzip main.zip
cd dotfilesru-main
```

### 2. Автоматическая установка

```bash
# Запустите скрипт установки
./scripts/setup.sh
```

### 3. Ручная установка

Если автоматическая установка не работает:

```bash
# Создайте конфигурационные каталоги
mkdir -p ~/.config/{hypr,waybar,rofi,kitty,swaylock,wofi,gtk-3.0,gtk-4.0}

# Скопируйте конфигурационные файлы
cp -r .config/* ~/.config/

# Скопируйте скрипты
mkdir -p ~/.local/bin
cp scripts/* ~/.local/bin/
chmod +x ~/.local/bin/*

# Создайте каталог для обоев
mkdir -p ~/Pictures/Wallpapers
```

## ⚙️ Системные настройки

### 1. Настройки дисплей-менеджера

#### Для SDDM:
```bash
# Установите SDDM
sudo pacman -S sddm

# Сделайте Hyprland сессией по умолчанию
echo "[Desktop Entry]
Name=Hyprland
Comment=Hyprland Wayland Compositor
Exec=Hyprland
Type=Application" | sudo tee /usr/share/xsessions/hyprland.desktop

# Включите SDDM
sudo systemctl enable sddm
```

#### Для GDM:
```bash
# Установите GDM
sudo pacman -S gdm

# Включите GDM
sudo systemctl enable gdm
```

### 2. Настройки Polkit

```bash
# Включите Polkit agent
echo "exec /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1" >> ~/.config/hypr/hyprland.conf
```

### 3. Настройки шрифтов

```bash
# Обновите кэш шрифтов
fc-cache -fv

# Проверьте шрифты
fc-list | grep -i jetbrains
```

## 🎨 Установка тем

### 1. Применение темы

```bash
# Применить тему Catppuccin
./themes/apply_theme.sh catppuccin

# Применить тему Dracula
./themes/apply_theme.sh dracula

# Применить тему Nord
./themes/apply_theme.sh nord
```

### 2. Создание пользовательской темы

```bash
# Создайте файл темы
cp themes/catppuccin.conf themes/my_theme.conf

# Отредактируйте файл темы
nano themes/my_theme.conf

# Примените тему
./themes/apply_theme.sh my_theme
```

## 🔧 Устранение неполадок

### Частые проблемы

#### 1. Hyprland не запускается

```bash
# Проверьте логи
journalctl -u Hyprland

# Протестируйте конфигурацию
hyprctl reload
```

#### 2. Waybar не отображается

```bash
# Запустите Waybar вручную
waybar &

# Проверьте логи
waybar --log-level debug
```

#### 3. Rofi не работает

```bash
# Протестируйте Rofi
rofi -show drun

# Проверьте конфигурацию
rofi -dump-config
```

#### 4. Скриншоты не работают

```bash
# Протестируйте Grimblast
grimblast copy area

# Установите необходимые пакеты
sudo pacman -S grimblast
```

### Файлы логов

```bash
# Логи Hyprland
journalctl -u Hyprland -f

# Логи Waybar
waybar --log-level debug

# Системные логи
journalctl -f
```

## 🚀 Первый запуск

### 1. Запустите Hyprland

```bash
# Через дисплей-менеджер
# Перезагрузите систему или выйдите из сессии

# Ручной запуск
Hyprland
```

### 2. Базовые тесты

```bash
# Откройте терминал (Super + Q)
# Откройте Rofi (Super + R)
# Протестируйте управление окнами
# Сделайте скриншот (Super + Print)
```

### 3. Настройки производительности

```bash
# Настройки GPU
nvidia-settings  # для NVIDIA
# или
intel_gpu_top    # для Intel

# Использование памяти
htop
```

## 📱 Мобильные устройства

### Поддержка планшетов

```bash
# Пакеты для планшетов
sudo pacman -S xf86-input-wacom

# Конфигурация
cat > ~/.config/hypr/tablet.conf << EOF
# Настройки планшета
input {
    tablet {
        output = DP-1
        region_position = 0,0
        region_size = 1920,1080
    }
}
EOF
```

## 🔒 Безопасность

### 1. Блокировка экрана

```bash
# Протестируйте Swaylock
swaylock

# Автоматические настройки блокировки
swayidle -w timeout 300 'swaylock' timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
```

### 2. Файрвол

```bash
# Установите UFW
sudo pacman -S ufw

# Включите файрвол
sudo ufw enable
```

## 📊 Оптимизация производительности

### 1. Настройки GPU

```bash
# Для NVIDIA
nvidia-settings

# Для Intel
sudo pacman -S intel-gpu-tools
```

### 2. Оптимизация памяти

```bash
# Настройки swap
sudo swapon --show

# Использование памяти
free -h
```

## 🎯 Следующие шаги

1. **Настройка**: Отредактируйте конфигурационные файлы под ваши нужды
2. **Расширения**: Установите дополнительные приложения и расширения
3. **Резервное копирование**: Создайте резервные копии ваших конфигураций
4. **Обновления**: Регулярно проверяйте обновления

## 📞 Помощь

- **GitHub Issues**: Сообщите о проблемах
- **Discord**: Поддержка сообщества
- **Wiki**: Подробная документация

---

**Примечание**: Это руководство постоянно обновляется. Для получения самой актуальной информации проверьте GitHub репозиторий.