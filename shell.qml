//@ pragma UseQApplication
//@ pragma Env QS_NO_RELOAD_POPUP=1
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic

import Quickshell

ShellRoot {
    Scope {
        Taskbar {

        }
        CornerWindow {
            corner: RoundCorner.CornerEnum.TopLeft
            cornerColor: "black"
            exclusionMode: ExclusionMode.Ignore
        }
        CornerWindow {
            required property ShellScreen modelData
            screen: modelData
            corner: RoundCorner.CornerEnum.TopRight
            cornerColor: "black"
            exclusionMode: ExclusionMode.Ignore
        }
        CornerWindow {
            required property ShellScreen modelData
            screen: modelData
            corner: RoundCorner.CornerEnum.BottomLeft
            cornerColor: "black"
            exclusionMode: ExclusionMode.Ignore
        }
        CornerWindow {
            required property ShellScreen modelData
            screen: modelData
            corner: RoundCorner.CornerEnum.BottomRight
            cornerColor: "black"
            exclusionMode: ExclusionMode.Ignore
        }
    }
}