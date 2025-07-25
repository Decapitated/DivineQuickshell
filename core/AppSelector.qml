pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Widgets
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts

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
                modelData.activate()
            }

            Image {
                property DesktopEntry entry: DesktopEntries.byId(imageWrapper.modelData.appId)
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

                PopupWindow {
                    anchor.item: imageWrapper
                    visible: imageWrapper.containsMouse
                    anchor.edges: Edges.Top | Edges.Left
                    anchor.gravity: Edges.Top | Edges.Right
                    anchor.rect.x: -(width / 2.0) + (imageWrapper.width / 2.0)
                    anchor.rect.y: -16

                    implicitWidth: 200
                    implicitHeight: 200 * 0.5625

                    color: "transparent"

                    ClippingWrapperRectangle {
                        anchors.fill: parent
                        color: "red"
                        radius: 8

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