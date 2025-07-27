import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

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
                spacing: 0
                uniformCellSizes: true

                // Left
                WrapperRectangle {
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignLeft

                    color: "transparent"

                    RowLayout {
                        spacing: 0
                        // Power Button
                        WrapperItem {
                            Layout.fillHeight: true
                            implicitWidth: height
                            margin: 4

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

                                onContainsMouseChanged: {
                                    if(containsMouse) {
                                        grab.active = true
                                    }
                                }
                            }
                        }
                    }
                }
                // Middle
                WrapperRectangle {
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignCenter

                    color: "transparent"

                    RowLayout {
                        // App Selector
                        WrapperItem {
                            Layout.fillHeight: true
                            margin: 8
                            AppSelector {}
                        }
                    }
                }
                // Right
                WrapperRectangle {
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignRight

                    color: "transparent"

                    RowLayout {
                        spacing: 8
                        // System Tray
                        WrapperItem {
                            Layout.fillHeight: true
                            topMargin: 16
                            bottomMargin: 16

                            SystemTray {}
                        }
                        // Date & Time
                        WrapperItem {
                            Layout.fillHeight: true
                            topMargin: 4
                            bottomMargin: 4

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

                                onContainsMouseChanged: {
                                    if(containsMouse) {
                                        grab.active = true
                                    }
                                }
                            }
                        }
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
        anchor.rect.y: -8

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
                margin: 8
                color: Theme.backgroundColor

                ColumnLayout {
                    WrapperMouseArea {
                        property bool toggled: false
                        Layout.fillWidth: true
                        
                        WrapperRectangle {
                            margin: 8
                            radius: 8
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

                            Text {
                                text: "Restart"
                                color: Theme.fontColor
                            }
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
        anchor.rect.y: -9

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