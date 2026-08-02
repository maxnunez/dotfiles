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

echo ""
echo "✅ Paquetes restaurados."
echo "   Recordá: algunos repos (VSCodium, Brave, etc.) se configuran en install.sh"
