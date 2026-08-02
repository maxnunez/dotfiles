#!/usr/bin/env bash
set -euo pipefail

# ═══════════════════════════════════════════════════════
#  restore-repos.sh — repositorios apt + VSCodium + extensiones
#  Uso: chmod +x restore-repos.sh && ./restore-repos.sh
# ═══════════════════════════════════════════════════════

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$SCRIPT_DIR/apt-repos"

echo "╔══════════════════════════════════════════════════╗"
echo "║     restore-repos — repos apt + VSCodium          ║"
echo "╚══════════════════════════════════════════════════╝"

# ─── Copiar keyrings ─────────────────────────────────
echo ""
echo "🔑 Instalando keyrings..."
sudo mkdir -p /usr/share/keyrings /etc/apt/keyrings
sudo cp "$REPO_DIR"/*.gpg /usr/share/keyrings/ 2>/dev/null || true
sudo cp "$REPO_DIR"/packages.mozilla.org.asc /etc/apt/keyrings/ 2>/dev/null || true

# ─── Copiar repos ────────────────────────────────────
echo ""
echo "📦 Configurando repositorios apt..."
for f in "$REPO_DIR"/*.list; do
  name="$(basename "$f")"
  sudo cp "$f" "/etc/apt/sources.list.d/$name"
  echo "  + $name"
done

sudo apt update

# ─── VSCodium: instalar extensiones ─────────────────
echo ""
echo "🛠  Configurando VSCodium..."
if ! command -v codium &>/dev/null; then
  echo "  ⚠️  codium no está instalado. Ejecutá restore-packages.sh primero o instalalo:"
  echo "      sudo apt install -y codium"
else
  # Settings
  mkdir -p "$HOME/.config/VSCodium/User"
  cp "$SCRIPT_DIR/../vscodium/settings.json" "$HOME/.config/VSCodium/User/settings.json"
  echo "  ✓ settings.json copiado"

  # Extensiones
  if [ -f "$SCRIPT_DIR/../vscodium/extensions.txt" ]; then
    echo "  📦 Instalando $(wc -l < "$SCRIPT_DIR/../vscodium/extensions.txt") extensiones..."
    while read -r ext; do
      [ -z "$ext" ] && continue
      codium --install-extension "$ext" 2>/dev/null || echo "  ⚠️  falló: $ext"
    done < "$SCRIPT_DIR/../vscodium/extensions.txt"
  fi
fi

echo ""
echo "✅ Repos y VSCodium configurados."
