# Bootstrap Debian 13

Guía para dejar una instalación limpia de Debian 13 exactamente como esta máquina.

---

## 1. Sistema base

```bash
# Actualizar
sudo apt update && sudo apt upgrade -y

# Repositorios (contrib, non-free para firmware)
sudo apt install -y software-properties-common
sudo add-apt-repository -y contrib non-free
sudo apt update
```

---

## 2. Clonar dotfiles

```bash
cd ~
git clone https://github.com/maxnunez/dotfiles.git
cd dotfiles
```

---

## 3. Ejecutar instalación automática

```bash
chmod +x install.sh
./install.sh
```

Esto instala:
- **WM**: i3-wm, i3lock, xss-lock
- **Terminal**: kitty
- **Barra/Launcher**: polybar, rofi
- **Notificaciones**: dunst
- **Visualizador de imágenes**: feh
- **Screenshots/Clipboard**: flameshot, copyq
- **Selector de archivos**: zenity
- **Procesamiento de imágenes**: imagemagick
- **Multimedia**: pavucontrol, volumeicon, brightnessctl, playerctl, vlc
- **Sistema**: btop, jq, eza, bat, fd-find, ripgrep
- **Archivos**: thunar, thunar-volman, tumbler, atril, file-roller
- **Power**: xfce4-power-manager
- **Navegador**: firefox-esr

Además instala: Homebrew, Atuin, Zoxide, Fzf, Neovim, LazyGit, Zellij,
opencode, Ollama, Node via Volta, Oh My Zsh y sus plugins.

---

## 4. Configuraciones manuales

### 4.1 LightDM — Fondo de login

```bash
sudo cp ~/dotfiles/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/
```

### 4.2 Crear symlink inicial del wallpaper

```bash
ln -sf ~/Pictures/tu-wallpaper.jpg /tmp/current-wallpaper
```

### 4.3 Zsh como shell por defecto

```bash
chsh -s $(which zsh)
# Cerrar sesión y volver a entrar
```

---

## 5. Post-instalación manual

```bash
# Nerd Font (IosevkaTerm)
# Se instala via brew en install.sh, si falla:
# brew install --cask font-iosevterm-nerd-font

# Recargar i3
# $mod+Shift+r

# Recargar zsh
exec zsh

# Si el wallpaper no aparece al inicio
feh --bg-fill ~/Pictures/tu-wallpaper.jpg
```

---

## 6. Verificar que funciona

| Comando | Qué verifica |
|---------|-------------|
| `feh --version` | feh instalado |
| `i3lock --version` | lock screen disponible |
| `zenity --version` | selector de archivos |
| `convert --version` | ImageMagick (blur del lock) |
| `kitty --version` | terminal |
| `polybar --version` | barra de estado |
| `rofi -version` | app launcher |

Probar atajos nuevos:

| Atajo | Acción |
|-------|--------|
| `$mod+Shift+b` | Abrir wallpaper picker |
| `$mod+Shift+o` | Bloquear pantalla (con blur) |

---

## 7. Atajos de feh

| Tecla | Acción |
|-------|--------|
| `←` / `→` | Anterior / Siguiente imagen |
| `↑` / `↓` | Zoom in / Zoom out |
| `f` | Fullscreen |
| `q` / `Esc` | Salir |
| `+` / `-` | Acercar / Alejar |
| `w` | Ajustar a la ventana |

---

## 8. Estructura del repo

```
dotfiles/
├── i3/config              # Configuración de i3
├── kitty/kitty.conf       # Terminal
├── polybar/                # Barra de estado
├── rofi/config.rasi        # App launcher
├── dunst/                  # Notificaciones
├── picom/picom.conf        # Compositor
├── feh/options             # Visor de imágenes
├── scripts/
│   ├── wallpaper-picker    # Cambiar wallpaper
│   └── lock-screen         # Bloquear con blur
├── lightdm/                # Fondo de login
├── nvim/                   # Neovim config
├── opencode/               # OpenCode config
├── zsh/                    # Zsh config
├── git/                    # Git config
├── docs-atajos/            # Documentación de atajos
├── install.sh              # Bootstrap automático
├── README.md
└── SOUL.md
```

> **Nota**: Después de `./install.sh`, reiniciá la sesión para aplicar todo.
