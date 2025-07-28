pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import "clients"

Singleton {
    id: root

    readonly property list<Client> clients: {
        if(clientsProc.rawClients == undefined) return [];
        let clientComponent = Qt.createComponent("./clients/Client.qml")
        let newClients = [];
        for(let obj of clientsProc.rawClients) {
            let client = clientComponent.createObject();
            client.load(obj);
            newClients.push(client);
        }
        return newClients;
    }

    Process {
        id: clientsProc
        command: ["hyprctl", "clients", "-j"]
        running: true

        property var rawClients

        stdout: StdioCollector {
            onStreamFinished: {
                clientsProc.rawClients = JSON.parse(text);
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: clientsProc.running = true
    }
}