import Quickshell
import Quickshell.Widgets
import QtQuick
import Qt5Compat.GraphicalEffects

import "../../singletons/"

WrapperMouseArea {
    id: root
    
    property bool toggled: false

    margin: 4
    implicitHeight: parent.height
    implicitWidth: height

    hoverEnabled: true

    WrapperRectangle {
        property real iconMargin: 8
        leftMargin: iconMargin
        rightMargin: iconMargin
        topMargin: iconMargin - 2.5
        bottomMargin: iconMargin + 2.5
        radius: width
        color: {
            if(root.containsMouse) {
                if(root.toggled) {
                    return Qt.rgba(0.5, 0.5, 0.5, 0.2);
                } else {
                    return Qt.rgba(0.5, 0.5, 0.5, 0.1);
                }
            } else if(root.toggled) {
                return "white";
            }
            return "transparent";
        }
                
        Behavior on color {
            ColorAnimation { duration: 100 }
        }

        Image {
            id: powerIcon
            source: '../../assets/icons/archlinux.svg'
            sourceSize.width: 64
            sourceSize.height: 64
            sourceClipRect: Qt.rect(0, 0, implicitWidth, implicitHeight)
            mipmap: true

            ColorOverlay {
                anchors.fill: powerIcon
                source: powerIcon
                color: {
                    if(!root.toggled || root.containsMouse) {
                        return Theme.fontColor
                    } else if(root.toggled) {
                        return "black";
                    }
                }
                
                Behavior on color {
                    ColorAnimation { duration: 100 }
                }
            }
        }
    }
}