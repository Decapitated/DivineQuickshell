pragma ComponentBehavior: Bound

import Quickshell.Widgets
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

import "../../singletons"
import "../../widgets"

RowLayout {
    spacing: 8
    Repeater {
        model: Hyprland.workspaces

        WrapperMouseArea {
            id: folderWrapper
            required property HyprlandWorkspace modelData

            hoverEnabled: true

            Layout.fillHeight: true
            implicitWidth: height

            onPressed: {
                modelData.activate()
            }

            WorkspaceFolder {
                workspace: folderWrapper.modelData

                scale: (folderWrapper.containsMouse) ? 1.15 : 1.0

                Behavior on scale {
                    PropertyAnimation { duration: 100 }
                }
            }
        }
    }
}