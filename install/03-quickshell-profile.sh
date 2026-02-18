#!/usr/bin/env bash

handle_quickshell_profile() {

    QS_DIR="$REPO_ROOT/.config/quickshell/services"

    if [ "$MODE" == "pull" ]; then
        if [ "$IS_LAPTOP" == "true" ]; then
            echo "Perfil portátil: ajustando BrightnessService"

            rm -f "$QS_DIR/BrightnessService.qml"

            if [ -f "$QS_DIR/BrightnessPService.qml" ]; then
                mv "$QS_DIR/BrightnessPService.qml" \
                   "$QS_DIR/BrightnessService.qml"
            fi
        fi
    fi
}
