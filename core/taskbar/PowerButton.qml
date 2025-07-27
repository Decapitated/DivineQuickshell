import Quickshell
import QtQuick
import Qt5Compat.GraphicalEffects

import "../../singletons/"
import "../../widgets/"

CustomButton {
    id: root

    margin: 8
    radius: width

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