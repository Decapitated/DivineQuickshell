pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property size cursorPos: Qt.size(0, 0)
    property size nextCursorPos: Qt.size(0, 0)

    function moveCursor(pos: size) {
        nextCursorPos = pos;
        movecursorProc.running = true;
    }

    Process {
        id: cursorposProc
        command: ["hyprctl", "cursorpos"]
        running: true

        stdout: StdioCollector {
            onStreamFinished: {
                var split = this.text.split(", ")
                let x = parseInt(split[0])
                let y = parseInt(split[1])
                root.cursorPos.width = x;
                root.cursorPos.height = y;
            }
        }
    }

    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: cursorposProc.running = true
    }

    Process {
        id: movecursorProc
        command: ["hyprctl", "dispatch", "movecursor", `${root.nextCursorPos.width} ${root.nextCursorPos.height}`]
        running: false
    }
}