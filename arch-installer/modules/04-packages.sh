#!/usr/bin/env bash
set -e

pacman -S --noconfirm --needed - < "$SCRIPT_DIR/config/packages.txt"
