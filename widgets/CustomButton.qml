import Quickshell.Widgets
import QtQuick

import "../singletons"

WrapperMouseArea {
    id: root
    default property var child
    property alias margin: wrapperRect.margin
    property alias radius: wrapperRect.radius
    property bool toggled: false

    hoverEnabled: true

    WrapperRectangle {
        id: wrapperRect

        color: {
            if(root.containsMouse) {
                if(root.toggled) {
                    return Qt.rgba(0.5, 0.5, 0.5, 0.2);
                } else {
                    return Qt.rgba(0.5, 0.5, 0.5, 0.1);
                }
            } else if(root.toggled) {
                return Theme.fontColor;
            }
            return "transparent";
        }
                
        Behavior on color {
            ColorAnimation { duration: 100 }
        }

        child: root.child
    }
}