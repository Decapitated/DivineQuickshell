pragma ComponentBehavior: Bound
import Quickshell
import Quickshell.Wayland
import QtQuick

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: root
            required property ShellScreen modelData
            screen: modelData

            property int margins: 8
            property int spacing: 8
            property int columns: 7
            property double availableWidth: ((width - margins * 2) - (spacing * (columns - 1))) / columns

            // WlrLayershell.layer: WlrLayer.Top
            color: "red"
            anchors {
                left: true
                right: true
                top: true
            }

            implicitHeight: (width / columns) * 0.5625

            Flow {
                anchors.fill: parent
                anchors.margins: root.margins
                spacing: root.spacing

                Repeater {
                    model: ToplevelManager.toplevels.values

                    ScreencopyView {
                        required property var modelData
                        captureSource: modelData
                        live: true

                        constraintSize: Qt.size(root.availableWidth, root.availableWidth * 0.5625)
                        
                        layer.enabled: true

                        onHasContentChanged: {
                            console.log("Has Content changed:", hasContent, sourceSize, captureSource)
                            console.log(modelData.appId, modelData.title)
                        }

                        onStopped: {
                            console.log("Video Stream ended.")
                        }
                    }
                }
                
            }
        }
    }
}