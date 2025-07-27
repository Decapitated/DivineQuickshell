//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic

import Quickshell

import "./core/"
import "./core/taskbar/"
import "./widgets/"

ShellRoot {
    Scope {
        Variants {
            id: screenVariant
            model: Quickshell.screens
            Scope {
                id: screenScope
                required property ShellScreen modelData
                Taskbar {
                    screen: screenScope.modelData
                }
                // Test Window
                // PanelWindow {
                //     WlrLayershell.layer: WlrLayer.Bottom
                //     anchors.left: true
                //     anchors.right: true
                //     anchors.top: true
                //     anchors.bottom: true
                //     color: "transparent"
                // }
                // Screen Corners
                ScreenCorners {}
            }
        }
    }
}