# 🚀 Профессиональные Dotfiles для Hyprland

Этот репозиторий содержит оптимизированную профессиональную конфигурацию Hyprland dotfiles для Arch Linux. Предоставляет современный, быстрый и настраиваемый опыт работы с Wayland композитором.

## ✨ Особенности

- **Современная конфигурация Hyprland**: Оптимизированная производительность и красивые анимации
- **Профессиональный Waybar**: Системная информация, рабочие пространства и медиа-контролы
- **Rofi Launcher**: Быстрый запуск приложений и переключение окон
- **Kitty Terminal**: Быстрый и настраиваемый терминальный эмулятор
- **Конфигурация Neovim**: Современный редактор с поддержкой LSP
- **Zsh + Oh My Zsh**: Мощный опыт работы с оболочкой и плагинами
- **Swaylock + Wlogout**: Безопасная блокировка экрана и меню выхода
- **Hyprpaper**: Менеджер обоев
- **Поддержка GTK тем**: Интеграция с темой Catppuccin
- **Оптимизация шрифтов**: JetBrains Mono и Nerd Fonts
- **Поддержка множественных тем**: Catppuccin, Dracula и Nord
- **Комплексная установка**: Полная установка одной командой
- **Инструменты скриншотов**: Простое создание скриншотов
- **Поддержка русской раскладки**: Полная конфигурация русской клавиатуры

## 🛠️ Требования

- Arch Linux (или Arch-основанные дистрибутивы)
- Hyprland
- Waybar
- Rofi
- Kitty
- Swaylock
- Grimblast
- wl-clipboard
- Hyprpaper
- polkit-gnome
- brightnessctl
- pavucontrol
- thunar

## 📦 Установка

### Автоматическая установка

```bash
# Клонируйте репозиторий
git clone https://github.com/daghlar/dotfilesru.git
cd dotfilesru

# Запустите комплексный скрипт установки
./scripts/setup.sh

# Или для быстрой установки
./scripts/install.sh
```

### Ручная установка

```bash
# Установите необходимые пакеты
sudo pacman -S hyprland waybar rofi kitty swaylock grimblast wl-clipboard hyprpaper polkit-gnome brightnessctl pavucontrol thunar

# Скопируйте конфигурационные файлы
cp -r .config/* ~/.config/
cp scripts/* ~/.local/bin/
chmod +x ~/.local/bin/*

# Запустите Hyprland
Hyprland
```

## 🎨 Темы

### Доступные темы

- **Catppuccin**: Пастельные цвета и современный вид
- **Dracula**: Темная тема с яркими цветами
- **Nord**: Минималистичный и профессиональный вид

### Применение темы

```bash
# Применить тему
./themes/apply_theme.sh catppuccin
./themes/apply_theme.sh dracula
./themes/apply_theme.sh nord

# Показать доступные темы
./themes/apply_theme.sh list
```

## ⌨️ Горячие клавиши

### Основные сочетания

| Сочетание | Описание |
|-----------|----------|
| `Super + Q` | Открыть терминал |
| `Super + C` | Закрыть активное окно |
| `Super + M` | Выйти из Hyprland |
| `Super + E` | Открыть файловый менеджер |
| `Super + V` | Переключить плавающее окно |
| `Super + R` | Открыть Rofi launcher |
| `Super + L` | Заблокировать экран |

### Управление окнами

| Сочетание | Описание |
|-----------|----------|
| `Super + ←/→/↑/↓` | Переместить фокус окна |
| `Super + Shift + ←/→/↑/↓` | Переместить окно |
| `Super + Ctrl + ←/→/↑/↓` | Изменить размер окна |
| `Super + F` | Полноэкранный режим |
| `Super + Shift + F` | Переключить плавающее окно |

### Рабочие пространства

| Сочетание | Описание |
|-----------|----------|
| `Super + 1-10` | Переключиться на рабочее пространство |
| `Super + Shift + 1-10` | Переместить окно на рабочее пространство |
| `Super + S` | Переключить специальное рабочее пространство |

### Медиа-контролы

| Сочетание | Описание |
|-----------|----------|
| `XF86AudioRaiseVolume` | Увеличить громкость |
| `XF86AudioLowerVolume` | Уменьшить громкость |
| `XF86AudioMute` | Включить/выключить звук |
| `XF86MonBrightnessUp` | Увеличить яркость |
| `XF86MonBrightnessDown` | Уменьшить яркость |

### Скриншоты

| Сочетание | Описание |
|-----------|----------|
| `Super + Print` | Скриншот области |
| `Super + Shift + Print` | Скриншот всего экрана |
| `Super + Ctrl + Print` | Сохранить скриншот |

## 🔧 Конфигурация

### Основные конфигурационные файлы

- `~/.config/hypr/hyprland.conf` - Основная конфигурация Hyprland
- `~/.config/waybar/config` - Конфигурация Waybar
- `~/.config/waybar/style.css` - Стили Waybar
- `~/.config/rofi/config.rasi` - Конфигурация Rofi
- `~/.config/kitty/kitty.conf` - Конфигурация Kitty терминала

### Настройка

Редактируя конфигурационные файлы, вы можете:
- Изменить цветовые схемы
- Настроить горячие клавиши
- Настроить правила окон
- Изменить анимации

## 📁 Структура каталогов

```
dotfilesru/
├── .config/
│   ├── hypr/
│   │   └── hyprland.conf
│   ├── waybar/
│   │   ├── config
│   │   └── style.css
│   ├── rofi/
│   │   └── config.rasi
│   ├── kitty/
│   │   └── kitty.conf
│   ├── nvim/
│   │   └── init.lua
│   ├── swaylock/
│   │   └── config
│   ├── wlogout/
│   │   ├── layout
│   │   └── style.css
│   ├── hyprpaper/
│   │   └── hyprpaper.conf
│   ├── gtk-3.0/
│   │   └── settings.ini
│   ├── gtk-4.0/
│   │   └── settings.ini
│   └── fontconfig/
│       └── fonts.conf
├── scripts/
│   ├── setup.sh
│   ├── install.sh
│   ├── update.sh
│   └── screenshot.sh
├── themes/
│   ├── catppuccin.conf
│   ├── dracula.conf
│   ├── nord.conf
│   └── apply_theme.sh
├── .bashrc
├── .zshrc
├── .gitconfig
├── .inputrc
├── .gitignore_global
├── README.md
├── INSTALL.md
└── SUMMARY.md
```

## 🚀 Обновление

```bash
# Обновить конфигурации
./scripts/update.sh
```

## 🐛 Устранение неполадок

### Частые проблемы

1. **Waybar не отображается**
   ```bash
   pkill waybar && waybar &
   ```

2. **Rofi не открывается**
   ```bash
   rofi -show drun
   ```

3. **Скриншоты не работают**
   ```bash
   sudo pacman -S grimblast
   ```

4. **Контролы звука не работают**
   ```bash
   sudo pacman -S pavucontrol
   ```

### Файлы логов

```bash
# Логи Hyprland
journalctl -u Hyprland

# Логи Waybar
waybar --log-level debug
```

## 🤝 Вклад в проект

1. Сделайте форк
2. Создайте ветку функции (`git checkout -b feature/amazing-feature`)
3. Сделайте коммит (`git commit -m 'Add amazing feature'`)
4. Отправьте изменения (`git push origin feature/amazing-feature`)
5. Создайте Pull Request

## 📄 Лицензия

Этот проект лицензирован под лицензией MIT. Подробности см. в файле `LICENSE`.

## 🙏 Благодарности

- [Hyprland](https://hyprland.org/) - Wayland композитор
- [Waybar](https://github.com/Alexays/Waybar) - Панель состояния
- [Rofi](https://github.com/davatorium/rofi) - Запускатель приложений
- [Kitty](https://sw.kovidgoyal.net/kitty/) - Терминальный эмулятор

## 📞 Контакты

Для вопросов создайте issue или отправьте pull request.

---

**Примечание**: Эта конфигурация оптимизирована для Arch Linux. В других дистрибутивах некоторые настройки могут отличаться.