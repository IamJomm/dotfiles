import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Scope {
  id: root

  property bool shouldShowNotification: false

  Timer {
    id: hideTimer
    interval: 5000
    onTriggered: root.shouldShowNotification = false
  }

  LazyLoader {
    active: root.shouldShowNotification
    PanelWindow {

    }
  }
}
