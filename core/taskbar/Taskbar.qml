import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

import "../"
import "../../widgets/"
import "../../singletons/"

Scope {
    id: root
    required property ShellScreen screen
    property double height: 54

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

        WrapperItem {
            leftMargin: 0
            rightMargin: 8
            anchors.fill: parent

            RowLayout {
                spacing: 8

                // Power Button
                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    WrapperMouseArea {
                        id: powerButton
                        
                        margin: 8
                        implicitHeight: parent.height
                        implicitWidth: height

                        hoverEnabled: true

                        property bool toggled: taskbar.toggle == Taskbar.Toggles.Power && taskbar.toggled

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

                        WrapperRectangle {
                            property real iconMargin: 8
                            leftMargin: iconMargin
                            rightMargin: iconMargin
                            topMargin: iconMargin - 2.5
                            bottomMargin: iconMargin + 2.5
                            radius: width
                            color: {
                                if(powerButton.containsMouse) {
                                    if(powerButton.toggled) {
                                        return Qt.rgba(0.5, 0.5, 0.5, 0.2);
                                    } else {
                                        return Qt.rgba(0.5, 0.5, 0.5, 0.1);
                                    }
                                } else if(powerButton.toggled) {
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
                                        if(!powerButton.toggled || powerButton.containsMouse) {
                                            return Theme.fontColor
                                        } else if(powerButton.toggled) {
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
                    
                    WrapperMouseArea {
                        id: dateTime

                        anchors.right: parent.right
                        margin: 4
                        
                        hoverEnabled: true

                        property bool toggled: taskbar.toggle == Taskbar.Toggles.DateTime && taskbar.toggled

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

                        WrapperRectangle {
                            margin: 8
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
        // anchor.item: powerButton
        anchor.window: taskbar
        anchor.edges: Edges.Top | Edges.Left
        anchor.gravity: Edges.Top | Edges.Right
        anchor.rect.y: -4

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