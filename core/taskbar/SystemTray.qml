import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray

import QtQuick
import QtQuick.Layouts

RowLayout {
    Repeater {
        model: SystemTray.items.values

        WrapperMouseArea {
            id: trayItemWrapper
            required property SystemTrayItem modelData

            Layout.fillHeight: true
            implicitWidth: height

            onPressed: {
                trayItemAnchor.open()
            }

            IconImage {
                source: trayItemWrapper.modelData.icon
            }

            QsMenuAnchor {
                id: trayItemAnchor

                menu: trayItemWrapper.modelData.menu
                
                anchor.item: trayItemWrapper
                anchor.edges: Edges.Top | Edges.Right
                anchor.gravity: Edges.Top | Edges.Left
            }
        }
    }
}