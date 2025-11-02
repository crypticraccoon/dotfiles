import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Quickshell
import Quickshell.Services.UPower
import "widgets/bar"
import "widgets/panel"
import "widgets/osd"
import "theme" as Theme

Scope {
    // Floating OSD widgets (not in panel)
    VolumeOSD {
        id: volumeOSD
    }

    BrightnessOSD {
        id: brightnessOSD
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: bar
            objectName: "bar"
            anchors {
                top: true
                left: true
                right: true
            }
            implicitHeight: 30

            required property var modelData
            screen: modelData
            color: "#101010"

            Item {
                id: panelContent
                anchors.fill: parent

                RowLayout {
                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                        // rightMargin: 8
                    }
                    spacing: Theme.WidgetStyle.widgetSpacing

                    TimeWidget {
                        id: clockWidget
                    }

                    // Spacer pushes widgets to the right
                    Item {
                        Layout.fillWidth: true
                    }

                    NetworkWidget {
                        id: networkWidget
                        height: 30
                    }

                    PowerProfileWidget {
                        id: profileWidget
                        height: 30
                    }

                    BatteryWidget {
                        id: batteryWidget
                        height: 30
                    }

                    ClockWidget {
                        id: clockWidge
                        height: 30
                    }
                }
            }
        }
    }
}
