//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

ShellRoot {
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
        // Bar { type: 0 // Top
        // }
        // Bar { type: 3 // Right
        // }
        // Bar { type: 2 // Left
        // }
        CornerWindow {
            corner: RoundCorner.CornerEnum.BottomLeft
        }
        CornerWindow {
            corner: RoundCorner.CornerEnum.BottomRight
        }
        CornerWindow {
            corner: RoundCorner.CornerEnum.TopLeft
            cornerColor: "black"
        }
        CornerWindow {
            corner: RoundCorner.CornerEnum.TopRight
            cornerColor: "black"
        }
        CornerWindow {
            corner: RoundCorner.CornerEnum.BottomLeft
            cornerColor: "black"
            exclusionMode: ExclusionMode.Ignore
        }
        CornerWindow {
            corner: RoundCorner.CornerEnum.BottomRight
            cornerColor: "black"
            exclusionMode: ExclusionMode.Ignore
        }
    }
}