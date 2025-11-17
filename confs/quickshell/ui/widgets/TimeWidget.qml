import QtQuick
import QtQuick.Layouts

import "../../data"

import "../theme" as CTheme

//Time Date widget
RowLayout {
    id: timeDateWidget
    height: parent.height
    width: parent.width

    Text {
        text: Time.time
    }

    Text {
        text: "•"
        //font.family: Theme.WidgetStyle.fontFamily
        font.pixelSize: 16
        font.weight: Font.Bold
        //color: Theme.ColorScheme.textMediumEmphasis
        //anchors.verticalCenter: parent.verticalCenter
    }

    Item {

        Layout.fillWidth: parent.height
        Layout.fillHeight: parent.width

        Text {
            text: Time.day
            font.pixelSize: 11
            anchors.top: parent.top
            anchors.topMargin: 2
            anchors.left: parent.left
        }
        Rectangle {
            width: 1
            height: 24

            color: "black"
            rotation: 45
            anchors {
                verticalCenter: parent.verticalCenter
                leftMargin: 14
                left: parent.left
            }
        }

        Text {
            text: Time.month
            color: CTheme.Colors.error
            font {
                pixelSize: CTheme.Fonts.small
                family: CTheme.Fonts.family
            }
            anchors {
                leftMargin: 14
                left: parent.left
                topMargin: 14
                top: parent.top
            }
        }
    }
}
