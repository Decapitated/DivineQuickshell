pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland

import QtQuick
import QtQuick.Layouts

import "../widgets"

WrapperRectangle {
    id: root
    color: "transparent"
    radius: width
    margin: 2

    required property HyprlandWorkspace workspace

    GridLayout {
        columns: 2
        rowSpacing: 0
        columnSpacing: 0

        Repeater {
            id: repeater
            model: root.workspace.toplevels

            WrapperItem {
                id: clientWrapper
                required property HyprlandToplevel modelData

                Layout.fillWidth: true
                implicitHeight: width
                margin: 0

                AppImage {
                    appId: (clientWrapper.modelData.wayland != null) ? clientWrapper.modelData.wayland.appId : ""
                }
            }
        }
    }
}