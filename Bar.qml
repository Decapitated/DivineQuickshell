pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

Scope {
    id: root
    
    default property var child: null
    // 0 = Top; 1 = Bottom; 2 = Left; 3 = Right.
    property int type: 0

    property color color: Theme.backgroundColor

    property double margin: 8
    property double maxSize: 16 * 2.5

    Variants {
        id: screenVariant
        model: Quickshell.screens

        PanelWindow {
            id: panel
            required property ShellScreen modelData
            screen: modelData

            color: root.color
            surfaceFormat.opaque: false

            anchors {
                top: root.type > 1 || root.type == 0
                bottom: root.type > 1 || root.type == 1
                left: root.type <= 2
                right: root.type < 2 || root.type == 3
            }

            property double size: root.maxSize + root.margin
            implicitHeight: size
            implicitWidth: size

            data: root.child
        }
    }
}
