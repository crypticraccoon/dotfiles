import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Quickshell
import Quickshell.Io
import Quickshell.Bluetooth
import "../../theme" as Theme

Item {
    id: networkWidget
    width: 72
    height: 30

    // WiFi properties
    property string currentConnection: "Disconnected"
    property int currentSignal: 0
    property bool isWifiConnected: false
    property string selectedSSID: ""
    property bool showPasswordDialog: false

    // Bluetooth properties
    property bool isBluetoothEnabled: Bluetooth.adapter?.powered ?? false
    property bool isBluetoothConnected: true
    property int connectedDeviceCount: 0

    // UI state
    property int currentTab: 0  // 0 = WiFi, 1 = Bluetooth

    // Network list model
    ListModel {
        id: networksModel
    }

    // Bluetooth devices model
    ListModel {
        id: bluetoothDevicesModel
    }

    // Monitor Bluetooth adapter
    Connections {
        target: Bluetooth.adapter ?? null
        function onPoweredChanged() {
            isBluetoothEnabled = Bluetooth.adapter.powered
            updateBluetoothDevices()
        }
        function onDiscoveringChanged() {
            updateBluetoothDevices()
        }
    }

    // Monitor Bluetooth devices
    Connections {
        target: Bluetooth
        function onDevicesChanged() {
            updateBluetoothDevices()
        }
    }

    // Auto-refresh timer (runs when popup is visible)
    Timer {
        id: refreshTimer
        interval: 10000
        running: networkPopup.visible
        repeat: true
        onTriggered: {
            if (currentTab === 0) {
                listNetworksProcess.running = true
                getConnectionProcess.running = true
            } else {
                updateBluetoothDevices()
            }
        }
    }

    // Initial load timer
    Timer {
        id: initialLoadTimer
        interval: 500
        running: false
        repeat: false
        onTriggered: {
            if (currentTab === 0) {
                listNetworksProcess.running = true
            } else {
                updateBluetoothDevices()
            }
        }
    }

    Component.onCompleted: {
        getConnectionProcess.running = true
        listNetworksProcess.running = true
        updateBluetoothDevices()
    }

    // WiFi Process commands
    Process {
        id: getConnectionProcess
        command: ["nmcli", "-t", "-f", "NAME,TYPE,DEVICE", "connection", "show", "--active"]
        stdout: StdioCollector {
            onStreamFinished: parseCurrentConnection(text)
        }
    }

    Process {
        id: listNetworksProcess
        command: ["nmcli", "-t", "-f", "SSID,SIGNAL,SECURITY,IN-USE", "device", "wifi", "list"]
        stdout: StdioCollector {
            onStreamFinished: parseNetworkList(text)
        }
    }

    Process {
        id: connectProcess
        property string targetSSID: ""
        
        function connectToNetwork(ssid, password) {
            targetSSID = ssid
            if (password && password.length > 0) {
                command = ["nmcli", "device", "wifi", "connect", ssid, "password", password]
            } else {
                command = ["nmcli", "device", "wifi", "connect", ssid]
            }
            running = true
        }

        stdout: StdioCollector {
            onStreamFinished: {
                console.log("Connection result:", text)
                Qt.callLater(function() {
                    getConnectionProcess.running = true
                    listNetworksProcess.running = true
                })
            }
        }
    }

    Process {
        id: rescanProcess
        command: ["nmcli", "device", "wifi", "rescan"]
        
        stdout: StdioCollector {
            onStreamFinished: {
                initialLoadTimer.restart()
            }
        }
    }

    // Bluetooth functions
    function updateBluetoothDevices() {
        bluetoothDevicesModel.clear()
        connectedDeviceCount = 0
        
        if (!Bluetooth.adapter) return
        
        var devices = Bluetooth.devices
        for (var i = 0; i < devices.length; i++) {
            var device = devices[i]
            if (device.connected) {
                connectedDeviceCount++
                isBluetoothConnected = true
            }
            
            bluetoothDevicesModel.append({
                name: device.name || "Unknown Device",
                address: device.address,
                connected: device.connected,
                paired: device.paired,
                trusted: device.trusted,
                deviceObj: device
            })
        }
        
        if (connectedDeviceCount === 0) {
            isBluetoothConnected = false
        }
    }

    function toggleBluetoothPower() {
        if (Bluetooth.adapter) {
            Bluetooth.adapter.powered = !Bluetooth.adapter.powered
        }
    }

    function startBluetoothDiscovery() {
        if (Bluetooth.adapter && !Bluetooth.adapter.discovering) {
            Bluetooth.adapter.startDiscovery()
        }
    }

    function stopBluetoothDiscovery() {
        if (Bluetooth.adapter && Bluetooth.adapter.discovering) {
            Bluetooth.adapter.stopDiscovery()
        }
    }

    function connectBluetoothDevice(device) {
        if (device) {
            device.connect()
        }
    }

    function disconnectBluetoothDevice(device) {
        if (device) {
            device.disconnect()
        }
    }

    // WiFi parsing functions
    function parseCurrentConnection(output) {
        var lines = output.trim().split('\n')
        isWifiConnected = false
        currentConnection = "Disconnected"
        
        for (var i = 0; i < lines.length; i++) {
            var parts = lines[i].split(':')
            if (parts.length >= 2 && parts[1] === '802-11-wireless') {
                currentConnection = parts[0]
                isWifiConnected = true
                return
            }
        }
    }

    function parseNetworkList(output) {
        networksModel.clear()
        var lines = output.trim().split('\n')
        var seenSSIDs = {}  // Track SSIDs to avoid duplicates
        
        for (var i = 0; i < lines.length; i++) {
            var parts = lines[i].split(':')
            if (parts.length >= 3 && parts[0]) {
                var ssid = parts[0]
                
                // Skip if we've already seen this SSID
                if (seenSSIDs[ssid]) continue
                seenSSIDs[ssid] = true
                
                var signal = parseInt(parts[1]) || 0
                var inUse = parts[3] === '*'
                
                if (inUse) {
                    currentSignal = signal
                }
                
                var security = parts[2] || ""
                var hasLock = security && security.length > 0 && security !== "--"
                
                networksModel.append({
                    ssid: ssid,
                    signal: signal,
                    security: security,
                    inUse: inUse,
                    bars: calculateSignalBars(signal),
                    hasLock: hasLock
                })
            }
        }
    }

    function calculateSignalBars(signal) {
        if (signal >= 75) return 4
        if (signal >= 50) return 3
        if (signal >= 25) return 2
        return 1
    }

    // Icon functions
    function getWifiIcon(bars, connected, hasLock) {
        if (!connected || bars === 0) {
            return "M480-120 0-600q99-94 221-147t259-53q137 0 259 53t221 147L480-120Zm0-82 392-392q-87-68-184.5-107T480-740q-110 0-207.5 39T88-594l392 392Z"
        }
        
        if (hasLock) {
            switch(bars) {
                case 1: return "M723-318h84v-39.3q0-16.7-12.5-29.2T765-399q-17 0-29.5 12.5T723-357.3v39.3ZM480-120 0-600q98-94 221-147t259-53q136 0 259 53t221 147L844-484q-18.59-7.86-38.79-11.43Q785-499 765-499q-91.25 0-155.12 63.87Q546-371.25 546-280q0 20 3 40.5t11 39.5l-80 80Zm202 0q-17 0-28.5-11.39Q642-142.77 642-159.6v-118.8q0-16.83 11.5-28.21Q665-318 682-318h1v-39q0-33.83 24.12-57.91 24.13-24.09 58-24.09Q799-439 823-414.91q24 24.08 24 57.91v39h1q17 0 28.5 11.39Q888-295.23 888-278.4v118.8q0 16.83-11.5 28.21Q865-120 848-120H682ZM130-552q75-60 164-94t186-34q97 0 186 34t164 94l42-42q-85-66-184.5-106T480-740q-108 0-207.5 40T88-594l42 42Z"
                case 2: return "M480-120 0-600q97-93 220-146.5T480-800q137 0 260 53.5T960-600L845-485q-16-6-33-9.5t-35-4.5l95-95q-87-68-184.5-107T480-740q-110 0-207.5 39T88-594l109 108q62-49 132-76t151-27q75 0 142 24t126 67q-85 8-143.5 70T546-278q0 20 3.5 40t10.5 38l-80 80Zm202 0q-17 0-28.5-11.5T642-160v-118q0-17 11.5-28.5T682-318h1v-39q0-34 24-58t58-24q34 0 58 24t24 58v39h1q17 0 28.5 11.5T888-278v118q0 17-11.5 28.5T848-120H682Zm41-198h84v-39q0-19-11.5-30.5T765-399q-19 0-30.5 11.5T723-357v39Z"
                case 3: return "M480-120 0-600q97-93 220-146.5T480-800q137 0 260 53.5T960-600L845-485q-16-6-32.85-9.64-16.84-3.63-35.15-4.36l95-95q-87-68-184.5-107T480-740q-110 0-207.5 39T88-594l256 256q48-38 106-47t115 16q-10 21-14.5 44t-4.5 47q0 20 3.5 40t10.5 38l-80 80Zm202 0q-17 0-28.5-11.39Q642-142.77 642-159.6v-118.8q0-16.83 11.5-28.21Q665-318 682-318h1v-39q0-33.83 24.12-57.91 24.13-24.09 58-24.09Q799-439 823-414.91q24 24.08 24 57.91v39h1q17 0 28.5 11.39Q888-295.23 888-278.4v118.8q0 16.83-11.5 28.21Q865-120 848-120H682Zm41-198h84v-39q0-19-11.5-30.5T765-399q-19 0-30.5 11.5T723-357v39Z"
                case 4:
                default: return "M723-318h84v-39.3q0-16.7-12.5-29.2T765-399q-17 0-29.5 12.5T723-357.3v39.3ZM480-120 0-600q98-94 221-147t259-53q136 0 259 53t221 147L844-484q-18.59-7.86-38.79-11.43Q785-499 765-499q-91.25 0-155.12 63.87Q546-371.25 546-280q0 20 3 40.5t11 39.5l-80 80Zm202 0q-17 0-28.5-11.39Q642-142.77 642-159.6v-118.8q0-16.83 11.5-28.21Q665-318 682-318h1v-39q0-33.83 24.12-57.91 24.13-24.09 58-24.09Q799-439 823-414.91q24 24.08 24 57.91v39h1q17 0 28.5 11.39Q888-295.23 888-278.4v118.8q0 16.83-11.5 28.21Q865-120 848-120H682ZM130-552q75-60 164-94t186-34q97 0 186 34t164 94l42-42q-85-66-184.5-106T480-740q-108 0-207.5 40T88-594l42 42Z"
            }
        } else {
            switch(bars) {
                case 1: return "M480-120 0-600q97-93 220-146.5T480-800q137 0 260 53.5T960-600L480-120ZM344-338q29-23 63.5-36t72.5-13q38 0 72.5 13t63.5 36l256-256q-87-68-184.5-107T480-740q-110 0-207.5 39T88-594l256 256Z"
                case 2: return "M480-120 0-600q97-93 220-146.5T480-800q137 0 260 53.5T960-600L480-120ZM273-409q45-35 96.5-55T480-484q59 0 110.5 20t96.5 55l185-185q-87-68-184.5-107T480-740q-110 0-207.5 39T88-594l185 185Z"
                case 3: return "M480-120 0-600q97-93 220-146.5T480-800q137 0 260 53.5T960-600L480-120ZM197-486q62-49 132-76t151-27q81 0 151.5 27T764-486l108-108q-87-68-184.5-107T480-740q-110 0-207.5 39T88-594l109 108Z"
                case 4:
                default: return "M480-120 0-600q99-94 221-147t259-53q137 0 259 53t221 147L480-120Z"
            }
        }
    }

    function getBluetoothIcon() {
        if (!isBluetoothEnabled) {
            // Bluetooth disabled
            return "M806-56 624-238 480-94h-30v-314L256-214l-42-42 196-196L56-806l42-42L848-98l-42 42ZM510-210l70-70-70-70v140Zm26-284-42-43 116-115-100-98v229l-60-60v-285h30l214 214-158 158Z"
        }
        
        if (Bluetooth.adapter?.discovering) {
            // Bluetooth searching
            return "M362-94v-314L168-214l-42-42 224-224-224-224 42-42 194 194v-314h30l214 214-172 172 172 172L392-94h-30Zm60-458 100-100-100-98v198Zm0 342 100-98-100-100v198Zm237-183-85-87 85-85q8 20 12.5 41.5T676-480q0 23-4.5 44.5T659-393Zm118 115-44-43q20-37 30.5-77t10.5-82q0-42-10.5-82T733-639l44-45q29 46 43 98t14 106q0 54-14 105t-43 97Z"
        }
        
        if (isBluetoothConnected) {
            // Bluetooth connected
            return "M451-94v-314L257-214l-42-42 224-224-224-224 42-42 194 194v-314h30l214 214-172 172 172 172L481-94h-30Zm60-458 100-100-100-98v198Zm0 342 100-98-100-100v198ZM200-432q-20.42 0-34.71-14T151-480q0-20 14.29-35T200-530q20.42 0 34.71 15T249-480q0 20-14.29 34T200-432Zm560 0q-20.42 0-34.71-14T711-480q0-20 14.29-35T760-530q20.42 0 34.71 15T809-480q0 20-14.29 34T760-432Z"
        }
        
        // Bluetooth enabled but not connected
        return "M450-94v-314L256-214l-42-42 224-224-224-224 42-42 194 194v-314h30l214 214-172 172 172 172L480-94h-30Zm60-458 100-100-100-98v198Zm0 342 100-98-100-100v198Z"
    }

    function getSignalColor(bars, connected) {
        if (!connected) return Theme.ColorScheme.inactive
        if (bars <= 2) return Theme.ColorScheme.warning
        return Theme.ColorScheme.success
    }

    function getBluetoothColor() {
        if (!isBluetoothEnabled) return Theme.ColorScheme.inactive
        if (isBluetoothConnected) return Theme.ColorScheme.success
        if (Bluetooth.adapter?.discovering) return Theme.ColorScheme.warning
        return Theme.ColorScheme.textMediumEmphasis
    }

    // Main widget button
    MouseArea {
        id: widgetButton
        anchors.fill: parent
        hoverEnabled: true
        
        property bool pressed: false
        property bool hovered: containsMouse
        
        onPressed: pressed = true
        onReleased: pressed = false
        onClicked: {
            networkPopup.visible = !networkPopup.visible
            if (networkPopup.visible) {
                initialLoadTimer.restart()
            }
        }
        
        Rectangle {
            id: background
            anchors.fill: parent
            anchors.topMargin: Theme.WidgetStyle.outerMargin
            anchors.bottomMargin: Theme.WidgetStyle.outerMargin
            color: widgetButton.pressed ? Theme.WidgetStyle.pressedColor :
                   (widgetButton.hovered ? Theme.WidgetStyle.hoverColor : Theme.WidgetStyle.normalColor)
            
            radius: Theme.WidgetStyle.cornerRadius
            
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
            
            Row {
                anchors.centerIn: parent
                spacing: 8
                
                // WiFi icon
                Item {
                    width: 16
                    height: 16
                    anchors.verticalCenter: parent.verticalCenter
                    
                    property string svgPath: getWifiIcon(isWifiConnected ? calculateSignalBars(currentSignal) : 0, isWifiConnected, false)
                    property color iconColor: getSignalColor(isWifiConnected ? calculateSignalBars(currentSignal) : 0, isWifiConnected)
                    
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
                
                // Bluetooth icon
                Item {
                    width: 16
                    height: 16
                    anchors.verticalCenter: parent.verticalCenter
                    
                    property string svgPath: getBluetoothIcon()
                    property color iconColor: getBluetoothColor()
                    
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
        }
    }

    // Popup window
    PopupWindow {
        id: networkPopup
        width: 320
        height: Math.min(520, contentColumn.implicitHeight + 24)
        visible: false
        color: Theme.ColorScheme.surface

        anchor {
            window: networkWidget.QsWindow.window
            adjustment: PopupAdjustment.None
            gravity: Edges.Bottom | Edges.Right
            onAnchoring: {
                const pos = networkWidget.QsWindow.contentItem.mapFromItem(
                    networkWidget,
                    (networkWidget.width - networkPopup.width) / 2,
                    networkWidget.height + 5
                )
                anchor.rect.x = pos.x
                anchor.rect.y = pos.y
            }
        }

        Rectangle {
            anchors.fill: parent
            color: Theme.ColorScheme.surface
            radius: Theme.WidgetStyle.cornerRadius
            border.color: Theme.ColorScheme.outline
            border.width: 1

            Column {
                id: contentColumn
                anchors.fill: parent
                anchors.margins: 12
                spacing: 8

                // Tab buttons
                Row {
                    width: parent.width
                    spacing: 4

                    Button {
                        width: (parent.width - 4) / 2
                        text: "WiFi"
                        font.family: Theme.WidgetStyle.fontFamily
                        font.pixelSize: 14
                        
                        background: Rectangle {
                            color: currentTab === 0 ? Theme.ColorScheme.primary : Theme.ColorScheme.surfaceVariant
                            radius: Theme.WidgetStyle.cornerRadius
                        }
                        
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: currentTab === 0 ? Theme.ColorScheme.primaryText : Theme.ColorScheme.textMediumEmphasis
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        onClicked: {
                            currentTab = 0
                            initialLoadTimer.restart()
                        }
                    }

                    Button {
                        width: (parent.width - 4) / 2
                        text: "Bluetooth"
                        font.family: Theme.WidgetStyle.fontFamily
                        font.pixelSize: 14
                        
                        background: Rectangle {
                            color: currentTab === 1 ? Theme.ColorScheme.primary : Theme.ColorScheme.surfaceVariant
                            radius: Theme.WidgetStyle.cornerRadius
                        }
                        
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: currentTab === 1 ? Theme.ColorScheme.primaryText : Theme.ColorScheme.textMediumEmphasis
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        onClicked: {
                            currentTab = 1
                            updateBluetoothDevices()
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 1
                    color: Theme.ColorScheme.outline
                }

                // WiFi Tab Content
                Column {
                    width: parent.width
                    spacing: 8
                    visible: currentTab === 0 && !showPasswordDialog

                    Text {
                        text: isWifiConnected ? "Connected to: " + currentConnection : "Not connected"
                        color: Theme.ColorScheme.textMediumEmphasis
                        font.family: Theme.WidgetStyle.fontFamily
                        font.pixelSize: 13
                    }

                    ScrollView {
                        width: parent.width
                        height: Math.min(300, networksModel.count * 52)
                        clip: true

                        Column {
                            width: parent.width
                            spacing: 4

                            Repeater {
                                model: networksModel
                                
                                delegate: Rectangle {
                                    width: parent.width
                                    height: 48
                                    color: model.inUse ? Theme.ColorScheme.primary : "transparent"
                                    radius: Theme.WidgetStyle.cornerRadius
                                    
                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        
                                        onEntered: parent.color = model.inUse ? Theme.ColorScheme.primary : Theme.ColorScheme.surfaceVariant
                                        onExited: parent.color = model.inUse ? Theme.ColorScheme.primary : "transparent"
                                        
                                        onClicked: {
                                            if (model.inUse) return
                                            
                                            selectedSSID = model.ssid
                                            
                                            if (model.security && model.security.length > 0 && model.security !== "--") {
                                                showPasswordDialog = true
                                                passwordField.text = ""
                                                passwordField.forceActiveFocus()
                                            } else {
                                                connectProcess.connectToNetwork(model.ssid, "")
                                            }
                                        }
                                    }
                                    
                                    Row {
                                        anchors.fill: parent
                                        anchors.margins: 12
                                        spacing: 8
                                        
                                        // Fixed-width indicator space (always present for alignment)
                                        Item {
                                            width: 8
                                            height: parent.height
                                            
                                            Rectangle {
                                                width: 8
                                                height: 8
                                                radius: 4
                                                color: Theme.ColorScheme.success
                                                anchors.centerIn: parent
                                                visible: model.inUse
                                            }
                                        }
                                        
                                        Text {
                                            text: model.ssid
                                            color: model.inUse ? Theme.ColorScheme.primaryText : Theme.ColorScheme.textHighEmphasis
                                            font.family: Theme.WidgetStyle.fontFamily
                                            font.pixelSize: 14
                                            font.weight: model.inUse ? Font.Bold : Font.Normal
                                            anchors.verticalCenter: parent.verticalCenter
                                            elide: Text.ElideRight
                                            width: parent.width - 60  // Fixed width for text
                                        }
                                        
                                        Item {
                                            Layout.fillWidth: true  // Spacer
                                        }
                                        
                                        // Fixed-width icon space
                                        Item {
                                            width: 20
                                            height: 20
                                            anchors.verticalCenter: parent.verticalCenter
                                            
                                            property string svgPath: getWifiIcon(model.bars, true, model.hasLock)
                                            property color iconColor: getSignalColor(model.bars, true)
                                            
                                            Image {
                                                width: 20
                                                height: 20
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
                                }
                            }
                        }
                    }
                }

                // Bluetooth Tab Content
                Column {
                    width: parent.width
                    spacing: 8
                    visible: currentTab === 1

                    Row {
                        width: parent.width
                        spacing: 8

                        Text {
                            text: isBluetoothEnabled ? "Bluetooth On" : "Bluetooth Off"
                            color: Theme.ColorScheme.textMediumEmphasis
                            font.family: Theme.WidgetStyle.fontFamily
                            font.pixelSize: 13
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Item { Layout.fillWidth: true; width: 1 }

                        Button {
                            text: isBluetoothEnabled ? "Turn Off" : "Turn On"
                            font.family: Theme.WidgetStyle.fontFamily
                            font.pixelSize: 11
                            
                            background: Rectangle {
                                color: parent.pressed ? Theme.ColorScheme.surfaceDim : Theme.ColorScheme.surfaceVariant
                                radius: Theme.WidgetStyle.cornerRadius
                            }
                            
                            contentItem: Text {
                                text: parent.text
                                font: parent.font
                                color: Theme.ColorScheme.textHighEmphasis
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            
                            onClicked: toggleBluetoothPower()
                        }
                    }

                    ScrollView {
                        width: parent.width
                        height: Math.min(300, bluetoothDevicesModel.count * 52)
                        clip: true
                        visible: isBluetoothEnabled

                        Column {
                            width: parent.width
                            spacing: 4

                            Repeater {
                                model: bluetoothDevicesModel
                                
                                delegate: Rectangle {
                                    width: parent.width
                                    height: 48
                                    color: model.connected ? Theme.ColorScheme.primary : "transparent"
                                    radius: Theme.WidgetStyle.cornerRadius
                                    
                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        
                                        onEntered: parent.color = model.connected ? Theme.ColorScheme.primary : Theme.ColorScheme.surfaceVariant
                                        onExited: parent.color = model.connected ? Theme.ColorScheme.primary : "transparent"
                                        
                                        onClicked: {
                                            if (model.connected) {
                                                disconnectBluetoothDevice(model.deviceObj)
                                            } else {
                                                connectBluetoothDevice(model.deviceObj)
                                            }
                                        }
                                    }
                                    
                                    Row {
                                        anchors.fill: parent
                                        anchors.margins: 12
                                        spacing: 8
                                        
                                        // Fixed-width indicator space (always present for alignment)
                                        Item {
                                            width: 8
                                            height: parent.height
                                            
                                            Rectangle {
                                                width: 8
                                                height: 8
                                                radius: 4
                                                color: Theme.ColorScheme.success
                                                anchors.centerIn: parent
                                                visible: model.connected
                                            }
                                        }
                                        
                                        Column {
                                            anchors.verticalCenter: parent.verticalCenter
                                            spacing: 2
                                            width: parent.width - 60
                                            
                                            Text {
                                                text: model.name
                                                color: model.connected ? Theme.ColorScheme.primaryText : Theme.ColorScheme.textHighEmphasis
                                                font.family: Theme.WidgetStyle.fontFamily
                                                font.pixelSize: 14
                                                font.weight: model.connected ? Font.Bold : Font.Normal
                                                elide: Text.ElideRight
                                                width: parent.width
                                            }
                                            
                                            Text {
                                                text: model.paired ? "Paired" : "Not paired"
                                                color: Theme.ColorScheme.textLowEmphasis
                                                font.family: Theme.WidgetStyle.fontFamily
                                                font.pixelSize: 11
                                                visible: !model.connected
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    Text {
                        text: "No devices found"
                        color: Theme.ColorScheme.textMediumEmphasis
                        font.family: Theme.WidgetStyle.fontFamily
                        font.pixelSize: 13
                        visible: isBluetoothEnabled && bluetoothDevicesModel.count === 0
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                // Password dialog
                Rectangle {
                    width: parent.width
                    height: 140
                    color: Theme.ColorScheme.surfaceVariant
                    radius: Theme.WidgetStyle.cornerRadius
                    visible: showPasswordDialog

                    Column {
                        anchors.fill: parent
                        anchors.margins: 12
                        spacing: 12

                        Text {
                            text: "Enter password for:"
                            color: Theme.ColorScheme.textMediumEmphasis
                            font.family: Theme.WidgetStyle.fontFamily
                            font.pixelSize: 12
                        }

                        Text {
                            text: selectedSSID
                            color: Theme.ColorScheme.textHighEmphasis
                            font.family: Theme.WidgetStyle.fontFamily
                            font.pixelSize: 14
                            font.bold: true
                        }

                        TextField {
                            id: passwordField
                            width: parent.width
                            echoMode: TextInput.Password
                            placeholderText: "Password"
                            font.family: Theme.WidgetStyle.fontFamily
                            font.pixelSize: 13
                            
                            background: Rectangle {
                                color: Theme.ColorScheme.surface
                                radius: Theme.WidgetStyle.cornerRadius
                                border.color: passwordField.activeFocus ? Theme.ColorScheme.primary : Theme.ColorScheme.outline
                                border.width: 1
                            }
                            
                            color: Theme.ColorScheme.textHighEmphasis
                            selectionColor: Theme.ColorScheme.primary
                            selectedTextColor: Theme.ColorScheme.primaryText
                            placeholderTextColor: Theme.ColorScheme.textLowEmphasis
                            
                            Keys.onReturnPressed: {
                                connectProcess.connectToNetwork(selectedSSID, passwordField.text)
                                showPasswordDialog = false
                            }
                        }

                        Row {
                            spacing: 8
                            
                            Button {
                                text: "Connect"
                                font.family: Theme.WidgetStyle.fontFamily
                                
                                background: Rectangle {
                                    color: parent.pressed ? Theme.ColorScheme.primaryContainer : Theme.ColorScheme.primary
                                    radius: Theme.WidgetStyle.cornerRadius
                                }
                                
                                contentItem: Text {
                                    text: parent.text
                                    font: parent.font
                                    color: Theme.ColorScheme.primaryText
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                
                                onClicked: {
                                    connectProcess.connectToNetwork(selectedSSID, passwordField.text)
                                    showPasswordDialog = false
                                }
                            }
                            
                            Button {
                                text: "Cancel"
                                font.family: Theme.WidgetStyle.fontFamily
                                
                                background: Rectangle {
                                    color: parent.pressed ? Theme.ColorScheme.surfaceDim : Theme.ColorScheme.surfaceVariant
                                    radius: Theme.WidgetStyle.cornerRadius
                                }
                                
                                contentItem: Text {
                                    text: parent.text
                                    font: parent.font
                                    color: Theme.ColorScheme.textHighEmphasis
                                    horizontalAlignment: Text.AlignHCenter
                                    verticalAlignment: Text.AlignVCenter
                                }
                                
                                onClicked: {
                                    showPasswordDialog = false
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 1
                    color: Theme.ColorScheme.outline
                    visible: !showPasswordDialog
                }

                // Footer actions
                Row {
                    width: parent.width
                    spacing: 8
                    visible: !showPasswordDialog

                    Button {
                        text: currentTab === 0 ? "↻ Refresh WiFi" : (Bluetooth.adapter?.discovering ? "⏸ Stop Scan" : "🔍 Scan")
                        font.family: Theme.WidgetStyle.fontFamily
                        font.pixelSize: 12
                        
                        background: Rectangle {
                            color: parent.pressed ? Theme.ColorScheme.surfaceDim : Theme.ColorScheme.surfaceVariant
                            radius: Theme.WidgetStyle.cornerRadius
                        }
                        
                        contentItem: Text {
                            text: parent.text
                            font: parent.font
                            color: Theme.ColorScheme.textHighEmphasis
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        
                        onClicked: {
                            if (currentTab === 0) {
                                rescanProcess.running = true
                            } else {
                                if (Bluetooth.adapter?.discovering) {
                                    stopBluetoothDiscovery()
                                } else {
                                    startBluetoothDiscovery()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}