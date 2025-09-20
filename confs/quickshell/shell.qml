import qs.modules.popups
import Quickshell
import QtQuick  // for Text
import Quickshell.Io // for Process
import Quickshell.Hyprland
import QtQuick.Controls
import QtQuick.Layouts

//import qs.modules.bar as Bar

ShellRoot {
    VolumePopUp {}
    PanelWindow {

        anchors {
            top: true
            left: true
            right: true
        }

        implicitHeight: 40
        color: "#1f1f1fff"
        //color: "rgba(0, 209, 178, 1)"

        //Text {
        //id: clock
        //color: "white"
        ////anchors.centerIn: parent

        //Timer {
        //interval: 1000
        //running: true
        //repeat: true
        //onTriggered: clockProc.running = true
        //}

        //Rectangle {
        //implicitWidth: 80
        //color: "red"
        //implicitHeight: 40
        //}

        //Rectangle {
        //implicitWidth: 60
        //color: "green"
        //implicitHeight: 75
        //}
        //Process {
        //id: clockProc

        //command: ["date", "+%a %d %B %Y | %T"]

        //running: true

        //stdout: StdioCollector {
        //onStreamFinished: clock.text = this.text
        //}
        //}
        //Row {

        //function x() {
        //}

        ////Text {
        ////id: b
        ////text: qsTr("text")
        ////}
        //Button {
        //text: "click me"
        //onClicked: bb += 1
        //}

        //Text {
        //id: a
        //text: "" + bb + ""
        //}
        //}

        ////ColumnLayout {
        ////Quick.Text {
        ////id: text
        ////text: "Hello World!"
        ////}

        ////Quick.Button {
        ////text: "Make the text red"
        ////onClicked: text.color = "red"
        ////}
        ////}
        //}

        RowLayout {
            id: m
            property int bb: 0
            anchors.fill: parent

            Text {
                id: left
                text: m.bb
                color: "red"
            }

            Button {
                id: button
                onClicked: {
                    m.bb + 1;
                }
                text: "Hellow"
            }
        }
        //FloatingWindow {

        ////Timer {
        ////// assign an id to the object, which can be
        ////// used to reference it
        ////id: timer
        ////property bool invert: false // a custom property

        ////// change the value of invert every half second
        ////running: true
        ////repeat: true
        ////interval: 500 // ms
        ////onTriggered: timer.invert = !timer.invert
        ////}

        //// change the window's color when timer.invert changes
        //color: "green"
        //Text {
        //id: "s"
        //text: qsTr("text")
        //}
        //}
    }
}
