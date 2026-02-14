#!/usr/bin/env bash

CLASS="qs-nmtui"

# Esperar a que la ventana aparezca
sleep 1

while true; do
    # Ventana activa en Hyprland
    ACTIVE_CLASS=$(hyprctl activewindow -j | jq -r '.class' 2>/dev/null)

    if [[ "$ACTIVE_CLASS" != "$CLASS" ]]; then
        # Si perdió foco → matar nmtui
        pkill -f "alacritty.*$CLASS"
        exit 0
    fi

    sleep 0.2
done
