import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import "../../widgets/"
import "../../singletons/"

WrapperMouseArea {
    id: dateTime

    property bool toggled: false

    hoverEnabled: true

    WrapperRectangle {
        leftMargin: 8
        rightMargin: 8
        topMargin: 2
        bottomMargin: 2
        radius: 8
        color: {
            if(dateTime.containsMouse) {
                if(dateTime.toggled) {
                    return Qt.rgba(0.5, 0.5, 0.5, 0.2);
                } else {
                    return Qt.rgba(0.5, 0.5, 0.5, 0.1);
                }
            } else if(dateTime.toggled) {
                return "white";
            }
            return "transparent";
        }

        Behavior on color {
            ColorAnimation { duration: 100 }
        }
    
        ColumnLayout {
            spacing: 0

            TimeWidget {
                Layout.alignment: Qt.AlignRight
                font.pixelSize: 11
                color: {
                    if(dateTime.toggled && !dateTime.containsMouse) {
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
                    if(dateTime.toggled && !dateTime.containsMouse) {
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
}