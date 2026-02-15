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
