#!/usr/bin/env bash
set -e

pacman -S --noconfirm sudo networkmanager git base-devel

echo "root:$PASSWORD" | chpasswd

useradd -m -G wheel -s /bin/bash $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd

sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

systemctl enable NetworkManager
