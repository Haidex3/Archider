#!/usr/bin/env bash
set -e

if [ "$EUID" -ne 0 ]; then
  echo "Ejecuta esto como root dentro de arch-chroot"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "========================================"
echo "         Arch Installer"
echo "========================================"

# =============================
# INPUTS
# =============================

read -p "Nombre de usuario: " USERNAME
read -s -p "Contraseña (root y usuario): " PASSWORD
echo
read -p "Hostname: " HOSTNAME
read -p "Zona horaria (ej: America/Bogota): " TIMEZONE
read -p "¿Teclado la-latin1? (s/n): " KEYBOARD_OPTION
DOTS_URL="https://github.com/Haidex3/Archider"

export USERNAME PASSWORD HOSTNAME TIMEZONE KEYBOARD_OPTION DOTS_URL SCRIPT_DIR


echo
echo "========================================"
echo "   Ejecutando módulos..."
echo "========================================"

# =============================
# EXECUTE MODULES
# =============================

bash "$SCRIPT_DIR/modules/01-system.sh"
bash "$SCRIPT_DIR/modules/02-bootloader.sh"
bash "$SCRIPT_DIR/modules/03-user.sh"
bash "$SCRIPT_DIR/modules/04-packages.sh"
bash "$SCRIPT_DIR/modules/05-yay.sh"
bash "$SCRIPT_DIR/modules/06-hardware.sh"
bash "$SCRIPT_DIR/modules/07-dots.sh"

echo
echo "========================================"
echo "     Instalación completada"
echo "     Puedes hacer reboot"
echo "========================================"
