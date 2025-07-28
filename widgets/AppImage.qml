import Quickshell
import Quickshell.Widgets
import QtQuick

Image {
    id: appImage

    property string appId: ""
    property DesktopEntry entry: (appId.length > 0) ? DesktopEntries.byId(appId) : null
    property string appName: {
        if(entry != null) {
            return entry.name;
        }
        return (appId.length > 0) ? appId : "undefined";
    }
    property string iconName: {
        if(entry != null) {
            if(entry.icon.length > 0) {
                return entry.icon;
            }
            return entry.name.toLowerCase().replace(" ", "-");
        }
        return (appId.length > 0) ? appId.toLowerCase().replace(" ", "-") : "undefined";
    }

    source: (iconName != "undefined") ? Quickshell.iconPath(iconName) : "root:/assets/icons/placeholder.svg"
}