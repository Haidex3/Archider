
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "../../../theme" as Theme

Item {
    id: root

    implicitWidth: workspaceRow.implicitWidth
    implicitHeight: workspaceRow.implicitHeight

    width: implicitWidth
    height: implicitHeight

    // Workspace display names
    property var workspaceNames: ({
        "1": "➊",
        "2": "➋",
        "3": "➌",
        "4": "➍",
        "5": "➎",
        "6": "➏",
        "7": "➐",
        "8": "➑",
        "9": "➒",
        "10": "➓",
        "11": "⓫"
    })

    // Workspace indicators
    RowLayout {
        id: workspaceRow

        anchors.centerIn: parent
        spacing: 4

        Repeater {
            model: Hyprland.workspaces

            delegate: Rectangle {
                required property var modelData

                visible: modelData.id > 0

                Layout.preferredWidth: visible ? 25 : 0
                Layout.preferredHeight: visible ? 25 : 0

                color: "transparent"

                // Workspace number
                Text {
                    anchors.centerIn: parent

                    text: root.workspaceNames[modelData.id.toString()]
                          || modelData.id

                    color: {
                        if (modelData.focused)
                            return Theme.ThemeManager.color8
                        else if (modelData.active)
                            return Theme.ThemeManager.color6
                        else
                            return Theme.ThemeManager.color2
                    }

                    font.pixelSize: Theme.ThemeManager.baseFontSize
                }

                // Active workspace indicator
                Rectangle {
                    width: parent.width * 0.8
                    height: 2

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom

                    color: {
                        if (modelData.focused)
                            return Theme.ThemeManager.color8
                        else if (modelData.active)
                            return Theme.ThemeManager.color6
                        else
                            return "transparent"
                    }
                }

                // Click interaction
                MouseArea {
                    anchors.fill: parent
                    acceptedButtons: Qt.LeftButton
                    cursorShape: Qt.PointingHandCursor
                    z: 10

                    onClicked: {
                        console.log("Cambiando al workspace:", modelData.id)

                        Hyprland.dispatch(
                            "hl.dsp.focus({ workspace = " + modelData.id + " })"
                        )
                    }
                }
            }
        }
    }
}
