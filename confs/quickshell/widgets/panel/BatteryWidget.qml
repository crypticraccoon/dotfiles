import QtQuick 2.15
import QtQuick.Controls 2.15
import Quickshell
import Quickshell.Services.UPower
import QtQuick.Layouts 1.15
import "../../theme" as Theme
    
Item {
    id: batteryWidget
    width: 80
    height: 30

    property var battery: UPower.displayDevice

    MouseArea {
        id: batteryButton
        anchors.fill: parent
        hoverEnabled: true
        
        property bool pressed: false
        property bool hovered: containsMouse
        
        onPressed: pressed = true
        onReleased: pressed = false
        onClicked: {
            batteryPopup.visible = !batteryPopup.visible
            if (batteryPopup.visible) autoHideTimer.restart()
            else autoHideTimer.stop()
        }
        
        Rectangle {
            id: background
            anchors.fill: parent
            anchors.topMargin: Theme.WidgetStyle.outerMargin
            anchors.bottomMargin: Theme.WidgetStyle.outerMargin
            color: batteryButton.pressed ? Theme.WidgetStyle.pressedColor :
                   (batteryButton.hovered ? Theme.WidgetStyle.hoverColor : Theme.WidgetStyle.normalColor)

            // All corners with 4px radius
            topLeftRadius: Theme.WidgetStyle.cornerRadius
            bottomLeftRadius: Theme.WidgetStyle.cornerRadius
            topRightRadius: Theme.WidgetStyle.cornerRadius
            bottomRightRadius: Theme.WidgetStyle.cornerRadius

            Behavior on color {
                ColorAnimation { duration: Theme.WidgetStyle.colorTransitionDuration }
            }
        }
        
        Item {
            id: contentArea
            anchors.fill: parent
            anchors.topMargin: Theme.WidgetStyle.outerMargin
            anchors.bottomMargin: Theme.WidgetStyle.outerMargin
            anchors.margins: Theme.WidgetStyle.contentMargin

            // Material Design 3 Battery Icon
            Row {
                anchors.centerIn: parent
                spacing: 4

                // Battery SVG Icon
                Item {
                    id: batteryIconContainer
                    width: 16
                    height: 16
                    anchors.verticalCenter: parent.verticalCenter

                    property real percentage: battery && battery.ready ? battery.percentage : 0
                    property bool isCharging: battery && battery.ready ? battery.state === UPowerDeviceState.Charging : false
                    property bool isLow: percentage < 0.20
                    property color iconColor: isCharging ? chargingColor : "#FFFFFF"
                    property color chargingColor: "#66BB6A"
                    
                    
                    // Get the appropriate SVG path based on battery percentage and charging state
                    property string svgPath: {
                        if (isCharging) {
                            // Charging icons with lightning bolt
                            if (percentage <= 0.20) {
                                // 0-20%: Charging Low
                                return "M663.08-100.77v-105.38h-61.54l95.38-173.08v105.38h61.54l-95.38 173.08ZM347.69-120q-13.73 0-23.02-9.29t-9.29-23.02v-596.15q0-13.73 9.29-23.02t23.02-9.29h64.62V-840h135.38v59.23h64.78q13.76 0 22.95 9.29 9.2 9.29 9.2 23.02v276.15q-11 1.54-20.62 3.5-9.62 1.96-19.38 5.12v-277.85H355.38v499.23h87.7q0 33.69 9.07 64.69 9.08 31 26.54 57.62h-131Z"
                            } else if (percentage <= 0.30) {
                                // 20-30%: Charging 20%
                                return "M663.08-100.77v-105.38h-61.54l95.38-173.08v105.38h61.54l-95.38 173.08ZM347.69-120q-13.73 0-23.02-9.29t-9.29-23.02v-596.15q0-13.73 9.29-23.02t23.02-9.29h64.62V-840h135.38v59.23h64.78q13.76 0 22.95 9.29 9.2 9.29 9.2 23.02v276.15q-11 1.54-20.62 3.5-9.62 1.96-19.38 5.12v-277.85H355.38v429.23H454q-5.46 16.77-8.19 34.43-2.73 17.65-2.73 35.57 0 33.69 9.07 64.69 9.08 31 26.54 57.62h-131Z"
                            } else if (percentage <= 0.50) {
                                // 30-50%: Charging 30%
                                return "M663.08-100.77v-105.38h-61.54l95.38-173.08v105.38h61.54l-95.38 173.08ZM347.69-120q-13.73 0-23.02-9.29t-9.29-23.02v-596.15q0-13.73 9.29-23.02t23.02-9.29h64.62V-840h135.38v59.23h64.78q13.76 0 22.95 9.29 9.2 9.29 9.2 23.02v276.15q-11 1.54-20.62 3.5-9.62 1.96-19.38 5.12v-277.85H355.38v349.23h142.77q-25.76 30.26-40.42 68.55-14.65 38.3-14.65 81.45 0 33.69 9.07 64.69 9.08 31 26.54 57.62h-131Z"
                            } else if (percentage <= 0.60) {
                                // 50-60%: Charging 50%
                                return "M663.08-103.92v-102.23h-52.31l86.15-169.7v102h52.31l-86.15 169.93Zm-320-16.08q-12.04 0-19.87-7.83-7.83-7.82-7.83-19.86v-612.93q0-11.26 7.83-19.48 7.83-8.21 19.87-8.21h69.23V-840h135.38v51.69h69.39q12.07 0 19.8 8.21 7.74 8.22 7.74 19.48v300.7q-8.31 1.54-16 2.77-7.7 1.23-14.77 3.92v-305.08h-267.7v378.39H504q-22.61 28.56-35.57 63.82-12.97 35.25-12.97 74.02 0 34.93 10.66 65.93 10.65 31 29.8 56.15H343.08Z"
                            } else if (percentage <= 0.80) {
                                // 60-80%: Charging 60%
                                return "M343.08-120q-12.04 0-19.87-7.83-7.83-7.82-7.83-19.86v-612.93q0-11.26 7.83-19.48 7.83-8.21 19.87-8.21h69.23V-840h135.38v51.69h69.39q12.07 0 19.8 8.21 7.74 8.22 7.74 19.48v300.7q-80.31 10.77-134.74 72.5-54.42 61.73-54.42 145.34 0 34.93 10.66 65.93 10.65 31 29.8 56.15H343.08Zm3.07-339.92h267.7v-298.39h-267.7v298.39Zm316.93 356v-102.23h-52.31l86.15-169.7v102h52.31l-86.15 169.93Z"
                            } else if (percentage <= 0.95) {
                                // 80-95%: Charging 80%
                                return "M347.69-120q-13.73 0-23.02-9.29t-9.29-23.02v-596.15q0-13.73 9.29-23.02t23.02-9.29h64.62V-840h135.38v59.23h64.78q13.76 0 22.95 9.29 9.2 9.29 9.2 23.02v276.15q-85.39 11-143.47 75.89-58.07 64.88-58.07 154.11 0 33.69 9.07 64.69 9.08 31 26.54 57.62h-131Zm7.69-526.15h249.24v-95.39H355.38v95.39Zm307.7 545.38v-105.38h-61.54l95.38-173.08v105.38h61.54l-95.38 173.08Z"
                            } else {
                                // 95-100%: Charging Full
                                return "M663.08-100.77v-105.38h-61.54l95.38-173.08v105.38h61.54l-95.38 173.08ZM347.69-120q-13.73 0-23.02-9.29t-9.29-23.02v-596.15q0-13.73 9.29-23.02t23.02-9.29h64.62V-840h135.38v59.23h64.78q13.76 0 22.95 9.29 9.2 9.29 9.2 23.02v276.15q-85.39 11-143.47 75.89-58.07 64.88-58.07 154.11 0 33.69 9.07 64.69 9.08 31 26.54 57.62h-131Z"
                            }
                        } else {
                            // Non-charging icons
                            if (percentage <= 0.05) {
                                // 0-5%: Battery Alert
                                return "M347.82-120q-14.05 0-23.24-9.29-9.2-9.29-9.2-23.02v-596.15q0-13.73 9.29-23.02t23.02-9.29h64.62V-840h135.38v59.23h64.78q13.76 0 22.95 9.29 9.2 9.29 9.2 23.02v596.15q0 13.73-9.29 23.02T612.31-120H347.82Zm7.56-120h249.24v-501.54H355.38V-240Z"
                            } else if (percentage <= 0.25) {
                                // 5-25%: Battery 20%
                                return "M347.82-120q-14.05 0-23.24-9.29-9.2-9.29-9.2-23.02v-596.15q0-13.73 9.29-23.02t23.02-9.29h64.62V-840h135.38v59.23h64.78q13.76 0 22.95 9.29 9.2 9.29 9.2 23.02v596.15q0 13.73-9.29 23.02T612.31-120H347.82Zm7.56-200h249.24v-421.54H355.38V-320Z"
                            } else if (percentage <= 0.50) {
                                // 25-50%: Battery 30%
                                return "M347.82-120q-14.05 0-23.24-9.29-9.2-9.29-9.2-23.02v-596.15q0-13.73 9.29-23.02t23.02-9.29h64.62V-840h135.38v59.23h64.78q13.76 0 22.95 9.29 9.2 9.29 9.2 23.02v596.15q0 13.73-9.29 23.02T612.31-120H347.82Zm7.56-280h249.24v-341.54H355.38V-400Z"
                            } else if (percentage <= 0.75) {
                                // 50-75%: Battery 50%
                                return "M347.82-120q-14.05 0-23.24-9.29-9.2-9.29-9.2-23.02v-596.15q0-13.73 9.29-23.02t23.02-9.29h64.62V-840h135.38v59.23h64.78q13.76 0 22.95 9.29 9.2 9.29 9.2 23.02v596.15q0 13.73-9.29 23.02T612.31-120H347.82Zm7.56-360h249.24v-261.54H355.38V-480Z"
                            } else if (percentage <= 0.85) {
                                // 75-85%: Battery 80%
                                return "M347.82-120q-14.05 0-23.24-9.29-9.2-9.29-9.2-23.02v-596.15q0-13.73 9.29-23.02t23.02-9.29h64.62V-840h135.38v59.23h64.78q13.76 0 22.95 9.29 9.2 9.29 9.2 23.02v596.15q0 13.73-9.29 23.02T612.31-120H347.82Zm7.56-440h249.24v-181.54H355.38V-560Z"
                            } else if (percentage <= 0.95) {
                                // 85-95%: Battery 90%
                                return "M347.82-120q-14.05 0-23.24-9.29-9.2-9.29-9.2-23.02v-596.15q0-13.73 9.29-23.02t23.02-9.29h64.62V-840h135.38v59.23h64.78q13.76 0 22.95 9.29 9.2 9.29 9.2 23.02v596.15q0 13.73-9.29 23.02T612.31-120H347.82Zm7.56-527.69h249.24v-93.85H355.38v93.85Z"
                            } else {
                                // 95-100%: Battery Full
                                return "M347.82-120q-14.05 0-23.24-9.29-9.2-9.29-9.2-23.02v-596.15q0-13.73 9.29-23.02t23.02-9.29h64.62V-840h135.38v59.23h64.78q13.76 0 22.95 9.29 9.2 9.29 9.2 23.02v596.15q0 13.73-9.29 23.02T612.31-120H347.82Z"
                            }
                        }
                    }

                    // SVG Battery Icon using inline data URI
                    Image {
                        id: batteryIcon
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

                // Percentage text with unit
                Text {
                    text: battery && battery.ready
                          ? Math.round(battery.percentage * 100) + "%"
                          : "N/A"
                    font.family: Theme.WidgetStyle.fontFamily
                    font.pixelSize: 13
                    font.weight: Font.Bold
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#f0f0f0"
                }
            }
        }
    }

    PopupWindow {
        id: batteryPopup
        width: 220
        height: 180
        visible: false

        Timer {
            id: autoHideTimer
            interval: 5000
            repeat: false
            onTriggered: batteryPopup.visible = false
        }

        anchor {
            window: batteryWidget.QsWindow.window
            adjustment: PopupAdjustment.None
            gravity: Edges.Bottom | Edges.Right
            onAnchoring: {
                const pos = batteryWidget.QsWindow.contentItem.mapFromItem(
                    batteryWidget,
                    (batteryWidget.width - batteryPopup.width) / 2,
                    batteryWidget.height + 5
                )
                anchor.rect.x = pos.x
                anchor.rect.y = pos.y
            }
        }

        color: "#101010"

        Rectangle {
            anchors.fill: parent
            color: "#101010"
            radius: 0
            border.color: "#404040"
            border.width: 0

            Column {
                anchors.fill: parent
                anchors.margins: 12
                spacing: 8

                Text {
                    text: "Battery Information"
                    color: "#5bc6f7"
                    font.family: Theme.WidgetStyle.fontFamily
                    font.pixelSize: 16
                    font.bold: true
                }
                Rectangle {
                    width: parent.width
                    height: 1
                    color: "#404040"
                }
                Text {
                    text: battery && battery.ready
                          ? "Charge: " + Math.round(battery.percentage * 100) + "%"
                          : "Charge: N/A"
                    color: Theme.ColorScheme.textBackground
                    font.family: Theme.WidgetStyle.fontFamily
                    font.pixelSize: 14
                }
                Text {
                    text: battery && battery.ready
                          ? "State: " + getStateString(battery.state)
                          : "State: Unknown"
                    color: Theme.ColorScheme.textBackground
                    font.family: Theme.WidgetStyle.fontFamily
                    font.pixelSize: 14
                }
                Text {
                    text: (battery && battery.ready && !isNaN(battery.changeRate) && battery.changeRate > 0)
                          ? (battery.state === UPowerDeviceState.Charging
                             ? "Charge rate: " + battery.changeRate.toFixed(2) + " W"
                             : "Discharge rate: " + battery.changeRate.toFixed(2) + " W")
                          : "Rate: N/A"
                    color: Theme.ColorScheme.textBackground
                    font.family: Theme.WidgetStyle.fontFamily
                    font.pixelSize: 14
                }
                Text {
                    text: {
                        if (!battery || !battery.ready) return "Time: N/A"
                        var secs = battery.state === UPowerDeviceState.Charging
                                   ? battery.timeToFull
                                   : battery.timeToEmpty
                        if (secs <= 0) return "Time: N/A"
                        var hrs = Math.floor(secs / 3600)
                        var mins = Math.floor((secs % 3600) / 60)
                        return "Time: " + hrs + "h " + mins + "m"
                    }
                    color: Theme.ColorScheme.textBackground
                    font.family: Theme.WidgetStyle.fontFamily
                    font.pixelSize: 14
                }
            }
        }
    }

    function getStateString(state) {
        switch (state) {
            case UPowerDeviceState.Unknown:           return "Unknown"
            case UPowerDeviceState.Charging:          return "Charging"
            case UPowerDeviceState.Discharging:       return "Discharging"
            case UPowerDeviceState.Empty:             return "Empty"
            case UPowerDeviceState.FullyCharged:      return "Fully Charged"
            case UPowerDeviceState.PendingCharge:     return "Pending Charge"
            case UPowerDeviceState.PendingDischarge:  return "Pending Discharge"
            default:                                  return "Invalid State"
        }
    }

    visible: battery !== null
}
