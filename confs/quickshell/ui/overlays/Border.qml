pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import QtQuick.Effects

import Quickshell.Wayland

//import Qt5Compat.GraphicalEffects

//import qs.modules.common

Scope {
    id: border
    Variants {
        model: {
            const screens = Quickshell.screens;
            const list = [];
            //if (!list || list.length === 0)
            //return screens;
            return screens.filter(screen => list.includes(screen.name));
        }

        LazyLoader {
            id: borderLoader
            active: true
            required property ShellScreen modelData
            component: PanelWindow {
                id: borderWindow
                screen: borderLoader.modelData
                property string position: "left"
                property int margin: 25
                property int borderWidth: 3
                property int borderRadius: 5
                property bool borderScreen: true

                property int defaultMargin: 16

                property int topMargin: position === "top" ? 0 : margin
                property int rightMargin: position === "right" ? 0 : margin
                property int bottomMargin: position === "bottom" ? 0 : margin
                property int leftMargin: position === "left" ? 0 : margin

                // function setGaps() {
                //     let gaps_out = `${topMargin + defaultMargin},${rightMargin + defaultMargin},${bottomMargin + defaultMargin},${leftMargin + defaultMargin}`;
                //     if (!borderScreen) {
                //         gaps_out = `${defaultMargin},${defaultMargin},${defaultMargin},${defaultMargin}`;
                //     }
                //     console.log(borderScreen, margin, position)
                //     Quickshell.execDetached(["hyprctl", "keyword", "general:gaps_out", gaps_out]);
                // }
                //
                // Timer {
                //     id: gapsTimer
                //     interval: 500
                //     repeat: false
                //     onTriggered: setGaps()
                // }
                //
                // onPositionChanged: gapsTimer.running = true
                //
                // onMarginChanged: gapsTimer.running = true
                //
                // onBorderScreenChanged: gapsTimer.running = true
                //
                // Component.onCompleted: gapsTimer.running = true

                WlrLayershell.layer: WlrLayer.Top
                mask: Region {}
                color: "#00000000"

                anchors {
                    top: true
                    bottom: true
                    left: true
                    right: true
                }
                Item {
                    anchors.fill: parent

                    Rectangle {
                        id: backgroundContent
                        anchors.fill: parent
                        color: "green"
                        layer.enabled: true

                        layer.effect: MultiEffect {
                            maskInverted: true
                            maskEnabled: true
                            maskSource: holeMaskSource
                            source: backgroundContent
                            maskThresholdMin: 0.5
                            maskSpreadAtMin: 1
                        }
                        Rectangle {
                            anchors.fill: parent
                            color: "green"
                            radius: borderWindow.borderRadius + 5
                            anchors.topMargin: borderWindow.topMargin
                            anchors.bottomMargin: borderWindow.bottomMargin
                            anchors.leftMargin: borderWindow.leftMargin
                            anchors.rightMargin: borderWindow.rightMargin
                            //
                            // layer.enabled: true
                            //
                            // layer.effect: MultiEffect {
                            //     maskInverted: true
                            //     maskEnabled: true
                            //     maskSource: holeMaskSource
                            //     source: backgroundContent
                            //     maskThresholdMin: 0.5
                            //     maskSpreadAtMin: 1
                            //   }
                        }
                    }

                    Item {
                        id: holeMaskSource
                        anchors.fill: parent

                        layer.enabled: true
                        visible: true
                        // Black rectangle — this defines the "hole" area
                        Rectangle {
                            anchors.fill: parent
                            anchors.topMargin: borderWindow.topMargin + 5
                            anchors.bottomMargin: borderWindow.bottomMargin + 5
                            anchors.leftMargin: borderWindow.leftMargin + 5
                            anchors.rightMargin: borderWindow.rightMargin + 5
                            radius: borderWindow.borderRadius
                        }
                    }
                }
            }
        }
    }
}
