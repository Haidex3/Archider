#!/usr/bin/env bash

# Clase para Hyprland
CLASS="qs-bluetui"

# Ruta al config personalizado de Alacritty para bluetui
ALACRITTY_CONFIG="$HOME/.config/alacritty/bluetui.toml"

# Lanzar bluetui en alacritty con título, clase y config personalizada
alacritty --config-file "$ALACRITTY_CONFIG" --class "$CLASS" --title "Bluetooth Manager" -e bluetui &

# Guardar PID de bluetui
BLUETUI_PID=$!

# Esperar a que aparezca la ventana (opcional)
sleep 1

# Loop de enfoque
while true; do
    # Obtener la clase de la ventana activa
    ACTIVE_CLASS=$(hyprctl activewindow -j | jq -r '.class' 2>/dev/null)

    if [[ "$ACTIVE_CLASS" != "$CLASS" ]]; then
        # Si pierde foco, matar bluetui
        kill "$BLUETUI_PID" 2>/dev/null
        exit 0
    fi
    sleep 0.2
done
