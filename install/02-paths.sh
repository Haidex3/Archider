#!/usr/bin/env bash

setup_paths() {

    SOURCE="$HOME/.config"
    TARGET="$REPO_ROOT/.config"

    FIREFOX_DIR="$HOME/.mozilla/firefox"
    PROFILE_INI="$FIREFOX_DIR/profiles.ini"

    if [ -f "$PROFILE_INI" ]; then
        DEFAULT_PROFILE=$(awk -F= '
            $1=="Default" && $2=="1" { found=1 }
            found && $1=="Path" { print $2; exit }
        ' "$PROFILE_INI")

        if [ -z "$DEFAULT_PROFILE" ]; then
            DEFAULT_PROFILE=$(grep -m1 "^Path=" "$PROFILE_INI" | cut -d= -f2)
        fi
    else
        DEFAULT_PROFILE=""
    fi

    if [ -n "$DEFAULT_PROFILE" ]; then
        FIREFOX_CHROME_SOURCE="$FIREFOX_DIR/$DEFAULT_PROFILE/chrome"
    else
        FIREFOX_CHROME_SOURCE=""
    fi

    FIREFOX_CHROME_TARGET="$REPO_ROOT/firefox/chrome"

    HATHEME_SHARE_SOURCE="$HOME/.local/share/hatheme"
    HATHEME_SHARE_TARGET="$REPO_ROOT/.local/share/hatheme"

    THEMES_SHARE_SOURCE="$HOME/.local/share/themes"
    THEMES_SHARE_TARGET="$REPO_ROOT/.local/share/themes"

    HATHEME_STATE_SOURCE="$HOME/.local/state/hatheme"
    HATHEME_STATE_TARGET="$REPO_ROOT/.local/state/hatheme"

    SCRIPTS_SOURCE="$HOME/scripts"
    SCRIPTS_TARGET="$REPO_ROOT/scripts"

    VSCODE_USER_SOURCE="$HOME/.config/Code/User"
    VSCODE_USER_TARGET="$REPO_ROOT/.config/Code/User"

    DIRS=(
        alacritty
        gtk-3.0
        htop
        hypr
        rofi
        waybar
        xdg-desktop-portal
        yazi
        fastfetch
        quickshell
        spicetify
    )

    # ----------------------------
    # GRUB configuration
    # ----------------------------

    GRUB_SOURCE="$REPO_ROOT/Grub/grub"
    GRUB_TARGET="/etc/default/grub"

    GRUB_THEME_SOURCE="$REPO_ROOT/Grub/minegrub-world-selection"
    GRUB_THEME_TARGET="/boot/grub/themes/minegrub-world-selection"

    # ----------------------------
    # Unified export
    # ----------------------------

    export SOURCE TARGET \
            FIREFOX_CHROME_SOURCE FIREFOX_CHROME_TARGET \
            HATHEME_SHARE_SOURCE HATHEME_SHARE_TARGET \
            THEMES_SHARE_SOURCE THEMES_SHARE_TARGET \
            HATHEME_STATE_SOURCE HATHEME_STATE_TARGET \
            SCRIPTS_SOURCE SCRIPTS_TARGET \
            VSCODE_USER_SOURCE VSCODE_USER_TARGET \
            GRUB_SOURCE GRUB_TARGET \
            GRUB_THEME_SOURCE GRUB_THEME_TARGET \
            DIRS
}