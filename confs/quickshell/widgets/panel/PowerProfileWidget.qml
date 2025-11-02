import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Quickshell
import Quickshell.Services.UPower
import "../../theme" as Theme

Item {
    id: profileWidget
    implicitWidth: isExpanded ? 200 : 30
    Layout.preferredWidth: isExpanded ? 200 : 30
    Layout.minimumWidth: 30
    Layout.maximumWidth: 200
    height: 30
    
    property var powerProfiles: PowerProfiles
    property bool isExpanded: false
    
    Behavior on implicitWidth {
        NumberAnimation {
            duration: Theme.WidgetStyle.colorTransitionDuration
            easing.type: Easing.OutCubic
        }
    }
    
    Behavior on Layout.preferredWidth {
        NumberAnimation {
            duration: Theme.WidgetStyle.colorTransitionDuration
            easing.type: Easing.OutCubic
        }
    }
    
    Component.onCompleted: {
        if (powerProfiles) {
            Qt.callLater(updateSliderPosition)
        }
    }
    
    Connections {
        target: powerProfiles
        function onProfileChanged() {
            Qt.callLater(updateSliderPosition)
        }
    }
    
    function updateSliderPosition() {
        if (!powerProfiles) return
        
        // Calculate position based on current profile
        var position = 0
        switch (powerProfiles.profile) {
            case PowerProfile.PowerSaver:
                position = 0
                break
            case PowerProfile.Balanced:
                position = 1
                break
            case PowerProfile.Performance:
                position = 2
                break
        }
        
        // Update slider position and width when expanded
        // Use background width minus margins to match full inlay size
        if (isExpanded && background.width > 0) {
            var buttonWidth = background.width / 3
            sliderIndicator.targetWidth = buttonWidth
            sliderIndicator.targetX = buttonWidth * position
        }
    }
    
    function getProfileIcon(profile) {
        switch (profile) {
            case PowerProfile.PowerSaver:
                return "M480-180q125 0 212.5-87.5T780-480v-300H480q-125 0-212.5 87.5T180-480q0 125 87.5 212.5T480-180Zm-53-105 207-185q10-9 6-21.5T622-506l-162-16 97-133q4-5 3.5-10.5T556-676q-5-5-11.5-5t-11.5 5L327-491q-10 9-6 21.5t18 14.5l162 16-98 133q-4 5-3.5 10.5T405-285q5 5 11 5t11-5Zm53 165q-67 0-126-22.5T247-205l-76 76q-5 5-10 7t-11 2q-12 0-21-9t-9-21q0-6 2-11t7-10l76-76q-40-48-62.5-107T120-480q0-150 105-255t255-105h360v360q0 150-105 255T480-120Zm0-360Z"
            case PowerProfile.Balanced:
                return "M80-120v-60h370v-484q-26-9-46.5-29.5T374-740H215l125 302q-1 45-38.5 76.5T210-330q-54 0-91.5-31.5T80-438l125-302h-85v-60h254q12-35 41-57.5t65-22.5q36 0 65 22.5t41 57.5h254v60h-85l125 302q-1 45-38.5 76.5T750-330q-54 0-91.5-31.5T620-438l125-302H586q-9 26-29.5 46.5T510-664v484h370v60H80Zm595-320h150l-75-184-75 184Zm-540 0h150l-75-184-75 184Zm345-280q21 0 35.5-15t14.5-35q0-21-14.5-35.5T480-820q-20 0-35 14.5T430-770q0 20 15 35t35 15Z"
            case PowerProfile.Performance:
                return "m187-551 106 45q18-36 38.5-71t43.5-67l-79-16-109 109Zm154 81 133 133q57-26 107-59t81-64q81-81 119-166t41-192q-107 3-192 41T464-658q-31 31-64 81t-59 107Zm229-96q-20-20-20-49.5t20-49.5q20-20 49.5-20t49.5 20q20 20 20 49.5T669-566q-20 20-49.5 20T570-566Zm-15 383 109-109-16-79q-32 23-67 43.5T510-289l45 106Zm326-694q9 136-34 248T705-418l-2 2-2 2 22 110q3 15-1.5 29T706-250L535-78l-85-198-170-170-198-85 172-171q11-11 25-15.5t29-1.5l110 22q1-1 2-1.5t2-1.5q99-99 211-142.5T881-877ZM149-325q35-35 85.5-35.5T320-326q35 35 34.5 85.5T319-155q-26 26-80.5 43T75-80q15-109 31.5-164t42.5-81Zm42 43q-14 15-25 47t-19 82q50-8 82-19t47-25q19-17 19.5-42.5T278-284q-19-18-44.5-17.5T191-282Z"
            default:
                return ""
        }
    }
    
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        
        onEntered: {
            isExpanded = true
            Qt.callLater(updateSliderPosition)
        }
        
        onExited: {
            isExpanded = false
        }
        
        // Background Rectangle
        Rectangle {
            id: background
            anchors.fill: parent
            anchors.topMargin: Theme.WidgetStyle.outerMargin
            anchors.bottomMargin: Theme.WidgetStyle.outerMargin
            color: Theme.WidgetStyle.normalColor
            radius: Theme.WidgetStyle.cornerRadius
            
            // Animated selection indicator - same size as background
            // No padding, so use same corner radius as outer background
            Rectangle {
                id: sliderIndicator
                width: targetWidth
                height: parent.height
                x: targetX
                y: 0
                color: Theme.WidgetStyle.sliderIndicatorColor
                radius: Theme.WidgetStyle.cornerRadius
                visible: isExpanded
                
                property real targetX: 0
                property real targetWidth: 0
                
                Behavior on x {
                    NumberAnimation {
                        duration: Theme.WidgetStyle.colorTransitionDuration
                        easing.type: Easing.OutCubic
                    }
                }
                
                Behavior on width {
                    NumberAnimation {
                        duration: Theme.WidgetStyle.colorTransitionDuration
                        easing.type: Easing.OutCubic
                    }
                }
            }
            
            // Content area
            Item {
                id: contentArea
                anchors.fill: parent
                anchors.margins: Theme.WidgetStyle.contentMargin
                
                // Collapsed view - single icon
                Item {
                    id: collapsedView
                    anchors.fill: parent
                    visible: !isExpanded
                    
                    Item {
                        width: 16
                        height: 16
                        anchors.centerIn: parent
                        
                        property string svgPath: getProfileIcon(powerProfiles ? powerProfiles.profile : PowerProfile.Balanced)
                        property color iconColor: Theme.WidgetStyle.activeIconColor
                        
                        Image {
                            width: 16
                            height: 16
                            anchors.centerIn: parent
                            sourceSize: Qt.size(48, 48)
                            smooth: true
                            antialiasing: true
                            mipmap: true
                            cache: false
                            fillMode: Image.PreserveAspectFit
                            
                            source: parent.svgPath ? "data:image/svg+xml;utf8," + encodeURIComponent(
                                '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -960 960 960" fill="' +
                                parent.iconColor + '">' +
                                '<path d="' + parent.svgPath + '"/>' +
                                '</svg>'
                            ) : ""
                        }
                    }
                }
                
                // Expanded view - all options
                Item {
                    id: expandedView
                    anchors.fill: parent
                    visible: isExpanded
                    
                    // Profile buttons row
                    Row {
                        id: contentRow
                        anchors.fill: parent
                        spacing: 0
                        
                        onWidthChanged: {
                            Qt.callLater(updateSliderPosition)
                        }
                        
                        // Power Saver
                        AbstractButton {
                            id: powerSaverButton
                            width: parent.width / 3
                            height: parent.height
                            
                            onClicked: {
                                if (powerProfiles) {
                                    powerProfiles.profile = PowerProfile.PowerSaver
                                    isExpanded = false
                                }
                            }
                            
                            contentItem: Item {
                                anchors.fill: parent
                                
                                Item {
                                    width: 16
                                    height: 16
                                    anchors.centerIn: parent
                                    
                                    property color iconColor: powerProfiles && powerProfiles.profile === PowerProfile.PowerSaver
                                        ? Theme.WidgetStyle.activeIconColor
                                        : Theme.WidgetStyle.inactiveIconColor
                                    property string svgPath: getProfileIcon(PowerProfile.PowerSaver)
                                    
                                    Image {
                                        width: 16
                                        height: 16
                                        anchors.centerIn: parent
                                        sourceSize: Qt.size(48, 48)
                                        smooth: true
                                        antialiasing: true
                                        mipmap: true
                                        cache: false
                                        fillMode: Image.PreserveAspectFit
                                        
                                        source: "data:image/svg+xml;utf8," + encodeURIComponent(
                                            '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -960 960 960" fill="' +
                                            parent.iconColor + '">' +
                                            '<path d="' + parent.svgPath + '"/>' +
                                            '</svg>'
                                        )
                                    }
                                }
                            }
                            
                            background: Rectangle {
                                color: "transparent"
                            }
                        }
                        
                        // Balanced
                        AbstractButton {
                            id: balancedButton
                            width: parent.width / 3
                            height: parent.height
                            
                            onClicked: {
                                if (powerProfiles) {
                                    powerProfiles.profile = PowerProfile.Balanced
                                    isExpanded = false
                                }
                            }
                            
                            contentItem: Item {
                                anchors.fill: parent
                                
                                Item {
                                    width: 16
                                    height: 16
                                    anchors.centerIn: parent
                                    
                                    property color iconColor: powerProfiles && powerProfiles.profile === PowerProfile.Balanced
                                        ? Theme.WidgetStyle.activeIconColor
                                        : Theme.WidgetStyle.inactiveIconColor
                                    property string svgPath: getProfileIcon(PowerProfile.Balanced)
                                    
                                    Image {
                                        width: 16
                                        height: 16
                                        anchors.centerIn: parent
                                        sourceSize: Qt.size(48, 48)
                                        smooth: true
                                        antialiasing: true
                                        mipmap: true
                                        cache: false
                                        fillMode: Image.PreserveAspectFit
                                        
                                        source: "data:image/svg+xml;utf8," + encodeURIComponent(
                                            '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -960 960 960" fill="' +
                                            parent.iconColor + '">' +
                                            '<path d="' + parent.svgPath + '"/>' +
                                            '</svg>'
                                        )
                                    }
                                }
                            }
                            
                            background: Rectangle {
                                color: "transparent"
                            }
                        }
                        
                        // Performance
                        AbstractButton {
                            id: performanceButton
                            width: parent.width / 3
                            height: parent.height
                            enabled: powerProfiles && powerProfiles.hasPerformanceProfile
                            
                            onClicked: {
                                if (powerProfiles) {
                                    powerProfiles.profile = PowerProfile.Performance
                                    isExpanded = false
                                }
                            }
                            
                            contentItem: Item {
                                anchors.fill: parent
                                
                                Item {
                                    width: 16
                                    height: 16
                                    anchors.centerIn: parent
                                    
                                    property color iconColor: !parent.parent.parent.enabled
                                        ? Theme.WidgetStyle.disabledIconColor
                                        : (powerProfiles && powerProfiles.profile === PowerProfile.Performance
                                            ? Theme.WidgetStyle.activeIconColor
                                            : Theme.WidgetStyle.inactiveIconColor)
                                    property string svgPath: getProfileIcon(PowerProfile.Performance)
                                    
                                    Image {
                                        width: 16
                                        height: 16
                                        anchors.centerIn: parent
                                        sourceSize: Qt.size(48, 48)
                                        smooth: true
                                        antialiasing: true
                                        mipmap: true
                                        cache: false
                                        fillMode: Image.PreserveAspectFit
                                        
                                        source: "data:image/svg+xml;utf8," + encodeURIComponent(
                                            '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 -960 960 960" fill="' +
                                            parent.iconColor + '">' +
                                            '<path d="' + parent.svgPath + '"/>' +
                                            '</svg>'
                                        )
                                    }
                                }
                            }
                            
                            background: Rectangle {
                                color: "transparent"
                            }
                        }
                    }
                }
            }
        }
    }
    
    visible: powerProfiles !== null
}
