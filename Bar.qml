import Quickshell

Scope {
    id: root
    
    default property var child
    property int type: 0

    Variants {
        model: Quickshell.screens

        PanelWindow {
            property var modelData
            screen: modelData

            anchors {
                top: root.type > 1 || root.type == 0
                bottom: root.type > 1 || root.type == 1
                left: root.type <= 2
                right: root.type < 2 || root.type == 3
            }

            implicitHeight: 30
            implicitWidth: 30


            data: root.child
        }
    }
}
