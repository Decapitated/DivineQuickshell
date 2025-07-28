pragma ComponentBehavior: Bound
import Quickshell.Widgets
import Quickshell.Wayland
import Quickshell.Hyprland

import QtQuick
import QtQuick.Layouts

import "../types"

Item {
    id: root
    property HyprlandWorkspace workspace

    Repeater {
        model: root.workspace.toplevels.values.filter((toplevel) => toplevel.toplevel == null)
        
        WrapperItem {
            id: viewWrapper
            required property HyprlandToplevel modelData

            property Client client: {
                let clientComponent = Qt.createComponent("../types/Client.qml")
                let newClient = clientComponent.createObject();
                newClient.load(modelData.lastIpcObject);
                return newClient;
            }

            property size adjSize: Qt.size(
                (client.size.width / modelData.monitor.width) * root.width,
                (client.size.height / modelData.monitor.width) * root.width
            )

            x: (client.at.x / modelData.monitor.width) * root.width
            y: (client.at.y / modelData.monitor.height) * root.height
            implicitWidth: adjSize.width
            implicitHeight: adjSize.height

            ScreencopyView {
                captureSource: viewWrapper.modelData.wayland
                live: true
                constraintSize: viewWrapper.adjSize
            }
        }
    }
}