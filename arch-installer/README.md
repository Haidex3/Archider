# Arch_Linux_Public

```
./sync-dotfiles.sh

./sync-dotfiles.sh --pull

```

```
zip -r ../dark-contrast-1.3.xpi .
```



acordar de que toca dar permisos a todos los sh
ubicacion de txt base
ls ~/.local/state/hatheme/scheme


cambio a agregar en el set:
gsettings set org.gnome.desktop.interface gtk-theme Default
la ultima parte es el tema a seleccionar
gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark
gsettings set org.gnome.desktop.interface font-name "Sans 10"


chown -R $USER:$USER ~/.local/share/themes
instalar jq

spicetify backup


sudo chown -R $USER:$USER /opt/spotify

spicetify apply

sudo pacman -S fftw

sudo pacman -S jq

sudo pacman -S ddcutil

sudo pacman -S qt5ct

export QT_QPA_PLATFORMTHEME=qt5ct


/*-------------------------------------------------------------------------------
*     _    ____   ____ _   _ ___ ____  _____ ____  
*    / \  |  _ \ / ___| | | |_ _|  _ \| ____|  _ \ 
*   / _ \ | |_) | |   | |_| || || | | |  _| | |_) |
*  / ___ \|  _ <| |___|  _  || || |_| | |___|  _ < 
* /_/   \_\_| \_\\____|_| |_|___|____/|_____|_| \_\
*
*             .--. 
*            |o_o |       RESUME: 
*            |:_/ |      
*           //   \ \       
*          (|     | )      AUTHOR: Haidex3
*         /'\_   _/`\      URL: https://github.com/Haidex3/Archider
*         \___)=(___/      
*
-------------------------------------------------------------------------------*/

Guia de instalacion:

Para empezar necesitamos tener lo minimo para copiar un repo de git 

pacstrap /mnt base linux linux-firmware networkmanager grub git
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt

pacman -S git
git clone https://github.com/TU_USUARIO/TU_REPO.git
cd TU_REPO
chmod +x install.sh
./install.sh
exit
reboot


sudo nano ~/.bashrc
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

runbg() {
    nohup "$@" > /dev/null 2>&1 &
}

eval "$(ssh-agent -s)" > /dev/null