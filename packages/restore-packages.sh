#!/usr/bin/env bash
set -euo pipefail

# ═══════════════════════════════════════════════════════
#  restore-packages.sh — restaura paquetes en máquina nueva
#  Uso: chmod +x restore-packages.sh && ./restore-packages.sh
# ═══════════════════════════════════════════════════════

echo "╔══════════════════════════════════════════════════╗"
echo "║     restore-packages — migración de paquetes     ║"
echo "╚══════════════════════════════════════════════════╝"

# ─── Paquetes apt instalados manualmente ──────────────
if [ -f "$(dirname "$0")/apt-manual.txt" ]; then
  echo ""
  echo "📦 Restaurando $(wc -l < "$(dirname "$0")/apt-manual.txt") paquetes apt..."
  xargs -a "$(dirname "$0")/apt-manual.txt" sudo apt install -y
else
  echo "⚠️  No se encontró apt-manual.txt"
fi

# ─── Apps Flatpak ─────────────────────────────────────
if [ -f "$(dirname "$0")/flatpak.txt" ]; then
  echo ""
  echo "📦 Restaurando apps Flatpak..."
  xargs -a "$(dirname "$0")/flatpak.txt" flatpak install -y flathub
fi

# ─── Paquetes Homebrew ────────────────────────────────
if [ -f "$(dirname "$0")/brew.txt" ] && command -v brew &>/dev/null; then
  echo ""
  echo "🍺 Restaurando $(wc -l < "$(dirname "$0")/brew.txt") paquetes Homebrew..."
  xargs -a "$(dirname "$0")/brew.txt" brew install -y
elif [ ! -f "$(dirname "$0")/brew.txt" ]; then
  echo "⚠️  No se encontró brew.txt"
else
  echo "⚠️  brew no está instalado. Ejecutá install.sh primero (instala Homebrew)."
fi

# ─── Paquetes pip ─────────────────────────────────────
if [ -f "$(dirname "$0")/pip.txt" ]; then
  echo ""
  echo "🐍 Restaurando $(wc -l < "$(dirname "$0")/pip.txt") paquetes pip..."
  xargs -a "$(dirname "$0")/pip.txt" pip3 install -y
fi

echo ""
echo "✅ Paquetes restaurados."
echo "   Recordá: algunos repos (VSCodium, Brave, etc.) se configuran en restore-repos.sh"
