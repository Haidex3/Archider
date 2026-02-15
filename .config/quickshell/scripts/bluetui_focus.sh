#!/usr/bin/env bash

# Clase para Hyprland
CLASS="qs-bluetui"

# Lanzar bluetui en alacritty con título y clase
alacritty --class "$CLASS" --title "Bluetooth Manager" -e bluetui &

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
