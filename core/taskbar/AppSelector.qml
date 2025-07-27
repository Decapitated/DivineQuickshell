pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import "../../singletons/"

RowLayout {
    spacing: 16
    Repeater {
        model: ToplevelManager.toplevels.values

        WrapperMouseArea {
            id: imageWrapper
            required property Toplevel modelData

            hoverEnabled: true

            Layout.fillHeight: true
            implicitWidth: height

            onPressed: {
                let backupPos = Cursor.cursorPos
                modelData.activate()
                Cursor.moveCursor(backupPos)
            }

            Image {
                id: appImage
                property DesktopEntry entry: DesktopEntries.byId(imageWrapper.modelData.appId)
                property string appName: {
                    if(entry) {
                        return entry.name;
                    }
                    return imageWrapper.modelData.appId;
                }
                property string iconName: {
                    if(entry) {
                        if(entry.icon.length > 0) {
                            return entry.icon;
                        }
                        return entry.name.toLowerCase().replace(" ", "-");
                    }
                    return imageWrapper.modelData.appId.toLowerCase().replace(" ", "-")
                }

                anchors.fill: parent

                source: Quickshell.iconPath(iconName)

                scale: (imageWrapper.containsMouse) ? 1.25 : 1.0 

                Behavior on scale {
                    PropertyAnimation { duration: 100 }
                }

                LazyLoader {
                    active: imageWrapper.containsMouse
                    component: AppView {}
                }
    
                component AppView: PopupWindow {
                    anchor.item: imageWrapper
                    visible: true
                    anchor.edges: Edges.Top | Edges.Left
                    anchor.gravity: Edges.Top | Edges.Right
                    anchor.rect.x: -(width / 2.0) + (imageWrapper.width / 2.0)
                    anchor.rect.y: -12

                    implicitWidth: 200
                    implicitHeight: 200 * 0.5625 + 16 + 16

                    color: "transparent"

                    WrapperRectangle {
                        anchors.fill: parent
                        color: Theme.backgroundColor
                        radius: 8
                        margin: 8

                        ColumnLayout {
                            clip: true
                            spacing: 0

                            Flickable {
                                id: titleFlickable
                                Layout.fillWidth: true
                                Layout.fillHeight: true

                                contentWidth: contentItem.childrenRect.width
                                contentHeight: contentItem.childrenRect.height

                                property int endX: contentWidth - width

                                Text {
                                    text: imageWrapper.modelData.title // appImage.appName
                                    color: Theme.fontColor
                                    font.pixelSize: 12
                                }

                                Behavior on contentX {
                                    NumberAnimation { duration: 500 }
                                }

                                Timer {
                                    interval: 2000; running: true; repeat: true
                                    onTriggered: {
                                        if(titleFlickable.contentX == titleFlickable.endX) {
                                            titleFlickable.contentX = 0
                                        } else {
                                            titleFlickable.contentX = titleFlickable.endX
                                        }
                                    }
                                }
                            }
                            ClippingWrapperRectangle {
                                Layout.fillWidth: true
                                Layout.alignment: Qt.AlignBottom
                                implicitHeight: width * 0.5625
                                radius: 8
                                color: "transparent"
                                ScreencopyView {
                                    captureSource: imageWrapper.modelData
                                    live: true
                                    constraintSize: Qt.size(implicitWidth, implicitHeight)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        Cursor.cursorPos // Call this to start singleton process.
    }
}