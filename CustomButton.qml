import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls

Button {
    id: root
    text: "Button"

    implicitHeight: width

    property color color: "transparent"
    property color fontColor: Theme.fontColor
    property color borderColor: "transparent"

    background: Rectangle {
        radius: width
        color: root.color
        border.color: root.borderColor
    }

    contentItem: Text {
        text: root.text
        font: root.font
        color: root.fontColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    onPressed: {
        console.log("Power")
    }
}