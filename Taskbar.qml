import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

Scope {
    id: root
    property ShellScreen screen
    Bar {
        id: taskbar
        screen: root.screen
        type: 1 // Bottom
        WrapperItem {
            leftMargin: 16
            rightMargin: 16
            anchors.fill: parent

            RowLayout {
                spacing: 8

                CustomButton {
                    id: powerButton
                    text: "⏻"
                    font.pixelSize: 16 * 1.5

                    property bool toggled: false

                    onPressed: {
                        toggled = !toggled
                    }
                }

                ColumnLayout {
                    Layout.alignment: Qt.AlignRight
                    spacing: 0

                    TimeWidget {
                        Layout.alignment: Qt.AlignRight
                    }
                    DateWidget {
                        Layout.alignment: Qt.AlignRight
                    }
                }
            }
        }
    }
    CornerWindow {
        screen: root.screen
        corner: RoundCorner.CornerEnum.BottomLeft
    }
    CornerWindow {
        screen: root.screen
        corner: RoundCorner.CornerEnum.BottomRight
    }
    PopupWindow {
        anchor.item: powerButton
        anchor.edges: Edges.Top | Edges.Left
        anchor.gravity: Edges.Top | Edges.Right

        implicitWidth: 150
        implicitHeight: 200
        color: "transparent"
        
        visible: powerButton.toggled
        WrapperRectangle {
            radius: 16
            leftMargin: 16
            rightMargin: 16
            topMargin: 8
            bottomMargin: 8
            anchors.fill: parent
            color: Theme.backgroundColor
            ColumnLayout {
                Repeater {
                    model: 5
                    Text {
                        text: "Hello!"
                        color: Theme.fontColor
                    }
                }
            }
        }
    }
}