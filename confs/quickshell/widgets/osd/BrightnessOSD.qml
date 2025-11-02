// BrightnessOSD.qml - Floating OSD for Brightness Control
import QtQuick
import Quickshell.Io
import "../../theme"

Item {
    id: brightnessWidget
    
    // This widget is invisible in the panel - it just handles the OSD
    visible: false
    width: 0
    height: 0
    
    property int currentBrightness: 0
    property int maxBrightness: 100
    property int scrollStep: 1
    property bool initialized: false
    
    Timer {
        id: refreshTimer
        interval: 100  // Check every 100ms for faster response to keyboard shortcuts
        running: true
        repeat: true
        onTriggered: getBrightnessProcess.running = true
    }
    
    Timer {
        id: updateTimer
        interval: 50  // Quick verification after manual adjustment
        running: false
        repeat: false
        onTriggered: getBrightnessProcess.running = true
    }
    
    Timer {
        id: initTimer
        interval: 500  // Wait 500ms before marking as initialized
        running: false
        repeat: false
        onTriggered: initialized = true
    }
    
    Component.onCompleted: {
        getMaxBrightnessProcess.running = true
        getBrightnessProcess.running = true
        refreshTimer.start()
        initTimer.start()
    }
    
    function updateOSD() {
        if (maxBrightness > 0) {
            var percentage = Math.round(currentBrightness / maxBrightness * 100)
            osd.value = percentage
            updateIcon(percentage)
        }
    }
    
    function updateIcon(percentage) {
        // Material Design brightness icons
        if (percentage < 33) {
            // Brightness low (0-33%)
            osd.iconSvgPath = "M365-81q-21 0-42-2t-38-5q107-43 170-149t63-244q0-137-63-243T285-874q14-3 37-5t44-2q81 0 152.5 31.5t125.5 86Q698-709 729-636t31 155q0 82-31.5 155t-85 127.5Q590-144 518-112.5T365-81Z"
        } else if (percentage < 66) {
            // Brightness medium (33-66%)
            osd.iconSvgPath = "M382-880q81 0 152 30.5t124.5 84Q712-712 742.5-639T773-481q0 85-31 158.5T658-195q-53 54-124.5 84.5T381-80q-54 0-106-13t-87-33q88-66 136.5-158T373-479q0-104-49-197T187-833q35-20 87.5-33.5T382-880Z"
        } else {
            // Brightness high (66-100%)
            osd.iconSvgPath = "M480-80q-82 0-155-31.5t-127.5-86Q143-252 111.5-325T80-480q0-83 31.5-156t86-127Q252-817 325-848.5T480-880q83 0 156 31.5T763-763q54 54 85.5 127T880-480q0 82-31.5 155T763-197.5q-54 54.5-127 86T480-80Z"
        }
    }
    
    function adjustBrightness(delta) {
        if (maxBrightness > 0) {
            var currentPct = Math.round(currentBrightness / maxBrightness * 100)
            var newPct = Math.max(1, Math.min(100, currentPct + delta))
            
            // Immediately update UI for instant feedback
            var newBrightness = Math.round(newPct / 100 * maxBrightness)
            currentBrightness = newBrightness
            osd.value = newPct
            updateIcon(newPct)
            osd.show()
            
            // Then execute the actual brightness change
            setBrightnessProcess.setBrightnessPercentage(newPct)
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
                    var oldBrightness = currentBrightness
                    currentBrightness = parseInt(out)
                    updateOSD()
                    
                    // Show OSD if brightness changed (from keyboard shortcuts) and we're initialized
                    if (initialized && oldBrightness !== currentBrightness && oldBrightness !== 0) {
                        osd.show()
                    }
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
                    updateOSD()
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
    
    // Floating OSD window
    FloatingOSD {
        id: osd
        accentColor: ColorScheme.accentBrightness
        autoHideDuration: 3000
        muted: false
    }
    
    // Global mouse wheel handler for brightness control
    Connections {
        target: brightnessWidget.parent
        
        function onWheel(wheel) {
            // Only handle if Shift is pressed (to avoid conflicts)
            if (!(wheel.modifiers & Qt.ShiftModifier)) return
            
            wheel.accepted = true
            
            var delta = wheel.angleDelta.y > 0 ? scrollStep : -scrollStep
            
            // Adjust step size based on modifiers
            if (wheel.modifiers & Qt.ControlModifier) {
                delta = wheel.angleDelta.y > 0 ? 1 : -1
            } else if (wheel.modifiers & Qt.ShiftModifier) {
                delta = wheel.angleDelta.y > 0 ? 5 : -5
            }
            
            adjustBrightness(delta)
        }
    }
}