import QtQuick
import QtQuick.Controls
import Quickshell.Services.Mpris
import "../services" 1.0

ApplicationWindow {
    visible: true
    width: 400
    height: 200
    title: "Test Players"

    Column {
        anchors.centerIn: parent
        spacing: 10

        Text {
            text: Players.list.length > 0 ? "Active: " + Players.active.identity : "No MPRIS players found"
        }

        Row {
            spacing: 5

            Button { text: "Play"; onClicked: Players.play() }
            Button { text: "Pause"; onClicked: Players.pause() }
            Button { text: "Next"; onClicked: Players.next() }
            Button { text: "Prev"; onClicked: Players.previous() }
            Button { text: "Stop"; onClicked: Players.stop() }
        }

        ListView {
            width: 300; height: 100
            model: Players.list
            delegate: Text { text: Players.getIdentity(modelData) }
        }
    }
}
