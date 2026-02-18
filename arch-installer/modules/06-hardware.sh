#!/usr/bin/env bash
set -e

echo "========================================"
echo "   Detectando hardware automáticamente"
echo "========================================"

IS_LAPTOP=false
HAS_NVIDIA=false

# =========================================
# Detectar portátil (batería presente)
# =========================================
if [ -d /sys/class/power_supply/BAT0 ]; then
    IS_LAPTOP=true
fi

# =========================================
# Detectar GPU NVIDIA
# =========================================
if lspci | grep -qi nvidia; then
    HAS_NVIDIA=true
fi

# =========================================
# Configuración portátil
# =========================================
if [[ "$IS_LAPTOP" == "true" ]]; then
    echo "✔ Portátil detectado"

    pacman -S --noconfirm --needed \
        brightnessctl \
        tlp \
        acpi \
        acpid \
        upower \
        power-profiles-daemon

    systemctl enable tlp
    systemctl enable acpid
    systemctl enable power-profiles-daemon

    # Suspender al cerrar tapa
    sed -i 's/^#HandleLidSwitch=suspend/HandleLidSwitch=suspend/' /etc/systemd/logind.conf

else
    echo "✔ Sistema de escritorio detectado"

    pacman -S --noconfirm --needed ddcutil
fi

# =========================================
# Configuración NVIDIA (si existe)
# =========================================
if [[ "$HAS_NVIDIA" == "true" ]]; then
    echo "✔ GPU NVIDIA detectada"

    pacman -S --noconfirm --needed \
        nvidia \
        nvidia-utils \
        nvidia-settings

    # Para Wayland (Hyprland)
    echo "options nvidia_drm modeset=1" > /etc/modprobe.d/nvidia.conf

else
    echo "✔ No se detectó NVIDIA"
fi

echo "========================================"
echo "   Configuración de hardware completa"
echo "========================================"
