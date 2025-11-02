import QtQuick
import Quickshell
import QtQuick.Controls
import "../../utils"
import "../../theme" as Theme

Variants {
    model: QuickShell.screens
    Button {
        id: clockWidget
        width: 100
        height: 30

        padding: 0
        indicator: null

        background: Rectangle {
            anchors.fill: parent
            anchors.topMargin: Theme.WidgetStyle.outerMargin
            anchors.bottomMargin: Theme.WidgetStyle.outerMargin

            color: clockWidget.pressed ? Theme.WidgetStyle.pressedColor : (clockWidget.hovered ? Theme.WidgetStyle.hoverColor : Theme.WidgetStyle.normalColor)

            // Asymmetric corners - square left, rounded right
            topLeftRadius: Theme.WidgetStyle.cornerRadius
            bottomLeftRadius: Theme.WidgetStyle.cornerRadius
            topRightRadius: height / 2
            bottomRightRadius: height / 2

            Behavior on color {
                ColorAnimation {
                    duration: Theme.WidgetStyle.colorTransitionDuration
                }
            }
        }

        contentItem: Item {
            anchors.fill: parent
            anchors.margins: Theme.WidgetStyle.innerMargin

            Row {
                anchors.centerIn: parent
                spacing: 6

                // Time display (HH:mm)
                Text {
                    text: Time.hours24 + " " + Time.minutes
                    font.family: Theme.WidgetStyle.fontFamily
                    font.pixelSize: 13
                    font.weight: Font.Bold // clockWidget.hovered ? Font.Bold : Font.Light
                    color: Theme.ColorScheme.textHighEmphasis
                    anchors.verticalCenter: parent.verticalCenter

                    Behavior on font.weight {
                        NumberAnimation {
                            duration: 200
                            easing.type: Easing.OutCubic
                        }
                    }
                }

                // Bullet point separator
                Text {
                    text: "•"
                    font.family: Theme.WidgetStyle.fontFamily
                    font.pixelSize: 16
                    font.weight: Font.Bold
                    color: Theme.ColorScheme.textMediumEmphasis
                    anchors.verticalCenter: parent.verticalCenter
                }

                // Date display (DD/MM) with diagonal layout
                Item {
                    width: 35
                    height: parent.height

                    // Day (top)
                    Text {
                        text: Time.day
                        font.family: Theme.WidgetStyle.fontFamily
                        font.pixelSize: 11
                        font.weight: clockWidget.hovered ? Font.Bold : Font.Light
                        color: Theme.ColorScheme.textHighEmphasis
                        anchors.top: parent.top
                        anchors.topMargin: 2
                        anchors.left: parent.left

                        Behavior on font.weight {
                            NumberAnimation {
                                duration: 200
                                easing.type: Easing.OutCubic
                            }
                        }
                    }

                    // Diagonal separator
                    Rectangle {
                        width: 1
                        height: Math.sqrt(parent.width * parent.width + parent.height * parent.height) * 0.6
                        color: Theme.ColorScheme.textMediumEmphasis
                        anchors.centerIn: parent
                        rotation: 45
                    }

                    // Month (bottom)
                    Text {
                        text: Time.month
                        font.family: Theme.WidgetStyle.fontFamily
                        font.pixelSize: 11
                        font.weight: clockWidget.hovered ? Font.Bold : Font.Light
                        color: Theme.ColorScheme.textHighEmphasis
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 2
                        anchors.right: parent.right

                        Behavior on font.weight {
                            NumberAnimation {
                                duration: 200
                                easing.type: Easing.OutCubic
                            }
                        }
                    }
                }
            }
        }
    }
}
