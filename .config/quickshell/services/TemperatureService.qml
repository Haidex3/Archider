
pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    // Public properties
    property real cpuTemp: 0
    property real gpuTemp: 0
    property real gpuUsage: -1

    // CPU Temperature
    property Process _cpuProcess: Process {
        running: false

        command: [
            "sh", "-c",
            "sensors | grep -Eo '\\+[0-9]+\\.[0-9]+°C' | head -n1 | grep -Eo '[0-9]+' | head -n1"
        ]

        stdout: SplitParser {
            onRead: data => {
                const temp = parseFloat(data.trim())

                if (!isNaN(temp) && temp > 0)
                    root.cpuTemp = temp
            }
        }
    }

    // AMD RX 9070 - Edge Temperature
    property Process _gpuTempProcess: Process {
        running: false

        command: [
            "sh", "-c",
            "for hw in /sys/class/drm/card*/device/hwmon/hwmon*; do \
                [ -r \"$hw/name\" ] || continue; \
                [ \"$(cat \"$hw/name\")\" = \"amdgpu\" ] || continue; \
                [ -r \"$hw/temp1_input\" ] || continue; \
                [ \"$(cat \"$hw/temp1_label\" 2>/dev/null)\" = \"edge\" ] || continue; \
                awk '{print $1 / 1000}' \"$hw/temp1_input\"; \
                exit; \
            done; \
            echo 0"
        ]

        stdout: SplitParser {
            onRead: data => {
                const temp = parseFloat(data.trim())

                if (!isNaN(temp) && temp > 0 && temp < 120)
                    root.gpuTemp = temp
            }
        }
    }

    // Refresh temperatures every 2 seconds
    property Timer _pollTimer: Timer {
        interval: 2000
        running: true
        repeat: true
        triggeredOnStart: true

        onTriggered: {
            if (!root._cpuProcess.running)
                root._cpuProcess.running = true

            if (!root._gpuTempProcess.running)
                root._gpuTempProcess.running = true
        }
    }
}
