//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic

import Quickshell
import QtQuick
import QtQuick.Layouts

ShellRoot {
    Scope {
        Bar { // Top Bar
            type: 0 // Top
            RowLayout {
                anchors {
                    fill: parent
                    rightMargin: 8
                    leftMargin: 8
                }
                spacing: 8

                ClockWidget {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignRight
                    horizontalAlignment: Qt.AlignRight
                }
                Text { text: "-"}
                DateWidget {
                    Layout.alignment: Qt.AlignRight
                }
            }
        }
        Bar { // Bottom Bar
            type: 1 // Bottom
            ClockWidget { anchors.centerIn: parent }
        }
        Bar { // Left Bar
            type: 2 // Left
            ClockWidget { anchors.centerIn: parent }
        }
        AppDock {}
    }
}