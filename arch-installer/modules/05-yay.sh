#!/usr/bin/env bash
set -e

su - $USERNAME -c "
git clone https://aur.archlinux.org/yay.git &&
cd yay &&
makepkg -si --noconfirm
"
