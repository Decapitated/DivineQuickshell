pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import "../../singletons"
import "../../widgets"

RowLayout {
    spacing: 8
    Repeater {
        model: Hyprland.workspaces.values

        WrapperMouseArea {
            id: folderWrapper
            required property HyprlandWorkspace modelData

            property double aspect: (modelData.monitor) ? modelData.monitor.height / modelData.monitor.width : 9 / 16

            hoverEnabled: true

            Layout.fillHeight: true
            implicitWidth: implicitHeight

            onPressed: {
                modelData.activate()
            }

            WorkspaceFolder {
                id: folder
                workspace: folderWrapper.modelData

                scale: (folderWrapper.containsMouse) ? 1.15 : 1.0

                Behavior on scale {
                    PropertyAnimation { duration: 100 }
                }
            }

            LazyLoader {
                active: folderWrapper.containsMouse
                component: WorkspacePopup {}
            }

            component WorkspacePopup: PopupWindow {
                visible: true
                anchor.item: folder
                anchor.edges: Edges.Top | Edges.Left
                anchor.gravity: Edges.Top | Edges.Right
                anchor.rect.x: -(width / 2.0) + (folderWrapper.width / 2.0)
                anchor.rect.y: -12

                implicitWidth: 200
                implicitHeight: implicitWidth * folderWrapper.aspect

                WrapperRectangle {
                    anchors.fill: parent
                    color: "red"
                    
                    WorkspaceView {
                        workspace: folderWrapper.modelData
                    }
                }
            }
        }
    }

    Connections {
        target: Hyprland
        function onRawEvent(event: HyprlandEvent) {
            // console.log(event.name)
            switch(event.name) {
                case "activewindow":
                case "fullscreen":
                case "pin":
                case "changefloatingmode":
                case "movewindow":
                case "openwindow":
                case "closewindow": {
                    Hyprland.refreshToplevels();
                }
            }
        }
    }
}