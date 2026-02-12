import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import "../../../theme" as Theme
import "../../../services" as Services

Item {
    width: 140
    height: 28

    Slider {
        id: slider
        anchors.fill: parent

        from: 0
        to: 100
        stepSize: 1

        value: Services.AudioService.volume

        onMoved: {
                Services.AudioService.changeVolume(Math.round(value))
            }

        // =====================
        // TRACK
        // =====================
        background: Item {
            x: slider.leftPadding
            y: slider.topPadding + slider.availableHeight / 2 - 3
            width: slider.availableWidth
            height: 6

            // sombra sutil
            Rectangle {
                anchors.fill: parent
                radius: 3
                color: Theme.ThemeManager.base
                opacity: 0.35
            }

            // track vacío (color 7)
            Rectangle {
                anchors.fill: parent
                radius: 3
                color: Theme.ThemeManager.color7
            }

            // track lleno (color 12)
            Rectangle {
                width: slider.visualPosition * parent.width
                height: parent.height
                radius: 3
                color: Services.AudioService.muted
                    ? Theme.ThemeManager.color4
                    : Theme.ThemeManager.color12

                Behavior on width {
                    NumberAnimation {
                        duration: 120
                        easing.type: Easing.OutCubic
                    }
                }
            }
        }

        // =====================
        // HANDLE
        // =====================
        handle: Item {
            width: 16
            height: 16

            x: slider.leftPadding
               + slider.visualPosition * slider.availableWidth
               - width / 2
            y: slider.topPadding + slider.availableHeight / 2 - height / 2

            Rectangle {
                anchors.fill: parent
                radius: width / 2
                color: Theme.ThemeManager.surface
                border.color: Theme.ThemeManager.color12
                border.width: 1.5
            }

            // glow suave
            MultiEffect {
                anchors.fill: parent
                source: parent.children[0]
                blurEnabled: true
                blur: slider.pressed ? 0.8 : 0.4
                brightness: 0.15
                opacity: slider.pressed ? 0.9 : 0.6
            }

            Behavior on scale {
                NumberAnimation {
                    duration: 120
                    easing.type: Easing.OutBack
                }
            }

            scale: slider.pressed ? 1.2 : 1.0
        }
    }

    // =====================
    // RIGHT CLICK → MUTE
    // =====================
    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        onClicked: Services.AudioService.toggleMute()
    }
}
