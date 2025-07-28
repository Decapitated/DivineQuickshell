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
                color: "red"
                workspace: folderWrapper.modelData
            }
        }
    }
}