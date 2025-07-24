pragma ComponentBehavior: Bound

import Quickshell
import QtQuick

Scope {
    id: root
    
    default property Component child: null
    // 0 = Top; 1 = Bottom; 2 = Left; 3 = Right.
    property int type: 0
    property int limitMonitor: -1

    property color color: Theme.backgroundColor

    property double margin: 8
    property double maxSize: 16 * 2.5

    Variants {
        id: screenVariant
        property list<ShellScreen> screens: Quickshell.screens
        model: screens

        PanelWindow {
            id: panel
            required property ShellScreen modelData
            screen: modelData

            color: root.color
            surfaceFormat.opaque: false

            anchors {
                top: root.type > 1 || root.type == 0
                bottom: root.type > 1 || root.type == 1
                left: root.type <= 2
                right: root.type < 2 || root.type == 3
            }

            property int currentMonitor: {
                let foundIndex = -1;
                screenVariant.screens.find((elem, index) => {
                    if(elem.name == modelData.name) {
                        foundIndex = index;
                        return true;
                    }
                    return false;
                });
                return foundIndex;
            }

            property bool canShow: {
                console.log(root.limitMonitor < 0 || root.limitMonitor == currentMonitor);
                return root.limitMonitor < 0 || root.limitMonitor == currentMonitor;
            }
            property double size: (canShow && root.child != null) ? root.maxSize + root.margin : root.margin
            implicitHeight: size
            implicitWidth: size

            Loader {
                active: panel.canShow
                sourceComponent: root.child

                anchors.fill: parent

                onItemChanged: {
                    console.log(item)
                }
            }
        }
    }
}
