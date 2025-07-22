import Quickshell
import QtQuick

Scope {
    Bar {
        type: 0 // Top
        ClockWidget { anchors.centerIn: parent }
    }
    Bar {
        type: 2 // Left
    }
}