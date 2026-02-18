#!/usr/bin/env bash
set -e

echo "Instalando dotfiles..."

su - $USERNAME -c "
mkdir -p ~/Documents/GitHub &&
cd ~/Documents/GitHub &&
git clone $DOTS_URL Archider &&
cd Archider &&
chmod +x sync-dotfiles.sh &&
./sync-dotfiles.sh --pull
"
