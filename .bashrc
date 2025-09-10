# ===========================================
# PROFESSIONAL BASH CONFIGURATION
# ===========================================

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ===========================================
# HISTORY CONFIGURATION
# ===========================================
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Append to history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# ===========================================
# SHELL OPTIONS
# ===========================================
# Check window size after each command
shopt -s checkwinsize

# Enable extended globbing
shopt -s extglob

# Enable case-insensitive globbing
shopt -s nocaseglob

# Enable recursive globbing
shopt -s globstar

# ===========================================
# PROMPT CONFIGURATION
# ===========================================
# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Git branch function
git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Professional prompt
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\[\033[01;33m\]$(git_branch)\[\033[00m\]\$ '

# ===========================================
# ALIASES
# ===========================================
# System aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# System information
alias df='df -h'
alias du='du -h'
alias free='free -h'
alias ps='ps aux'
alias top='htop'

# Git aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'
alias gd='git diff'
alias gb='git branch'
alias gco='git checkout'

# Package management
alias pacman='sudo pacman'
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias remove='sudo pacman -R'
alias search='pacman -Ss'

# Hyprland aliases
alias hypr='hyprctl'
alias hypr-reload='hyprctl reload'
alias hypr-kill='hyprctl kill'

# ===========================================
# FUNCTIONS
# ===========================================
# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract various archive formats
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar e "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Find and kill process
killp() {
    ps aux | grep "$1" | grep -v grep | awk '{print $2}' | xargs kill -9
}

# Быстрое резервное копирование
backup() {
    cp "$1" "$1.backup.$(date +%Y%m%d_%H%M%S)"
}

# ===========================================
# ENVIRONMENT VARIABLES
# ===========================================
export EDITOR='nvim'
export VISUAL='nvim'
export BROWSER='firefox'
export TERMINAL='kitty'

# PATH additions
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.go/bin:$PATH"

# ===========================================
# COMPLETION
# ===========================================
# Enable programmable completion
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# ===========================================
# WELCOME MESSAGE
# ===========================================
echo -e "${GREEN}Welcome to your professional Arch Linux system!${NC}"
echo -e "${BLUE}Hyprland dotfiles loaded successfully.${NC}"
echo -e "${YELLOW}Type 'help' for available commands.${NC}"
