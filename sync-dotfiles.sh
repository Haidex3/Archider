#!/usr/bin/env bash

set -e

# Rutas
SOURCE="$HOME/.config"
TARGET="$HOME/Documents/GitHub/ArchLinuxPublic/.config"

# Carpetas a sincronizar
DIRS=(
alacritty
gtk-3.0
htop
hypr
rofi
waybar
xdg-desktop-portal
yazi
fastfetch
quickshell
)

echo "🔄 Sincronizando dotfiles..."

mkdir -p "$TARGET"

for dir in "${DIRS[@]}"; do
if [ -d "$SOURCE/$dir" ]; then
    echo "➡️  Sync $dir"
    rsync -av --delete \
    --exclude='.git/' \
    --exclude='*.log' \
    --exclude='cache/' \
    "$SOURCE/$dir/" "$TARGET/$dir/"
else
    echo "⚠️  $dir no existe en ~/.config"
fi
done

echo "✅ Sincronización completa"
