import Quickshell
import QtQuick
import QtQuick.Layouts

import "../../widgets/"
import "../../singletons/"

CustomButton {
    id: root

    margin: 4
    radius: 8

    ColumnLayout {
        spacing: 0

        TimeWidget {
            Layout.alignment: Qt.AlignRight
            font.pixelSize: 11
            color: {
                if(root.toggled && !root.containsMouse) {
                    return "black";
                }
                return Theme.fontColor;
            }

            Behavior on color {
                ColorAnimation { duration: 100 }
            }
        }
        DateWidget {
            Layout.alignment: Qt.AlignRight
            font.pixelSize: 11
            color: {
                if(root.toggled && !root.containsMouse) {
                    return "black";
                }
                return Theme.fontColor;
            }

            Behavior on color {
                ColorAnimation { duration: 100 }
            }
        }
    }
}