// VolumeWidget.qml - Floating OSD for Volume Control
import QtQuick
import Quickshell.Services.Pipewire
import "../../theme"

Item {
    id: volumeWidget
    
    // This widget is now invisible in the panel - it just handles the OSD
    visible: false
    width: 0
    height: 0
    
    property int scrollStep: 1
    property bool initialized: false
    
    // Track PipeWire sink
    PwObjectTracker { objects: [ Pipewire.defaultAudioSink ] }
    
    Connections {
        target: Pipewire.defaultAudioSink?.audio ?? null
        function onVolumeChanged() {
            updateOSD()
            if (initialized) {
                osd.show()
            }
        }
        function onMutedChanged() {
            updateOSD()
            if (initialized) {
                osd.show()
            }
        }
    }
    
    Component.onCompleted: {
        // Initialize OSD values without showing it
        updateOSD()
        // Mark as initialized after a brief delay to avoid startup triggers
        Qt.callLater(() => { initialized = true })
    }
    
    // Update OSD display
    function updateOSD() {
        var audio = Pipewire.defaultAudioSink?.audio
        if (!audio) return
        
        var volume = Math.round(audio.volume * 100)
        osd.value = volume
        osd.muted = audio.muted
        
        // Update icon SVG path based on volume level and muted state
        if (audio.muted) {
            // Muted icon
            osd.iconSvgPath = "M813-56 681-188q-28 20-60.5 34.5T553-131v-62q23-7 44.5-15.5T638-231L473-397v237L273-360H113v-240h156L49-820l43-43 764 763-43 44Zm-36-232-43-43q20-34 29.5-71.92Q773-440.85 773-481q0-103.32-60-184.66T553-769v-62q124 28 202 125.5T833-481q0 51-14 100t-42 93ZM643-422l-90-90v-130q47 22 73.5 66t26.5 96q0 15-2.5 29.5T643-422ZM473-592 369-696l104-104v208Zm-60 286v-150l-84-84H173v120h126l114 114Zm-42-192Z"
        } else if (volume === 0) {
            // Volume at 0%
            osd.iconSvgPath = "M280-360v-240h160l200-200v640L440-360H280Zm60-60h127l113 109v-337L467-540H340v120Zm119-60Z"
        } else if (volume <= 50) {
            // Volume low (1-50%)
            osd.iconSvgPath = "M200-360v-240h160l200-200v640L360-360H200Zm420 48v-337q54 17 87 64t33 105q0 59-33 105t-87 63ZM500-648 387-540H260v120h127l113 109v-337ZM378-480Z"
        } else {
            // Volume high (51-100%+)
            osd.iconSvgPath = "M560-131v-62q97-28 158.5-107.5T780-481q0-101-61-181T560-769v-62q124 28 202 125.5T840-481q0 127-78 224.5T560-131ZM120-360v-240h160l200-200v640L280-360H120Zm420 48v-337q55 17 87.5 64T660-480q0 57-33 104t-87 64ZM420-648 307-540H180v120h127l113 109v-337Zm-94 168Z"
        }
    }
    
    // Floating OSD window
    FloatingOSD {
        id: osd
        accentColor: ColorScheme.accentVolume
        autoHideDuration: 3000
    }
    
    // Global mouse wheel handler for volume control
    // This needs to be added to your main shell.qml as a MouseArea covering the screen
    // For now, we'll create a separate handler
    
    Connections {
        target: volumeWidget.parent
        
        function onWheel(wheel) {
            // Only handle if Ctrl or Alt is pressed (to avoid conflicts)
            if (!(wheel.modifiers & Qt.ControlModifier)) return
            
            wheel.accepted = true
            
            var audio = Pipewire.defaultAudioSink?.audio
            if (!audio) return
            
            var delta = 0
            
            // Trackpad horizontal swipe
            if (wheel.pixelDelta.x !== 0) {
                delta = wheel.pixelDelta.x > 0 ? scrollStep : -scrollStep
            }
            // Mouse wheel vertical
            else if (wheel.angleDelta.y !== 0 && wheel.pixelDelta.x === 0 && wheel.pixelDelta.y === 0) {
                delta = wheel.angleDelta.y > 0 ? scrollStep : -scrollStep
            }
            
            if (!delta) return
            
            var currentVolume = Math.round(audio.volume * 100)
            var newVolume = Math.max(0, Math.min(100, currentVolume + delta))
            
            audio.volume = newVolume / 100
            audio.muted = false
            
            updateOSD()
            osd.show()
        }
    }
}
