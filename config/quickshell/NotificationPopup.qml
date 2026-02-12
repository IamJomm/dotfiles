import Quickshell
import Quickshell.Services.Notifications
import QtQuick

Scope {
  id: root

  property Notification currentNotification
  property bool shouldShowNotification: false

  Connections {
    target: Services
    function onNewNotification(notification) {
      root.currentNotification = notification
      root.shouldShowNotification = true
      hideTimer.restart()
    }
  }

  Timer {
    id: hideTimer
    interval: 5000
    onTriggered: root.shouldShowNotification = false
  }

  LazyLoader {
    active: root.shouldShowNotification
    PanelWindow {
      anchors.top: true
      margins.top: screen.height / 20
      exclusiveZone: 0
      implicitWidth: card.implicitWidth
      implicitHeight: card.implicitHeight
      color: "transparent"
      NotificationCard { 
        id: card
        notification: root.currentNotification
      }
    }
  }
}
