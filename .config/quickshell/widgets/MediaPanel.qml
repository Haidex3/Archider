import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Shapes
import Quickshell.Services.Mpris
import "../theme" as Theme
import "../services/media" 1.0
import "../modules/"
import "../services/"

PanelWindow {
    id: mediaPanel

    property bool open: false
    property var targetScreen

    screen: targetScreen
    visible: open
    color: "transparent"

    anchors {
        left: true
        right: true
        top: true
        bottom: true
    }

    // =========================
    // FONDO CLICK-TO-CLOSE
    // =========================
    MouseArea {
        anchors.fill: parent
        enabled: open
        onClicked: mediaPanel.open = false
    }

    // =========================
    // PANEL
    // =========================
    Rectangle {
        id: panelBox

        width: 650
        height: 280
        radius: 16

        color: Theme.ThemeManager.base
        border.color: Theme.ThemeManager.color12
        border.width: 1

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 0

        y: open ? 8 : -height
        opacity: open ? 1 : 0

        Behavior on y { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }
        Behavior on opacity { NumberAnimation { duration: 150 } }

        MouseArea {
            anchors.fill: parent
            onClicked: mouse.accepted = true
        }

        RowLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 20

            // =========================
            // IZQUIERDA: Carátula + CAVA
            // =========================
            Item {
                id: albumCoverWrapper
                width: 160
                height: 160
                Layout.alignment: Qt.AlignVCenter

                // 🌟 Visualizador radial (CAVA)
                Shape {
                    id: visualiser
                    anchors.fill: parent
                    asynchronous: true
                    preferredRendererType: Shape.CurveRenderer
                    readonly property real centerX: width / 2
                    readonly property real centerY: height / 2
                    data: visualiserBars.instances
                }

                Variants {
                    id: visualiserBars
                    model: Array.from({ length: 32 }, (_, i) => i)

                    ShapePath {
                        required property int modelData
                        readonly property real angle: modelData * 2 * Math.PI / 32
                        readonly property real magnitude: value * 20
                        readonly property real value: {
                            const cavaValues = AudioService.values || []
                            console.log("AudioService.values[", modelData, "] =", cavaValues[modelData])
                            return Math.max(0.01, Math.min(1, cavaValues[modelData] || 0))
                        }



                        capStyle: ShapePath.RoundCap
                        strokeWidth: 4
                        strokeColor: Theme.ThemeManager.color7

                        startX: visualiser.centerX + Math.cos(angle) * 60
                        startY: visualiser.centerY + Math.sin(angle) * 60

                        PathLine {
                            x: visualiser.centerX + Math.cos(angle) * (60 + magnitude)
                            y: visualiser.centerY + Math.sin(angle) * (60 + magnitude)
                        }
                    }
                }

                // Imagen de portada centrada
                StyledClippingRect {
                    anchors.fill: parent
                    color: Theme.ThemeManager.color3
                    radius: Infinity

                    Image {
                        id: albumImage
                        anchors.fill: parent
                        source: Players.getTrackArt() || "../assets/images/placeholder_album.png"
                        asynchronous: true
                        fillMode: Image.PreserveAspectCrop
                    }

                    Connections {
                        target: Players.active
                        function onPostTrackChanged() {
                            albumImage.source = Players.getTrackArt() || "../assets/images/placeholder_album.png"
                        }
                    }
                }
            }



            // =========================
            // CENTRO: Título, artista, barra y botones
            // =========================
            ColumnLayout {
                spacing: 12
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter

                Text {
                    id: trackTitle
                    text: Players.getTrackTitle()
                    color: Theme.ThemeManager.text
                    font.pixelSize: 18
                    font.bold: true
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter

                    Connections {
                        target: Players.active
                        function onPostTrackChanged() { trackTitle.text = Players.getTrackTitle() }
                    }
                }

                Text {
                    id: trackArtist
                    text: Players.getTrackArtist() + (Players.active?.album ? " - " + Players.active.album : "")
                    color: Theme.ThemeManager.color12
                    font.pixelSize: 14
                    elide: Text.ElideRight
                    Layout.fillWidth: true
                    horizontalAlignment: Text.AlignHCenter


                    Connections {
                        target: Players.active
                        function onPostTrackChanged() { trackArtist.text = Players.getTrackArtist() + (Players.active?.album ? " - " + Players.active.album : "") }
                    }
                }

                // =========================
                // Barra de progreso
                // =========================
                Rectangle {
                    id: progressContainer
                    height: 6
                    radius: 3
                    color: Theme.ThemeManager.color1
                    Layout.fillWidth: true
                    Layout.topMargin: 8

                    Rectangle {
                        id: progressBar
                        height: parent.height
                        width: parent.width * (Players.position / (Players.length || 1))
                        radius: 3
                        color: Theme.ThemeManager.color7
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (Players.active?.canSeek) {
                                const pos = Math.round(mouse.x / progressContainer.width * Players.length)
                                Players.setPosition(pos)
                            }
                        }
                    }

                    Timer {
                        interval: 500
                        running: Players.isPlaying
                        repeat: true
                        onTriggered: {
                            progressBar.width = progressContainer.width * (Players.position / (Players.length || 1))
                        }
                    }

                    Connections {
                        target: Players.active
                        function onPostTrackChanged() {
                            progressBar.width = progressContainer.width * (Players.position / (Players.length || 1))
                        }
                    }
                }

                // =========================
                // Botones de control
                // =========================
                RowLayout {
                    spacing: 16
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 8

                    // Botón anterior
                    Rectangle {
                        width: 36; height: 36
                        radius: 18
                        color: Theme.ThemeManager.color3
                        border.color: Theme.ThemeManager.color12
                        border.width: 1

                        Image {
                            anchors.centerIn: parent
                            source: "../assets/icons/previous.svg"
                            width: 18
                            height: 18
                            fillMode: Image.PreserveAspectFit
                            smooth: true
                        }

                        MouseArea { 
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: Players.previous()
                        }
                    }

                    // Botón play/pause
                    Rectangle {
                        id: playPauseButton
                        width: 48; height: 48
                        radius: 24
                        color: Theme.ThemeManager.color7

                        Image {
                            id: playPauseIcon
                            anchors.centerIn: parent
                            width: 24; height: 24
                            fillMode: Image.PreserveAspectFit
                            smooth: true
                            source: Players.isPlaying ? "../assets/icons/pause.svg" : "../assets/icons/play.svg"
                        }

                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                Players.playPause()
                                playPauseIcon.source = Players.isPlaying ? "../assets/icons/pause.svg" : "../assets/icons/play.svg"
                            }
                        }

                        Connections {
                            target: Players
                            onIsPlayingChanged: {
                                playPauseIcon.source = Players.isPlaying ? "../assets/icons/pause.svg" : "../assets/icons/play.svg"
                            }
                        }
                    }

                    // Botón siguiente
                    Rectangle {
                        width: 36; height: 36
                        radius: 18
                        color: Theme.ThemeManager.color3
                        border.color: Theme.ThemeManager.color12
                        border.width: 1

                        Image {
                            anchors.centerIn: parent
                            source: "../assets/icons/next.svg"
                            width: 18
                            height: 18
                            fillMode: Image.PreserveAspectFit
                            smooth: true
                        }

                        MouseArea { 
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: Players.next()
                        }
                    }
                }
            }

            // =========================
            // DERECHA: GIF animado
            // =========================
            AnimatedImage {
                width: 100
                height: 100
                playing: Players.isPlaying
                speed: 1.0
                source: "../assets/gifs/bongocat.gif"
                fillMode: AnimatedImage.PreserveAspectFit
                asynchronous: true
                Layout.alignment: Qt.AlignVCenter
            }
        }
    }
}