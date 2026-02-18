#!/usr/bin/env bash
set -e

pacman -S --noconfirm grub efibootmgr os-prober

echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub

grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
