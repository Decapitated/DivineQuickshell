pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import QtQuick

Scope {
    id: root
    
    default property var child: null
    // 0 = Top; 1 = Bottom; 2 = Left; 3 = Right.
    property int type: 0
    property color color: "white"

    Variants {
        model: Quickshell.screens
        PanelWindow {
            required property ShellScreen modelData
            screen: modelData

            color: root.color
            data: root.child

            surfaceFormat.opaque: false
            anchors {
                top: root.type > 1 || root.type == 0
                bottom: root.type > 1 || root.type == 1
                left: root.type <= 2
                right: root.type < 2 || root.type == 3
            }

            implicitHeight: 30
            implicitWidth: 30
        }
    }
}
