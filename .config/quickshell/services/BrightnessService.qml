pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Scope {
    id: root

    property int brightness: 50

    function log(msg) {
        console.log("[BrightnessService]", msg)
    }

    function updateBrightness() {
        getProc.command = ["/bin/bash", "-c",
            "/home/Haider/scripts/brightness-ddc.sh get"]
        getProc.running = true
    }

    function setBrightness(value) {
        root.brightness = value // actualización inmediata

        setProc.command = ["/bin/bash", "-c",
            "/home/Haider/scripts/brightness-ddc.sh set " + value]
        setProc.running = true
    }

    Process {
        id: getProc

        onExited: function(exitCode) {
            if (exitCode !== 0)
                return

            const output = getProc.readAllStandardOutput().trim()
            const parsed = parseInt(output)

            if (!isNaN(parsed))
                root.brightness = parsed
        }
    }

    Process {
        id: setProc

        onExited: function(exitCode) {
            if (exitCode !== 0) {
                updateBrightness()
                return
            }

            const output = setProc.readAllStandardOutput().trim()
            const parsed = parseInt(output)

            if (!isNaN(parsed))
                root.brightness = parsed
        }
    }

    Component.onCompleted: updateBrightness()
}
