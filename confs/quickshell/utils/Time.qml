
pragma Singleton

import Quickshell
import QtQuick

Singleton {
   id: root   
   readonly property string hours24: Qt.formatDateTime(clock.date, "HH")
   readonly property string minutes: Qt.formatDateTime(clock.date, "mm")
   readonly property string day: Qt.formatDateTime(clock.date, "dd")
   readonly property string month: Qt.formatDateTime(clock.date, "MM")
   
   SystemClock {
      id: clock
      precision: SystemClock.Minutes
   }
}

