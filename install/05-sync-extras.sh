#!/usr/bin/env bash

run_sync() {

    for dir in "${DIRS[@]}"; do
        sync_dir "$SRC_CONFIG/$dir" "$DST_CONFIG/$dir" "~/.config/$dir"
    done

    sync_dir "$SRC_FIREFOX" "$DST_FIREFOX" "Firefox chrome"
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
    # GRUB sync (push only)
    # ---------------------------------

    if [ "$MODE" == "push" ]; then
        echo "Syncing GRUB configuration..."

        if [ -f "$GRUB_SOURCE" ]; then
            sudo cp "$GRUB_SOURCE" "$GRUB_TARGET"
        else
            echo "Warning: $GRUB_SOURCE not found."
        fi

        if [ -d "$GRUB_THEME_SOURCE" ]; then
            sudo mkdir -p /boot/grub/themes
            sudo rm -rf "$GRUB_THEME_TARGET"
            sudo cp -r "$GRUB_THEME_SOURCE" "$GRUB_THEME_TARGET"
        else
            echo "Warning: $GRUB_THEME_SOURCE not found."
        fi

        echo "Regenerating GRUB configuration..."
        sudo grub-mkconfig -o /boot/grub/grub.cfg
    fi
}
