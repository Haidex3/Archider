#!/usr/bin/env bash

run_sync() {

    for dir in "${DIRS[@]}"; do
        sync_dir "$SRC_CONFIG/$dir" "$DST_CONFIG/$dir" "~/.config/$dir"
    done

    sync_dir "$SRC_FIREFOX" "$DST_FIREFOX" "Firefox chrome"
    sync_dir "$SRC_FIREFOX_NATIVE" "$DST_FIREFOX_NATIVE" "~/.mozilla/native-messaging-hosts"
    sync_dir "$SRC_THEMES" "$DST_THEMES" ".local/share/themes"
    sync_dir "$SRC_HATHEME_SHARE" "$DST_HATHEME_SHARE" ".local/share/hatheme"
    sync_dir "$SRC_HATHEME_STATE" "$DST_HATHEME_STATE" ".local/state/hatheme"

    SCRIPTS_EXCLUDES=()
    if [ "$MODE" != "pull" ] && [ "$IS_LAPTOP" == "true" ]; then
        SCRIPTS_EXCLUDES+=(--exclude='brightness-ddc.sh')
    fi
    sync_dir "$SRC_SCRIPTS" "$DST_SCRIPTS" "~/scripts" "${SCRIPTS_EXCLUDES[@]}"

    sync_dir "$SRC_VSCODE/themes" "$DST_VSCODE/themes" "VS Code themes"

    if [ -f "$SRC_VSCODE/settings.json" ]; then
        mkdir -p "$DST_VSCODE"
        rsync -av "$SRC_VSCODE/settings.json" "$DST_VSCODE/settings.json"
    fi
    
    # ---------------------------------
    # GRUB sync (push & pull)
    # ---------------------------------

    echo "Syncing GRUB configuration..."

    # Sync grub main config
    if [ -f "$SRC_GRUB" ]; then
        echo "Copying $SRC_GRUB → $DST_GRUB"
        sudo cp "$SRC_GRUB" "$DST_GRUB"
    else
        echo "Warning: $SRC_GRUB not found."
    fi

    # Sync grub theme
    if [ -d "$SRC_GRUB_THEME" ]; then
        echo "Copying theme $SRC_GRUB_THEME → $DST_GRUB_THEME"
        sudo mkdir -p "$(dirname "$DST_GRUB_THEME")"
        sudo rm -rf "$DST_GRUB_THEME"
        sudo cp -r "$SRC_GRUB_THEME" "$DST_GRUB_THEME"
    else
        echo "Warning: $SRC_GRUB_THEME not found."
    fi

    # Only regenerate grub when modifying system
    if [ "$MODE" == "pull" ]; then
        echo "Regenerating GRUB configuration..."
        sudo grub-mkconfig -o /boot/grub/grub.cfg
    fi
}
