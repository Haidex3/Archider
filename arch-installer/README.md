# Archider

```
     _    ____   ____ _   _ ___ ____  _____ ____  
    / \  |  _ \ / ___| | | |_ _|  _ \| ____|  _ \ 
   / _ \ | |_) | |   | |_| || || | | |  _| | |_) |
  / ___ \|  _ <| |___|  _  || || |_| | |___|  _ < 
 /_/   \_\_| \_\\____|_| |_|___|____/|_____|_| \_\
```

**Author:** Haidex3
**Repository:** [https://github.com/Haidex3/Archider](https://github.com/Haidex3/Archider)

---

## Descripción

**Archider** es un instalador automatizado para Arch Linux diseñado para ser ejecutado **directamente después de `arch-chroot`**, con detección automática de hardware (portátil, GPU NVIDIA) y configuración completa del sistema, bootloader y dotfiles.

Objetivo:

```
USB → arch-chroot → ./install.sh → reboot → sistema listo
```

---

## Requisitos mínimos

Antes de ejecutar Archider necesitas **lo mínimo para clonar un repositorio Git**.

Desde la ISO de Arch Linux:

```bash
pacstrap /mnt base linux linux-firmware networkmanager grub git
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
```

---

## Instalación (dentro de arch-chroot)

Una vez dentro del entorno `arch-chroot /mnt`:

```bash
pacman -S git
git clone https://github.com/Haidex3/Archider
cd Archider
chmod +x install.sh
./install.sh
exit
reboot
```

El script se encargará de:

* Configuración regional y de teclado
* Creación de usuario y sudo
* Instalación de GRUB (UEFI)
* Detección automática de:

  * Portátil (batería)
  * GPU NVIDIA
* Instalación de paquetes base
* Instalación de dotfiles
* Configuración de energía, brillo y drivers gráficos

---

## Detección automática de hardware

Archider **no pregunta** si el sistema es portátil o PC.

### Portátil (batería detectada)

Se instalan automáticamente:

* `brightnessctl`
* `tlp`
* `acpid`
* `upower`
* `power-profiles-daemon`

Y se habilitan los servicios correspondientes.

### PC

Se instala:

* `ddcutil` (control de brillo por DDC/CI)

### GPU NVIDIA (si se detecta)

Se instalan:

* `nvidia`
* `nvidia-utils`
* `nvidia-settings`

Además se habilita Wayland correctamente (`nvidia_drm modeset=1`).

---

## Gestión de paquetes

### Paquetes base

Se definen en:

```
config/packages.txt
```

Aquí van **solo los paquetes comunes a todos los sistemas**.

### Paquetes específicos por hardware

Se gestionan automáticamente en:

```
modules/07-hardware.sh
```

---

## Sincronización de dotfiles

Una vez instalado el sistema, puedes sincronizar manualmente tus dotfiles:

```bash
./sync-dotfiles.sh
```

Para traer cambios desde el repositorio remoto:

```bash
./sync-dotfiles.sh --pull
```

---

## Temas GTK / Iconos / Fuentes

Configuración de temas vía `gsettings`:

```bash
gsettings set org.gnome.desktop.interface gtk-theme Default
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
gsettings set org.gnome.desktop.interface font-name "Sans 10"
```

Asignar permisos correctos a temas locales:

```bash
chown -R $USER:$USER ~/.local/share/themes
```

---

## Spicetify

```bash
spicetify backup
sudo chown -R $USER:$USER /opt/spotify
spicetify apply
```

---

## Utilidades adicionales

Instalación manual (si se requieren):

```bash
sudo pacman -S fftw
sudo pacman -S jq
sudo pacman -S ddcutil
sudo pacman -S qt5ct
```

Configuración de Qt:

```bash
export QT_QPA_PLATFORMTHEME=qt5ct
```

---

## Empaquetar extensiones (ej. Firefox)

```bash
zip -r ../dark-contrast-1.3.xpi .
```

---

## Servicios recomendados

```bash
sudo systemctl enable upower
sudo systemctl enable bluetooth
sudo systemctl enable power-profiles-daemon
```

---

## Configuración de shell

### `~/.bash_profile`

```bash
[[ -f ~/.bashrc ]] && . ~/.bashrc

if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
  exec start-hyprland
fi

export PATH="$HOME/.local/bin:$PATH"
```

---

### `~/.bashrc`

```bash
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias code='code --ozone-platform=wayland --enable-features=WaylandWindowDecorations'

PS1='[\u@\h \W]\$ '

runbg() {
    nohup "$@" >/dev/null 2>&1 &
    disown
}

eval "$(ssh-agent -s)" > /dev/null
```

---

## Resultado final

Después del reboot tendrás:

* Arch Linux funcional
* GRUB configurado
* Usuario listo
* Red activa
* Hyprland
* Drivers correctos
* Dotfiles aplicados
* Sistema adaptado automáticamente a tu hardware

---

## Nota final

Este proyecto está pensado para **uso personal avanzado**, pero su estructura es lo suficientemente limpia como para evolucionar a una herramienta pública.

> Archider no intenta ser Archinstall
> Archider es *tu* Arch

Si quieres, en el siguiente paso podemos:

* Añadir modo no interactivo
* Logging a `/var/log/archider.log`
* Flags tipo `--minimal`, `--full`
* Detección automática de CPU (microcode)

Esto ya es **portfolio-level serio**.
