# Resumen de Cambios — Configuración i3 + Herramientas

## 1. Visor de imágenes por defecto: feh

```bash
# Instalación
sudo apt install feh -y
```

- Configurado como visor default para PNG, JPG, GIF, BMP, TIFF, WEBP, HEIC
- `~/.config/feh/options` → `--scale-down` (imágenes grandes entran en pantalla, chicas no se estiran)
- Atajos principales: `←→` navegar, `↑↓` zoom, `f` fullscreen, `q` salir, `w` ajustar

---

## 2. Wallpaper picker (`$mod+Shift+b`)

**Script:** `~/.local/bin/wallpaper-picker`

```bash
#!/bin/bash
IMAGE=$(zenity --file-selection --title="Elegí un wallpaper" \
  --file-filter="Imágenes | *.png *.jpg *.jpeg *.bmp *.gif *.webp" \
  --filename="$HOME/Pictures/")

if [ -n "$IMAGE" ]; then
  feh --bg-fill "$IMAGE"
  ln -sf "$IMAGE" /tmp/current-wallpaper
  notify-send "Wallpaper actualizado" "$(basename "$IMAGE")"
fi
```

- Abre selector de imágenes con zenity
- Setea el wallpaper con `feh --bg-fill`
- Guarda la ruta en `/tmp/current-wallpaper` para usarla en el lock screen

---

## 3. Lock screen con blur (`$mod+Shift+o`)

**Script:** `~/.local/bin/lock-screen`

```bash
#!/bin/bash
TMPBG="/tmp/lock-screen.png"

import -window root "$TMPBG"                    # Screenshot del escritorio
convert "$TMPBG" -scale 10% -scale 1000% -blur 0x8 "$TMPBG"  # Pixelado + blur

i3lock -i "$TMPBG" --fill --nofork
rm -f "$TMPBG"                                  # Limpiar al desbloquear
```

- Toma screenshot con `import` (ImageMagick)
- Pixela (`scale 10% → 1000%`) y desenfoca (`blur 0x8`)
- Lo muestra como fondo del bloqueo
- Al desbloquear, borra el archivo temporal

---

## 4. Fondo de login (LightDM / Debian 13)

**Archivo:** `/etc/lightdm/lightdm-gtk-greeter.conf`

```ini
[greeter]
background = /home/max/Pictures/backiee-286513-landscape.jpg
user-background = false
theme-name = Adwaita-dark
icon-theme-name = Adwaita
font-name = Sans 10
indicators = ~clock;~host;~power
clock-format = %H:%M
```

- Fondo único para la pantalla de login
- Tema oscuro
- Reloj y nombre del equipo visibles

---

## 5. Atajos nuevos en i3

| Atajo | Acción |
|-------|--------|
| `$mod+Shift+b` | Abrir wallpaper picker |
| `$mod+Shift+o` | Bloquear pantalla (con blur) |

---

## 6. Archivos modificados/creados

| Archivo | Cambio |
|---------|--------|
| `~/.config/i3/config` | Binding wallpaper picker + lock screen + symlink wallpaper |
| `~/.local/bin/wallpaper-picker` | **Nuevo** — script para cambiar wallpaper |
| `~/.local/bin/lock-screen` | **Nuevo** — script para bloquear con blur |
| `~/.config/feh/options` | **Nuevo** — flag `--scale-down` |
| `/usr/share/applications/feh.desktop` | Exec con `--scale-down`, `NoDisplay=false` |
| `/etc/lightdm/lightdm-gtk-greeter.conf` | Fondo de login, tema oscuro |

---

# Aprendé Bash — Resumen

## ¿Qué es Bash?

Bash (Bourne Again Shell) es **el intérprete de comandos** de Linux. No es solo para escribir comandos — es un lenguaje de scripting completo. Todo en Linux se puede automatizar con Bash.

## Lo esencial

### Variables

```bash
nombre="Max"                    # Asignación (sin espacios alrededor del =)
echo $nombre                    # Usar con $
echo "${nombre}123"             # Llaves para concatenar
readonly PI=3.14                # Constante
```

### Arrays

```bash
frutas=("manzana" "pera" "uva")
echo ${frutas[0]}               # manzana
echo ${frutas[@]}               # todos los elementos
echo ${#frutas[@]}              # cantidad (3)
```

### Condicionales

```bash
if [ "$nombre" = "Max" ]; then
  echo "Hola Max"
elif [ -f "$archivo" ]; then    # -f existe archivo
  echo "El archivo existe"
else
  echo "No sé"
fi

# Operadores comunes:
# -f "$file"   → existe y es archivo
# -d "$dir"    → existe y es directorio
# -z "$var"    → string vacío
# -n "$var"    → string no vacío
# "$a" = "$b"  → strings iguales
# "$a" -eq "$b" → números iguales
```

### Loops

```bash
# For clásico
for i in {1..5}; do
  echo $i
done

# For con array
for fruta in "${frutas[@]}"; do
  echo "$fruta"
done

# For con archivos
for img in *.jpg; do
  feh --bg-fill "$img"
done

# While
while read linea; do
  echo "$linea"
done < archivo.txt
```

### Funciones

```bash
saludar() {
  local nombre="$1"             # $1 = primer argumento
  echo "Hola $nombre"
}

saludar "Max"                   # → Hola Max
```

## Comandos que más vas a usar en scripts

```bash
echo "texto"                    # imprimir
read -p "Pregunta: " var       # pedir input al usuario
ls, cp, mv, rm, mkdir          # archivos
grep, sed, awk                 # procesar texto
find, xargs                    # buscar y ejecutar
date                           # fecha/hora
basename, dirname              # manipular rutas
```

## Capturar salida de comandos

```bash
# Forma moderna (preferida) — $()
ARCHIVOS=$(ls *.txt)
FECHA=$(date +%Y-%m-%d)

# Forma antigua — backticks (evitar)
ARCHIVOS=`ls *.txt`
```

## Redirección

```bash
comando > archivo.txt           # stdout → archivo (sobrescribe)
comando >> archivo.txt          # stdout → archivo (agrega)
comando 2> error.log            # stderr → archivo
comando &> todo.log             # stdout + stderr
comando && echo "OK"            # solo si funciona
comando || echo "Falló"         # solo si falla
```

## Patrón de script seguro

```bash
#!/bin/bash
set -e                          # Salir si un comando falla
set -u                          # Error si usás variable indefinida

# Código acá
```

### Errores comunes de novato

```bash
# MAL — espacios alrededor del =
nombre = "Max"     # → error: "nombre: command not found"

# MAL — falta $ al leer
if [ nombre = "Max" ]  # → compara el string "nombre", no la variable

# MAL — no quotean variables
if [ -f $archivo ]   # → se rompe si $archivo tiene espacios

# BIEN
nombre="Max"
if [ "$nombre" = "Max" ]; then
if [ -f "$archivo" ]; then
```

## Para practicar

1. **Escribí scripts chicos** que resuelvan problemas reales (como el `wallpaper-picker`)
2. **Bash Academy** → [https://guide.bash.academy/](https://guide.bash.academy/)
3. **Google Shell Style Guide** → cómo escribir bash limpio y mantenible

## Filosofía

> Bash no es para apps grandes — es para **pegar comandos de Linux** entre sí. Si necesitás estructuras de datos complejas, pasate a Python. Pero para automatizar el sistema, no hay nada más rápido.
