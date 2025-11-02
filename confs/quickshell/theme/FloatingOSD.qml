// FloatingOSD.qml - Floating OSD matching shell design
import QtQuick
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland

LazyLoader {
    id: osdLoader
    
    // Configuration properties
    property int value: 0
    property int maxValue: 100
    property bool muted: false
    property color accentColor: "#5c6bc0"
    property color iconColor: "#f0f0f0"
    property string iconSvgPath: ""
    
    // OSD behavior properties
    property int autoHideDuration: 3000
    property int fadeInDuration: 200
    property int fadeOutDuration: 300
    
    loading: false
    
    // Show function
    function show() {
        loading = true
        if (item) {
            item.showOSD()
        }
    }
    
    // Hide function
    function hide() {
        if (item) {
            item.hideOSD()
        }
    }
    
    PanelWindow {
        id: osdWindow
        
        property bool osdVisible: false
        
        implicitWidth: 40
        implicitHeight: 200
        visible: osdVisible && background.opacity > 0
        color: "transparent"
        mask: Region { item: background }
        
        // Position on left side, vertically centered
        anchors {
            left: true
            top: true
        }
        margins {
            left: 20
            top: (screen.height - height) / 2
        }
        
        // Auto-hide timer
        Timer {
            id: hideTimer
            interval: osdLoader.autoHideDuration
            repeat: false
            onTriggered: hideOSD()
        }
        
        // Show function with fade-in
        function showOSD() {
            fadeOutAnimation.stop()
            
            // If already visible, just restart the hide timer
            if (osdWindow.osdVisible && background.opacity > 0.9) {
                hideTimer.restart()
                return
            }
            
            osdWindow.osdVisible = true
            fadeInAnimation.start()
            hideTimer.restart()
        }
        
        // Hide function with fade-out
        function hideOSD() {
            if (hideTimer.running) {
                hideTimer.stop()
            }
            fadeOutAnimation.start()
        }
        
        // Fade in animation
        ParallelAnimation {
            id: fadeInAnimation
            NumberAnimation {
                target: background
                property: "opacity"
                from: background.opacity
                to: 1
                duration: osdLoader.fadeInDuration
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                target: contentContainer
                property: "opacity"
                from: contentContainer.opacity
                to: 1
                duration: osdLoader.fadeInDuration
                easing.type: Easing.OutCubic
            }
        }
        
        // Fade out animation
        ParallelAnimation {
            id: fadeOutAnimation
            NumberAnimation {
                target: background
                property: "opacity"
                from: background.opacity
                to: 0
                duration: osdLoader.fadeOutDuration
                easing.type: Easing.InCubic
            }
            NumberAnimation {
                target: contentContainer
                property: "opacity"
                from: contentContainer.opacity
                to: 0
                duration: osdLoader.fadeOutDuration
                easing.type: Easing.InCubic
            }
            onFinished: osdWindow.osdVisible = false
        }
        
        // Background with Material Design inlay
        Rectangle {
            id: background
            anchors.fill: parent
            anchors.topMargin: WidgetStyle.outerMargin
            anchors.bottomMargin: WidgetStyle.outerMargin
            color: WidgetStyle.normalColor
            radius: WidgetStyle.cornerRadius
            opacity: 0
        }
        
        // Content container
        Item {
            id: contentContainer
            anchors.fill: parent
            anchors.topMargin: WidgetStyle.outerMargin + WidgetStyle.contentMargin
            anchors.bottomMargin: WidgetStyle.outerMargin + WidgetStyle.contentMargin
            anchors.leftMargin: WidgetStyle.contentMargin
            anchors.rightMargin: WidgetStyle.contentMargin
            opacity: 0
            
            // Growing bar (capped at 100%) with optical roundness
            // Inner radius = outer radius - padding (4 - 4 = 0, but we use 2 for visual balance)
            Rectangle {
                width: parent.width
                height: parent.height * Math.min(osdLoader.value / osdLoader.maxValue, 1.0)
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 2  // Smaller radius for inner element (optical roundness)
                color: osdLoader.muted ? ColorScheme.inactive : osdLoader.accentColor
                
                Behavior on height {
                    NumberAnimation {
                        duration: 150
                        easing.type: Easing.OutCubic
                    }
                }
            }
            
            // Percentage and icon at bottom
            Column {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 8
                spacing: 4
                
                // Percentage above icon
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: osdLoader.muted ? "✕" : Math.round(osdLoader.value).toString()
                    font.family: WidgetStyle.fontFamily
                    font.pixelSize: 12
                    font.weight: Font.Bold
                    color: ColorScheme.textHighEmphasis
                }
                
                // Icon (SVG)
                Item {
                    id: iconContainer
                    width: 18
                    height: 18
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: osdLoader.iconSvgPath !== ""
                    
                    // SVG Icon using inline data URI
                    Image {
                        id: icon
                        width: 18
                        height: 18
                        anchors.centerIn: parent
                        sourceSize: Qt.size(48, 48)
                        smooth: true
                        antialiasing: true
                        mipmap: true
                        cache: false
                        fillMode: Image.PreserveAspectFit
                        
                        source: osdLoader.iconSvgPath !== "" ?
                            "data:image/svg+xml;utf8," + encodeURIComponent(
                                '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -960 960 960" fill="' +
                                osdLoader.iconColor + '">' +
                                '<path d="' + osdLoader.iconSvgPath + '"/>' +
                                '</svg>'
                            ) : ""
                    }
                }
            }
        }
    }
}