#!/usr/bin/env bash

post_sync_adjustments() {

    CONFIG_DIR="$HOME/.config"
    QS_DIR="$CONFIG_DIR/quickshell/services"
    QS_CONF="$CONFIG_DIR/quickshell/modules/bar/components"
    SCRIPTS_DIR="$CONFIG_DIR/scripts"

    echo "Aplicando ajustes post-sincronización..."

    # =========================================
    # Ajustes SOLO si es PULL
    # =========================================
    if [ "$MODE" == "pull" ]; then

        if [ "$IS_LAPTOP" == "true" ]; then
            echo "Perfil portátil detectado (pull)"

            # Ajustar servicio brightness
            rm -f "$QS_DIR/BrightnessService.qml"

            if [ -f "$QS_DIR/BrightnessPService.qml" ]; then
                mv "$QS_DIR/BrightnessPService.qml" \
                   "$QS_DIR/BrightnessService.qml"
            fi

            rm -f "$QS_CONF/SystemControls.qml"

            if [ -f "$QS_CONF/SystemPControls.qml" ]; then
                mv "$QS_CONF/SystemPControls.qml" \
                   "$QS_CONF/SystemControls.qml"
            fi

            # Eliminar script ddc (no aplica en laptop)
            rm -f "$SCRIPTS_DIR/brightness-ddc.sh"

        else
            echo "Perfil escritorio detectado (pull)"

            if [ -f "$SCRIPTS_DIR/brightness-ddc.sh" ]; then
                chmod +x "$SCRIPTS_DIR/brightness-ddc.sh"
            fi
        fi

    else
        echo "Modo push detectado — no se modifican archivos del perfil brightness"
    fi

    # =========================================
    # Siempre asegurar permisos ejecutables
    # =========================================
    if [ -d "$SCRIPTS_DIR" ]; then
        find "$SCRIPTS_DIR" -type f -exec chmod +x {} \;
    fi

    echo "Ajustes post-sync completados"
}
