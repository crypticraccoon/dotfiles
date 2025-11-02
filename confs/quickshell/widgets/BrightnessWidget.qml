import QtQuick 2.15
import QtQuick.Controls 2.15
import Quickshell.Io
import "../theme" as Theme

Item {
    id: brightnessWidget
    width: 140
    height: 30

    property int currentBrightness: 0
    property int maxBrightness: 100
    property int scrollStep: 1

    Timer {
        id: refreshTimer
        interval: 5000
        running: false
        repeat: true
        onTriggered: getBrightnessProcess.running = true
    }

    Timer {
        id: updateTimer
        interval: 200
        running: false
        repeat: false
        onTriggered: getBrightnessProcess.running = true
    }

    Component.onCompleted: {
        getMaxBrightnessProcess.running = true
        getBrightnessProcess.running = true
        refreshTimer.start()
    }

    function updateBrightnessDisplay() {
        if (maxBrightness > 0) {
            var pct = Math.round(currentBrightness / maxBrightness * 100)
            brightnessText.text = pct + "%"
            if (brightnessSlider.value !== pct) {
                brightnessSlider.value = pct
            }
        }
    }

    function adjustBrightness(delta) {
        if (maxBrightness > 0) {
            var curPct = Math.round(currentBrightness / maxBrightness * 100)
            var newPct = Math.max(1, Math.min(100, curPct + delta))
            setBrightnessProcess.setBrightnessPercentage(newPct)
            currentBrightness = Math.round(newPct / 100 * maxBrightness)
            brightnessText.text = newPct + "%"
            brightnessSlider.value = newPct
            updateTimer.restart()
        }
    }

    Process {
        id: getBrightnessProcess
        command: ["brightnessctl", "get"]
        stdout: StdioCollector {
            onStreamFinished: {
                var out = text.trim()
                if (out) {
                    currentBrightness = parseInt(out)
                    updateBrightnessDisplay()
                }
            }
        }
    }

    Process {
        id: getMaxBrightnessProcess
        command: ["brightnessctl", "max"]
        stdout: StdioCollector {
            onStreamFinished: {
                var out = text.trim()
                if (out) {
                    maxBrightness = parseInt(out)
                    updateBrightnessDisplay()
                }
            }
        }
    }

    Process {
        id: setBrightnessProcess
        function setBrightnessPercentage(p) {
            command = ["brightnessctl", "set", p + "%"]
            running = true
        } 
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
        onWheel: function(wheel) {
            wheel.accepted = true
            var d = wheel.angleDelta.y > 0 ? scrollStep : -scrollStep
            if (wheel.modifiers & Qt.ControlModifier) {
                d = wheel.angleDelta.y > 0 ? 1 : -1
            } else if (wheel.modifiers & Qt.ShiftModifier) {
                d = wheel.angleDelta.y > 0 ? 10 : -10
            }
            adjustBrightness(d)
        }
    }

    Row {
        anchors.fill: parent
        anchors.topMargin: Theme.WidgetStyle.outerMargin
        anchors.bottomMargin: Theme.WidgetStyle.outerMargin
        spacing: 8

        Text {
            id: brightnessText
            text: "0%"
            color: "white"
            font.pixelSize: 14
            font.bold: true
            width: 30
            horizontalAlignment: Text.AlignRight
            anchors.verticalCenter: parent.verticalCenter
        }

        Slider {
            id: brightnessSlider
            from: 1
            to: 100
            width: parent.width - brightnessText.width - spacing - anchors.margins * 2
            height: 18
            anchors.verticalCenter: parent.verticalCenter

            background: Rectangle {
                anchors.fill: parent
                color: '#404040'
                radius: 30
               
                anchors.verticalCenter: parent.verticalCenter

                // Inner fill with optical roundness
                // Since both rectangles share the same bounds (no explicit padding),
                // we reduce the inner radius slightly for optical balance
                Rectangle {
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width * (brightnessSlider.value - brightnessSlider.from) / (brightnessSlider.to - brightnessSlider.from)
                    height: 18
                    color: '#82ebb4'
                    radius: 26  // Optical roundness: 30 - 4 = 26
                }
            }

            handle: Rectangle {
                visible: false
                width: 0
                height: 0
            }

            onMoved: {
                setBrightnessProcess.setBrightnessPercentage(Math.round(value))
                currentBrightness = Math.round(value / 100 * maxBrightness)
                brightnessText.text = Math.round(value) + "%"
                updateTimer.restart()
            }
        }
    }
}
