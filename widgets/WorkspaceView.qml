pragma ComponentBehavior: Bound
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts

import "../singletons"
import "../singletons/clients"

Item {
    id: root
    property HyprlandWorkspace workspace

    property list<Client> workspaceClients: Clients.clients.filter((client) => client.workspaceId == workspace.id)

    Repeater {
        model: root.workspaceClients

        ScreencopyView {
            id: viewWrapper

            required property Client modelData
            property HyprlandToplevel toplevel: {
                const match = root.workspace.toplevels.values.find((top) => {
                    return top.address == modelData.address
                });
                return match;
            }

            x: (modelData.at.x / root.workspace.monitor.width) * root.width
            y: (modelData.at.y / root.workspace.monitor.height) * root.height
            implicitWidth: (modelData.size.width / root.workspace.monitor.width) * root.width
            implicitHeight: (modelData.size.height / root.workspace.monitor.width) * root.width

            captureSource: viewWrapper.toplevel.wayland
            live: true
            constraintSize: Qt.size(
                (modelData.size.width / root.workspace.monitor.width) * root.width,
                (modelData.size.height / root.workspace.monitor.width) * root.width
            )
        }
    }
}