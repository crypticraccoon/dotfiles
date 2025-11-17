import Quickshell
import QtQuick
import Quickshell.Wayland

Scope {
    id: background

    PanelWindow {
        id: wallpaper
        anchors {
            top: true
            bottom: true
            left: true
            right: true
        }
        Rectangle {
            anchors.fill: parent

            border {
                width: 4
                color: "red"
            }
            radius: 24
            Image {
                anchors.fill: parent
                source: "../../assets/eyes_anime.png"
                fillMode: Image.PreserveAspectCrop
            }
        }
        WlrLayershell.layer: WlrLayer.Background
        exclusionMode: ExclusionMode.Ignore
    }
}
