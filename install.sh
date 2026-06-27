#!/usr/bin/env bash
set -euo pipefail

# ═══════════════════════════════════════════════════════
#  dotfiles — bootstrap para máquina nueva
#  Uso: chmod +x install.sh && ./install.sh
# ═══════════════════════════════════════════════════════

DOTFILES="$HOME/dotfiles"

echo "╔══════════════════════════════════════════════════╗"
echo "║     dotfiles — bootstrap                         ║"
echo "╚══════════════════════════════════════════════════╝"

# ─── Paquetes esenciales ──────────────────────────────
echo ""
echo "📦 Instalando paquetes del sistema..."

ESSENTIAL_PKGS=(
  # WM
  i3-wm i3lock i3status xss-lock
  # Terminal
  kitty
  # Barra y launcher
  polybar rofi
  # Notificaciones
  dunst
  # Screenshots / clipboard
  flameshot copyq
  # Wallpaper
  feh
  # Multimedia
  pavucontrol volumeicon brightnessctl playerctl vlc
  # Sistema
  btop jq eza bat fd-find ripgrep
  # Archivos
  thunar thunar-volman tumbler atril file-roller
  # Power management
  xfce4-power-manager
  # Otros
  firefox-esr
)

sudo apt update
sudo apt install -y "${ESSENTIAL_PKGS[@]}"
sudo apt autoremove -y

# ─── Toolchains ────────────────────────────────────────
echo ""
echo "🔧 Instalando toolchains..."

# Homebrew
if ! command -v brew &>/dev/null; then
  echo "Instalando Homebrew..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Atuin, Zoxide, Fzf, Neovim, LazyGit, Zellij via brew
brew install atuin zoxide fzf neovim lazygit zellij

# opencode
if ! command -v opencode &>/dev/null; then
  echo "Instalando opencode..."
  curl -fsSL https://opencode.ai/install.sh | sh
fi

# Ollama (modelos locales)
if ! command -v ollama &>/dev/null; then
  echo "Instalando Ollama..."
  curl -fsSL https://ollama.com/install.sh | sh
fi

# Node via Volta
if ! command -v volta &>/dev/null; then
  echo "Instalando Volta..."
  curl -fsSL https://get.volta.sh | bash
  volta install node
fi

# ─── Copiar configs ──────────────────────────────────
echo ""
echo "🔗 Copiando configuraciones..."

ln -sf "$DOTFILES/zsh/.zshrc"         "$HOME/.zshrc"
ln -sf "$DOTFILES/zsh/.p10k.zsh"      "$HOME/.p10k.zsh" 2>/dev/null || true
ln -sf "$DOTFILES/git/.gitconfig"     "$HOME/.gitconfig"
ln -sf "$DOTFILES/AGENTS.md"          "$HOME/AGENTS.md"
ln -sf "$DOTFILES/SOUL.md"            "$HOME/SOUL.md"

mkdir -p "$HOME/.config"
for dir in i3 kitty polybar picom dunst opencode nvim; do
  target="$HOME/.config/$dir"
  mkdir -p "$target"
  # Remove old files but keep dir
  rm -f "$target"/* 2>/dev/null || true
  cp -r "$DOTFILES/$dir"/* "$target/"
done

# ─── Zsh plugins ─────────────────────────────────────
echo ""
echo "🔌 Instalando plugins de zsh..."

# Oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

BREW_PREFIX="$(brew --prefix)"

# Zsh plugins via Homebrew
brew install zsh-autocomplete zsh-syntax-highlighting zsh-autosuggestions powerlevel10k

# ─── Nerd Font ───────────────────────────────────────
echo ""
echo "🖌 Instalando IosevkaTerm Nerd Font..."
brew install --cask font-iosevterm-nerd-font 2>/dev/null || \
  brew install font-iosevka-term-nerd-font 2>/dev/null || true

# ─── Servicios ────────────────────────────────────────
echo ""
echo "⚙️  Configurando servicios..."
systemctl --user enable --now dunst 2>/dev/null || true

# ─── Final ────────────────────────────────────────────
echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║  ✅ Listo! Reiniciá la sesión para aplicar todo. ║"
echo "║                                                  ║"
echo "║  i3:    Mod+Shift+r (reinicia i3)                ║"
echo "║  Zsh:   exec zsh                                 ║"
echo "║                                                  ║"
echo "║  Atajos: ~/dotfiles/docs-atajos/                ║"
echo "╚══════════════════════════════════════════════════╝"
