import QtQuick
import "../../../theme" as Theme

Item {
    id: root

    // Recibimos el panel desde afuera
    required property var mediaPanel

    width: 24
    height: parent.height

    Text {
        id: icon
        anchors.centerIn: parent

        text: "󰎈"
        font.family: "Symbols Nerd Font"
        font.pixelSize: Theme.ThemeManager.titleFontSize + 2

        color: mediaPanel.open
               ? Theme.ThemeManager.color7
               : Theme.ThemeManager.color4

        Behavior on scale {
            NumberAnimation { duration: 120 }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true

        onEntered: icon.scale = 1.1
        onExited: icon.scale = 1.0

        onClicked: {
            mediaPanel.open = !mediaPanel.open
        }
    }
}
