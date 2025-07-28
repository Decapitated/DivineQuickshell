import QtQuick

QtObject {
    property string address
    property bool mapped
    property bool hidden
    property point at
    property size size
    property int workspaceId
    property string workspaceName
    property bool floating
    property bool pseudo
    property int monitor
    property string clientClass
    property string title
    property string initialClass
    property string initialTitle
    property int pid
    property bool xwayland
    property bool pinned
    property int fullscreen
    property int fullscreenClient
    property var grouped
    property var tags
    property string swallowing
    property int focusHistoryID
    property bool inhibitingIdle
    property string xdgTag
    property string xdgDescription

    function load(json) {
        const infoComponent = Qt.createComponent("WorkspaceInfo.qml");
        for(let key in json) {
            switch(key) {
                case "at": {
                    this[key] = Qt.point(json[key][0], json[key][1])
                    break;
                }
                case "size": {
                    this[key] = Qt.size(json[key][0], json[key][1])
                    break;
                }
                case "workspace": {
                    this.workspaceId = json[key].id;
                    this.workspaceName = json[key].name;
                    break;
                }
                case "class":{
                    this.clientClass = json[key];
                    break;
                }
                default: {
                    this[key] = json[key]
                }
            }
        }
    }
}