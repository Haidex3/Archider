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
        const cmd = "/home/Haider/scripts/brightness-ddc.sh get"
        log("Executing GET")

        getProc.command = ["/bin/bash", "-c", cmd]
        getProc.running = true
    }

    function setBrightness(value) {
        const cmd = "/home/Haider/scripts/brightness-ddc.sh set " + value
        log("Executing SET")

        setProc.command = ["/bin/bash", "-c", cmd]
        setProc.running = true
    }

    Process {
        id: getProc

        onExited: function(exitCode) {
            if (exitCode !== 0) {
                log("GET failed")
                return
            }

            fileView.reload()
        }
    }

    Process {
        id: setProc

        onExited: function(exitCode) {
            if (exitCode !== 0) {
                log("SET failed")
                return
            }

            fileView.reload()
        }
    }

    FileView {
        id: fileView
        path: "/tmp/brightness-value"

        onLoaded: {
            const raw = fileView.text()
            const content = raw ? raw.trim() : ""

            log("File content → [" + content + "]")

            const parsed = parseInt(content)

            if (!isNaN(parsed)) {
                root.brightness = parsed
                log("Brightness updated → " + parsed)
            }
        }
    }


    Component.onCompleted: {
        log("Service initialized")
        updateBrightness()
    }
}
