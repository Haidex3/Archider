#!/usr/bin/env bash

run_sync() {

    for dir in "${DIRS[@]}"; do
        sync_dir "$SRC_CONFIG/$dir" "$DST_CONFIG/$dir" "~/.config/$dir"
    done

    sync_dir "$SRC_FIREFOX" "$DST_FIREFOX" "Firefox chrome"
    sync_dir "$SRC_THEMES" "$DST_THEMES" ".local/share/themes"
    sync_dir "$SRC_HATHEME_SHARE" "$DST_HATHEME_SHARE" ".local/share/hatheme"
    sync_dir "$SRC_HATHEME_STATE" "$DST_HATHEME_STATE" ".local/state/hatheme"
    sync_dir "$SRC_SCRIPTS" "$DST_SCRIPTS" "~/scripts"

    sync_dir "$SRC_VSCODE/themes" "$DST_VSCODE/themes" "VS Code themes"

    if [ -f "$SRC_VSCODE/settings.json" ]; then
        mkdir -p "$DST_VSCODE"
        rsync -av "$SRC_VSCODE/settings.json" "$DST_VSCODE/settings.json"
    fi
}
