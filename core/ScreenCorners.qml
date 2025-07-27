import Quickshell

import "../widgets/"

Scope {
    property ShellScreen screen
    CornerWindow {
        screen: screen
        corner: RoundCorner.CornerEnum.TopLeft
        cornerColor: "black"
        exclusionMode: ExclusionMode.Ignore
    }
    CornerWindow {
        screen: screen
        corner: RoundCorner.CornerEnum.TopRight
        cornerColor: "black"
        exclusionMode: ExclusionMode.Ignore
    }
    CornerWindow {
        screen: screen
        corner: RoundCorner.CornerEnum.BottomLeft
        cornerColor: "black"
        exclusionMode: ExclusionMode.Ignore
    }
    CornerWindow {
        screen: screen
        corner: RoundCorner.CornerEnum.BottomRight
        cornerColor: "black"
        exclusionMode: ExclusionMode.Ignore
    }
}