#!/usr/bin/env bash

# Clase para Hyprland
CLASS="qs-nmtui"

# Ruta al config personalizado
ALACRITTY_CONFIG="$HOME/.config/alacritty/nmtui.toml"

# Lanzar nmtui en alacritty con título, clase y config personalizada
alacritty --config-file "$ALACRITTY_CONFIG" --class "$CLASS" --title "Network Manager" -e nmtui &

# Guardar PID de nmtui
NMTUI_PID=$!

# Esperar a que aparezca la ventana (opcional)
sleep 1

# Loop de enfoque
while true; do
    ACTIVE_CLASS=$(hyprctl activewindow -j | jq -r '.class' 2>/dev/null)
    if [[ "$ACTIVE_CLASS" != "$CLASS" ]]; then
        # Si pierde foco, matar nmtui
        kill "$NMTUI_PID"
        exit 0
    fi
    sleep 0.2
done
