import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import "../"
import "../../widgets/"
import "../../singletons/"

Scope {
    id: root
    required property ShellScreen screen
    property double height: 46

    enum Toggles { None, Power, DateTime }

    PanelWindow {
        id: taskbar
        screen: root.screen

        color: Theme.backgroundColor
        surfaceFormat.opaque: false

        implicitHeight: root.height

        property bool toggled: false
        property int toggle: Taskbar.Toggles.None

        anchors {
            left: true
            bottom: true
            right: true
        }

        WrapperMouseArea {
            rightMargin: 16
            anchors.fill: parent

            onContainsMouseChanged: {
                if(containsMouse) {
                    grab.active = true
                }
            }

            RowLayout {
                spacing: 8

                // Power Button
                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    PowerButton {
                        id: powerButton
                        toggled: taskbar.toggle == Taskbar.Toggles.Power && taskbar.toggled

                        onPressed: {
                            if(taskbar.toggle == Taskbar.Toggles.None || taskbar.toggle == Taskbar.Toggles.Power) {
                                taskbar.toggled = !taskbar.toggled
                                if(taskbar.toggled) {
                                    taskbar.toggle = Taskbar.Toggles.Power;
                                } else {
                                    taskbar.toggle = Taskbar.Toggles.None;
                                }
                            } else {
                                taskbar.toggle = Taskbar.Toggles.Power;
                            }
                        }
                    }
                }
                // App Selector
                WrapperItem {
                    Layout.alignment: Qt.AlignCenter
                    Layout.fillHeight: true
                    margin: 8
                    AppSelector {}
                }
                // Date & Time
                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    
                    DateTimeButton {
                        id: dateTimeButton

                        toggled: taskbar.toggle == Taskbar.Toggles.DateTime && taskbar.toggled

                        onPressed: {
                            if(taskbar.toggle == Taskbar.Toggles.None || taskbar.toggle == Taskbar.Toggles.DateTime) {
                                taskbar.toggled = !taskbar.toggled;
                                if(taskbar.toggled) {
                                    taskbar.toggle = Taskbar.Toggles.DateTime;
                                } else {
                                    taskbar.toggle = Taskbar.Toggles.None;
                                }
                            } else {
                                taskbar.toggle = Taskbar.Toggles.DateTime;
                            }
                        }

                        // onContainsMouseChanged: {
                        //     if(containsMouse) {
                        //         grab.active = true
                        //     }
                        // }
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
    // Power Popup
    PopupWindow {
        id: powerPopup
        anchor.item: powerButton
        anchor.edges: Edges.Top | Edges.Left
        anchor.gravity: Edges.Top | Edges.Right
        anchor.rect.y: -4

        implicitWidth: 150
        implicitHeight: 200
        color: "transparent"

        visible: powerButton.toggled

        WrapperMouseArea {
            anchors.fill: parent

            hoverEnabled: true

            onContainsMouseChanged: {
                if(containsMouse) {
                    grab.active = true
                }
            }

            WrapperRectangle {
                radius: 16
                leftMargin: 16
                rightMargin: 16
                topMargin: 8
                bottomMargin: 8
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
    // DateTime Popup
    PopupWindow {
        id: dateTimePopup
        anchor.item: dateTimeButton
        anchor.edges: Edges.Top | Edges.Right
        anchor.gravity: Edges.Top | Edges.Right
        anchor.rect.y: -4

        implicitWidth: 150
        implicitHeight: 200
        color: "transparent"

        visible: dateTimeButton.toggled

        WrapperMouseArea {
            anchors.fill: parent

            hoverEnabled: true

            onContainsMouseChanged: {
                if(containsMouse) {
                    grab.active = true
                }
            }

            WrapperRectangle {
                radius: 16
                leftMargin: 16
                rightMargin: 16
                topMargin: 8
                bottomMargin: 8
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
    HyprlandFocusGrab {
        id: grab
        windows: [ taskbar, powerPopup, dateTimePopup ]
        onCleared: {
            taskbar.toggled = false
            taskbar.toggle = Taskbar.Toggles.None
            console.log("Cleared")
        }
    }
}