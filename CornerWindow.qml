import Quickshell
import QtQuick

Scope {
    Variants {
        id: screenVariant
        model: Quickshell.screens

        PanelWindow {
            id: panel
            required property ShellScreen modelData
            screen: modelData

            property int corner: RoundCorner.CornerEnum.TopLeft
            property int size: 16
            property color cornerColor: Theme.backgroundColor

            // Pass-Through mouse.
            mask: Region { item: roundCorner; intersection: Intersection.Xor }
            exclusionMode: ExclusionMode.Normal

            color: "transparent"
            anchors {
                top: corner == RoundCorner.CornerEnum.TopLeft || corner == RoundCorner.CornerEnum.TopRight
                bottom: corner == RoundCorner.CornerEnum.BottomLeft || corner == RoundCorner.CornerEnum.BottomRight
                left: corner == RoundCorner.CornerEnum.TopLeft || corner == RoundCorner.CornerEnum.BottomLeft
                right: corner == RoundCorner.CornerEnum.TopRight || corner == RoundCorner.CornerEnum.BottomRight
            }
            
            implicitWidth: size
            implicitHeight: size

            RoundCorner {
                id: roundCorner
                color: panel.cornerColor
                size: panel.size
                corner: panel.corner
            }
        }
    }
}
