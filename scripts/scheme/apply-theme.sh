#!/usr/bin/env bash

# ----------------------------
# Rutas
# ----------------------------
COLOR_FILE="$HOME/.local/state/hatheme/scheme/colors.txt"

# Alacritty
ALACRITTY_CONFIG="$HOME/.config/alacritty/colors.toml"
ALACRITTY_NMTUI_CONFIG="$HOME/.config/alacritty/nmtui.toml"
ALACRITTY_BLUETUI_CONFIG="$HOME/.config/alacritty/bluetui.toml"

# Kitty
KITTY_CONFIG="$HOME/.config/kitty/kitty.conf"

# Hyprland
HYPR_COLORS="$HOME/.config/hypr/myColors.conf"

# ----------------------------
# Leer colores del archivo maestro
# ----------------------------
get_color() {
    grep "^$1" "$COLOR_FILE" | awk '{print "#"$2}'
}

# Convierte #RRGGBB → rgba(RRGGBBff)
to_rgba() {
    echo "rgba(${1#"#"}ff)"
}

primary=$(get_color "primary_paletteKeyColor")
secondary=$(get_color "secondary_paletteKeyColor")
background=$(get_color "background")
foreground=$(get_color "onBackground")
cursor=$(get_color "primary")
success=$(get_color "success")
error=$(get_color "error")
warning=$(get_color "yellow")
info=$(get_color "blue")
primaryContainer=$(get_color "primaryContainer")

# Colores para Hyprland
active_border=$(to_rgba "$primary")

# ----------------------------
# Generar Alacritty config
# ----------------------------
mkdir -p "$(dirname "$ALACRITTY_CONFIG")"

cat > "$ALACRITTY_CONFIG" <<EOF
[colors]

[colors.primary]
background = "$background"
foreground = "$foreground"
EOF


# ----------------------------
# Generar Alacritty config para nmtui
# ----------------------------
mkdir -p "$(dirname "$ALACRITTY_NMTUI_CONFIG")"

cat > "$ALACRITTY_NMTUI_CONFIG" <<EOF
[colors.normal]
black = "$primary"
red = "$secondary"
blue = "$background"
white = "$background"

EOF

# ----------------------------
# Generar Alacritty config para bluetui
# ----------------------------
mkdir -p "$(dirname "$ALACRITTY_BLUETUI_CONFIG")"

cat > "$ALACRITTY_BLUETUI_CONFIG" <<EOF
[colors.normal]
black   = "$background"
green   = "$primary"
yellow  = "$secondary"
blue    = "$secondary"

[colors.primary]
foreground = "$primary"
background = "$background"

[colors.bright]
white   = "$primary"
black   = "$primaryContainer"

EOF

# ----------------------------
# Generar Kitty config
# ----------------------------
mkdir -p "$(dirname "$KITTY_CONFIG")"

cat > "$KITTY_CONFIG" <<EOF
background $background
foreground $foreground
cursor $cursor
color0 $background
color1 $error
color2 $success
color3 $warning
color4 $info
color5 $primary
color6 $secondary
color7 $foreground
EOF

# ----------------------------
# Generar Hyprland colors
# ----------------------------
mkdir -p "$(dirname "$HYPR_COLORS")"

cat > "$HYPR_COLORS" <<EOF
# ~/.config/hypr/myColors.conf

# === Colores generales ===
general {
    col.active_border = $active_border
}
EOF

echo "Tema aplicado desde $COLOR_FILE a todas las apps compatibles."

hyprctl reload
