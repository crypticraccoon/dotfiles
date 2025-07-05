import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Io // for Process
import Quickshell.Hyprland

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 30

    Text {
        id: clock

        anchors.centerIn: parent

        Process {
            id: clockProc

            command: ["date", "+%a %d %B %Y | %T"]

            running: true

            stdout: StdioCollector {
                onStreamFinished: clock.text = this.text
            }
        }
        Timer {
            interval: 1000
            running: true
            repeat: true
            onTriggered: clockProc.running = true
        }
    }
}
