#!/usr/bin/env bash
set -e

MODE="push"  # push = sistema -> repo, pull = repo -> sistema
if [ "$1" == "--pull" ]; then
    MODE="pull"
fi

echo "Modo de sincronización: $MODE"

# =========================
# Función de sincronización
# =========================
sync_dir() {
    local SRC="$1"
    local DST="$2"
    local DESC="$3"

    if [ -e "$SRC" ]; then
        echo "➡️  Sync $DESC"
        mkdir -p "$DST"
        rsync -av --delete \
            --exclude='.git/' \
            --exclude='*.log' \
            --exclude='cache/' \
            "$SRC/" "$DST/"
    else
        echo " ❌ No existe $DESC ($SRC)"
    fi
}

# =========================
# Rutas principales
# =========================
SOURCE="$HOME/.config"
TARGET="$HOME/Documents/GitHub/ArchLinuxPublic/.config"

FIREFOX_CHROME_SOURCE="$HOME/.mozilla/firefox/lg6xv97x.default-release/chrome"
FIREFOX_CHROME_TARGET="$HOME/Documents/GitHub/ArchLinuxPublic/firefox/chrome"

HATHEME_SHARE_SOURCE="$HOME/.local/share/hatheme"
HATHEME_SHARE_TARGET="$HOME/Documents/GitHub/ArchLinuxPublic/.local/share/hatheme"

THEMES_SHARE_SOURCE="$HOME/.local/share/themes"
THEMES_SHARE_TARGET="$HOME/Documents/GitHub/ArchLinuxPublic/.local/share/themes"

HATHEME_STATE_SOURCE="$HOME/.local/state/hatheme"
HATHEME_STATE_TARGET="$HOME/Documents/GitHub/ArchLinuxPublic/.local/state/hatheme"

SCRIPTS_SOURCE="$HOME/scripts"
SCRIPTS_TARGET="$HOME/Documents/GitHub/ArchLinuxPublic/scripts"

VSCODE_USER_SOURCE="$HOME/.config/Code/User"
VSCODE_USER_TARGET="$HOME/Documents/GitHub/ArchLinuxPublic/.config/Code/User"

# Carpetas a sincronizar desde ~/.config
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

# =========================
# Decide la dirección
# =========================
if [ "$MODE" == "pull" ]; then
    echo "⬇️ Actualizando sistema desde el repo..."
    SRC_CONFIG="$TARGET"
    DST_CONFIG="$SOURCE"

    SRC_FIREFOX="$FIREFOX_CHROME_TARGET"
    DST_FIREFOX="$FIREFOX_CHROME_SOURCE"

    SRC_THEMES="$THEMES_SHARE_TARGET"
    DST_THEMES="$THEMES_SHARE_SOURCE"

    SRC_HATHEME_SHARE="$HATHEME_SHARE_TARGET"
    DST_HATHEME_SHARE="$HATHEME_SHARE_SOURCE"

    SRC_HATHEME_STATE="$HATHEME_STATE_TARGET"
    DST_HATHEME_STATE="$HATHEME_STATE_SOURCE"

    SRC_SCRIPTS="$SCRIPTS_TARGET"
    DST_SCRIPTS="$SCRIPTS_SOURCE"

    SRC_VSCODE="$VSCODE_USER_TARGET"
    DST_VSCODE="$VSCODE_USER_SOURCE"
else
    echo "⬆️ Sincronizando sistema hacia el repo..."
    SRC_CONFIG="$SOURCE"
    DST_CONFIG="$TARGET"

    SRC_FIREFOX="$FIREFOX_CHROME_SOURCE"
    DST_FIREFOX="$FIREFOX_CHROME_TARGET"

    SRC_THEMES="$THEMES_SHARE_SOURCE"
    DST_THEMES="$THEMES_SHARE_TARGET"

    SRC_HATHEME_SHARE="$HATHEME_SHARE_SOURCE"
    DST_HATHEME_SHARE="$HATHEME_SHARE_TARGET"

    SRC_HATHEME_STATE="$HATHEME_STATE_SOURCE"
    DST_HATHEME_STATE="$HATHEME_STATE_TARGET"

    SRC_SCRIPTS="$SCRIPTS_SOURCE"
    DST_SCRIPTS="$SCRIPTS_TARGET"

    SRC_VSCODE="$VSCODE_USER_SOURCE"
    DST_VSCODE="$VSCODE_USER_TARGET"
fi

# =========================
# Sync dirs
# =========================
for dir in "${DIRS[@]}"; do
    sync_dir "$SRC_CONFIG/$dir" "$DST_CONFIG/$dir" "~/.config/$dir"
done

sync_dir "$SRC_FIREFOX" "$DST_FIREFOX" "Firefox chrome"
sync_dir "$SRC_THEMES" "$DST_THEMES" ".local/share/themes"
sync_dir "$SRC_HATHEME_SHARE" "$DST_HATHEME_SHARE" ".local/share/hatheme"
sync_dir "$SRC_HATHEME_STATE" "$DST_HATHEME_STATE" ".local/state/hatheme"
sync_dir "$SRC_SCRIPTS" "$DST_SCRIPTS" "~/scripts"

# VS Code
sync_dir "$SRC_VSCODE/themes" "$DST_VSCODE/themes" "VS Code themes"

if [ -f "$SRC_VSCODE/settings.json" ]; then
    echo "➡️  Sync VS Code settings.json"
    mkdir -p "$DST_VSCODE"
    rsync -av "$SRC_VSCODE/settings.json" "$DST_VSCODE/settings.json"
fi

echo "✅ Sincronización completa"
