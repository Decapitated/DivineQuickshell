import Quickshell
import Quickshell.Widgets
import QtQuick.Layouts

Scope {
    // AppDock {}
    Bar { type: 1 // Bottom
        WrapperItem {
            leftMargin: 16
            rightMargin: 16

            RowLayout {
                spacing: 8

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
        corner: RoundCorner.CornerEnum.BottomLeft
    }
    CornerWindow {
        corner: RoundCorner.CornerEnum.BottomRight
    }
}