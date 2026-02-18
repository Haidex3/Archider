#!/usr/bin/env bash
set -Eeuo pipefail

# ========= VALIDACIONES =========
: "${TIMEZONE:?TIMEZONE no está definida}"
: "${HOSTNAME:?HOSTNAME no está definido}"

if [[ ! -f "/usr/share/zoneinfo/$TIMEZONE" ]]; then
  echo "Timezone inválido: $TIMEZONE"
  exit 1
fi

# ========= TIMEZONE =========
ln -sf "/usr/share/zoneinfo/$TIMEZONE" /etc/localtime
hwclock --systohc

# ========= LOCALE =========
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# ========= KEYBOARD =========
if [[ "${KEYBOARD_OPTION:-}" == "s" ]]; then
  echo "KEYMAP=la-latin1" > /etc/vconsole.conf
fi

# ========= HOSTNAME =========
echo "$HOSTNAME" > /etc/hostname

cat <<EOF > /etc/hosts
127.0.0.1 localhost
::1 localhost
127.0.1.1 $HOSTNAME.localdomain $HOSTNAME
EOF

# ========= PACMAN CONFIG =========
sed -i 's/^#ParallelDownloads/ParallelDownloads/' /etc/pacman.conf
sed -i 's/^#Color/Color/' /etc/pacman.conf
sed -i '/\[multilib\]/,/Include/s/^#//' /etc/pacman.conf

# ========= KEYRING UPDATE =========
pacman -Syu --noconfirm archlinux-keyring
