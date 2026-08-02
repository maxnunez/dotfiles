# 🏠 dotfiles — maxnunez

Backup de configuración del sistema i3wm + Debian.

## Stack

| Capa | Herramienta |
|------|-------------|
| WM | i3-wm 4.24 |
| Terminal | Kitty + Zellij |
| Editor | Neovim 0.12.2 + LazyVim |
| Barra | Polybar |
| Launcher | Rofi |
| Notificaciones | Dunst |
| Screenshots | Flameshot |
| Clipboard | CopyQ |
| Shell | Zsh + Powerlevel10k + Atuin + Zoxide + Fzf |
| AI | opencode + Gentle AI + Ollama local |

## Estructura

```
dotfiles/
├── zsh/           → .zshrc, .p10k.zsh
├── git/           → .gitconfig
├── i3/            → config
├── kitty/         → kitty.conf
├── polybar/       → config.ini, launch.sh
├── picom/         → picom.conf
├── dunst/         → dunstrc
├── nvim/          → init.lua, lua/config, lua/plugins
├── opencode/      → opencode.json
├── docs-atajos/   → chuletas de atajos .txt
├── AGENTS.md      → reglas de opencode
├── SOUL.md        → manifiesto personal
├── install.sh     → bootstrap automático
└── README.md
```

## Instalación en máquina nueva

```bash
git clone git@github.com:maxnunez/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

El script instala paquetes, copia configs y te deja todo andando.

## Migración completa (3 pasos)

Después del `install.sh`, ejecutar en orden:

```bash
# Paso 2 — Paquetes apt manuales + apps Flatpak
cd ~/dotfiles/packages
chmod +x restore-packages.sh restore-repos.sh
./restore-packages.sh

# Paso 3 — Repos apt + keyrings + VSCodium (settings y extensiones)
./restore-repos.sh
```

## Contenido de packages/

| Archivo | Qué es |
|---------|--------|
| `apt-manual.txt` | 346 paquetes apt instalados a mano |
| `flatpak.txt` | 14 apps Flatpak |
| `restore-packages.sh` | Restaura apt + flatpak |
| `apt-repos/` | Repos apt no estándar + keyrings (VSCodium, Brave, etc.) |
| `restore-repos.sh` | Instala repos + keyrings + VSCodium settings/extensiones |

## Contenido de vscodium/

| Archivo | Qué es |
|---------|--------|
| `settings.json` | Config global de VSCodium |
| `extensions.txt` | Lista de extensiones instaladas (17) |

> ⚠️ Bases de datos (MariaDB/Postgres) y secrets (~/.ssh, tokens) NO están en el repo. Se configuran a mano.
