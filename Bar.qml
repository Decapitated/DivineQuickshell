pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

PanelWindow {
    property double margin: 8
    property double maxSize: 16 * 2.5
    // 0 = Top; 1 = Bottom; 2 = Left; 3 = Right.
    property int type: 0

    color: Theme.backgroundColor
    surfaceFormat.opaque: false

    anchors {
        top: type > 1 || type == 0
        bottom: type > 1 || type == 1
        left: type <= 2
        right: type < 2 || type == 3
    }

    property double size: maxSize + margin
    implicitHeight: size
    implicitWidth: size
}