#!/usr/bin/env bash

# =====================
# Wallpaper handler
# =====================

IMG_DIR="$HOME/.local/share/hatheme/images"
STATE_DIR="$HOME/.local/state/hatheme/scheme"

if [[ -n "$1" ]]; then
    THEME="$1"
else
    if [[ -f "$STATE_DIR/current-theme.txt" ]]; then
        THEME=$(cat "$STATE_DIR/current-theme.txt")
    else
        echo "No theme specified and no current-theme.txt found."
        exit 1
    fi
fi

WALLPAPER="$IMG_DIR/$THEME.png"
WALLPAPER_M2="$IMG_DIR/${THEME}-M2.png"

mapfile -t MONITORS < <(hyprctl monitors -j | jq -r '.[].name')

if [[ ! -f "$WALLPAPER" ]]; then
    echo "Wallpaper not found: $WALLPAPER"
    exit 1
fi

swww img "$WALLPAPER" --outputs "${MONITORS[0]}"

if [[ -n "${MONITORS[1]}" && -f "$WALLPAPER_M2" ]]; then
    swww img "$WALLPAPER_M2" --outputs "${MONITORS[1]}"
fi

echo "Wallpaper for '$THEME' applied."