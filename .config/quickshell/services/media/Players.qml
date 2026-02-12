pragma Singleton

import Quickshell
import Quickshell.Services.Mpris
import QtQml
import Quickshell.Io

Singleton {
    id: root

    // =========================
    // PROPIEDADES
    // =========================
    readonly property list<MprisPlayer> list: Mpris.players.values
    readonly property MprisPlayer active: list[0] ?? null

    // Reproducción / Progreso
    property int position: active?.position ?? 0
    property int length: active?.length ?? 0
    property bool isPlaying: active?.isPlaying ?? false

    Timer {
        id: progressTimer
        interval: 500
        running: isPlaying
        repeat: true
        onTriggered: {
            if (active) {
                root.position = active.position
                root.length = active.length
                if (root.isPlaying !== active.isPlaying) {
                    root.isPlaying = active.isPlaying
                }
            }
        }
    }

    // =========================
    // FUNCIONES DE CONTROL
    // =========================
    function play() { 
        if (!active) return
        if (active.canPlay) {
            active.play()
            root.isPlaying = true
            if (!progressTimer.running) progressTimer.start()
        }
    }

    function pause() { 
        if (!active) return
        if (active.canPause) {
            active.pause()
            root.isPlaying = false
            if (progressTimer.running) progressTimer.stop()
        }
    }

    function playPause() { 
            if (active.isPlaying) {
                active.pause()
                root.isPlaying = false
                if (progressTimer.running) progressTimer.stop()
            } else {
                active.play()
                root.isPlaying = true
                if (!progressTimer.running) progressTimer.start()
            }
        }


    function previous() { if (active?.canGoPrevious) active.previous() }
    function next() { if (active?.canGoNext) active.next() }

    function stop() { 
        active?.stop()
        progressTimer.stop()
        root.position = 0
        root.isPlaying = false
    }

    // =========================
    // FUNCIONES DE SCRUBBING
    // =========================
    function setPosition(ms) {
        if (active?.canSeek) {
            active.position = ms
            root.position = ms
        }
    }

    // =========================
    // FUNCIONES DE INFORMACIÓN
    // =========================
    function getTrackTitle() { return active?.trackTitle ?? "No track playing" }
    function getTrackArtist() { return active?.trackArtist ?? "Unknown artist" }
    function getTrackArt() { return active?.trackArtUrl ?? "" }
    function getTrackInfo() {
        if (!active) return "No active player"
        return `${getTrackArtist()} - ${getTrackTitle()}`
    }
    function listPlayers() { return list.map(p => p.identity).join("\n") }

    // =========================
    // CONEXIONES
    // =========================
    Connections {
        target: active
        function onPostTrackChanged() {
            if (active?.trackArtist && active?.trackTitle)
                console.log("Now playing: " + getTrackInfo())
            if (active?.trackArtUrl)
                console.log("Track art URL: " + active.trackArtUrl)
        }

        function onSeeked() {
            root.position = active.position
        }
    }

    // =========================
    // IPC PARA CONTROL REMOTO
    // =========================
    IpcHandler {
        target: "mpris"

        function getActive(prop: string): string {
            const active = root.active;
            return active ? active[prop] ?? "Invalid property" : "No active player";
        }

        function list(): string { return root.list.map(p => p.identity).join("\n"); }

        function play() { root.play() }
        function pause() { root.pause() }
        function playPause() { root.playPause() }
        function previous(): void { root.previous() }
        function next(): void { root.next() }
        function stop(): void { root.stop() }

        function getTrackArt(): string { return root.getTrackArt() }
        function getTrackPosition(): int { return root.position }
        function getTrackLength(): int { return root.length }
        function isPlaying(): bool { return root.isPlaying }
        function seek(ms: int): void { root.setPosition(ms) }
    }
}
