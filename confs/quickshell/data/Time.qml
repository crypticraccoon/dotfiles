pragma Singleton

import Quickshell
import QtQuick

Singleton {
    readonly property string time: Qt.formatDateTime(clock.date, "hh:mm:ss")
    readonly property string day: Qt.formatDateTime(clock.date, "dd")
    readonly property string month: Qt.formatDateTime(clock.date, "MM")

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
