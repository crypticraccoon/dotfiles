pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import qs.ui.widgets
import QtQuick.Effects

Scope {
    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData

            screen: modelData

            anchors {
                top: true
                left: true
                right: true
            }
            implicitHeight: 30
            Component {
                TimeWidget {}
            }

            Item {
                id: testRect
                layer.enabled: true
                visible: false
                anchors.fill: parent
                Rectangle {

                    anchors.fill: parent
                    radius: 9999

                    topLeftRadius: 15
                    topRightRadius: 15
                    bottomLeftRadius: 15
                    bottomRightRadius: 15
                    anchors.topMargin: 15
                    anchors.leftMargin: 15
                    anchors.rightMargin: 15
                    anchors.bottomMargin: 15
                }
            }

            Rectangle {
                id: contentBackground
                anchors.fill: parent
                anchors.topMargin: 15
                anchors.leftMargin: 15
                anchors.rightMargin: 15
                anchors.bottomMargin: 15
                color: "red"

                topLeftRadius: 15
                topRightRadius: 15
                bottomLeftRadius: 15
                bottomRightRadius: 15
            }

            Rectangle {
                id: contentBorder
                anchors.fill: parent
                color: "green"
                visible: true

                topLeftRadius: 15
                topRightRadius: 15
                bottomLeftRadius: 15
                bottomRightRadius: 15

                layer.enabled: true

                layer.effect: MultiEffect {
                    maskInverted: true
                    maskEnabled: true
                    maskSource: testRect
                    source: contentBorder
                    maskThresholdMin: 0.5
                    maskSpreadAtMin: 1
                }
            }
        }
    }
}
