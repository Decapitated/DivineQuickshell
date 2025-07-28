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
    margin: 0

    required property HyprlandWorkspace workspace

    GridLayout {
        columns: 2
        rowSpacing: 2
        columnSpacing: 2

        Repeater {
            id: repeater
            model: root.workspace.toplevels

            WrapperItem {
                id: clientWrapper
                required property HyprlandToplevel modelData

                Layout.fillWidth: true
                Layout.fillHeight: true
                // height: implicitWidth
                margin: 0

                AppImage {
                    appId: (clientWrapper.modelData != null && clientWrapper.modelData.wayland != null) ? clientWrapper.modelData.wayland.appId : ""
                }
            }
        }
    }
}