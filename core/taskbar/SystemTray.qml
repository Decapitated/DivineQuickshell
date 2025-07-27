import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

RowLayout {
    Repeater {
        model: SystemTray.items.values

        IconImage {
            id: trayItem
            required property SystemTrayItem modelData

            source: modelData.icon

            Layout.fillHeight: true
            implicitWidth: height
        }
    }
}