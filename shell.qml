//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic

import Quickshell

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
                // AppDock {}
                // Screen Corners
                CornerWindow {
                    screen: screenScope.modelData
                    corner: RoundCorner.CornerEnum.TopLeft
                    cornerColor: "black"
                    exclusionMode: ExclusionMode.Ignore
                }
                CornerWindow {
                    screen: screenScope.modelData
                    corner: RoundCorner.CornerEnum.TopRight
                    cornerColor: "black"
                    exclusionMode: ExclusionMode.Ignore
                }
                CornerWindow {
                    screen: screenScope.modelData
                    corner: RoundCorner.CornerEnum.BottomLeft
                    cornerColor: "black"
                    exclusionMode: ExclusionMode.Ignore
                }
                CornerWindow {
                    screen: screenScope.modelData
                    corner: RoundCorner.CornerEnum.BottomRight
                    cornerColor: "black"
                    exclusionMode: ExclusionMode.Ignore
                }
            }
        }
    }
}