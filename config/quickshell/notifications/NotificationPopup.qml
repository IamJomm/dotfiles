import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import ".."

Scope {
  id: root
  
  property string iconSource
  property string titleText
  property string bodyText
  property bool shouldShowNotification: false

  Connections {
    target: Services
    function onNewNotification(iconSource, titleText, bodyText) {
      if(!Settings.notifications) return
      root.iconSource = iconSource
      root.titleText = titleText
      root.bodyText = bodyText
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
      implicitWidth: card.width
      implicitHeight: card.height
      color: "transparent"
      NotificationCard { 
        id: card
        iconSource: root.iconSource
        titleText: root.titleText
        bodyText: root.bodyText
        notification: root.currentNotification
        onFocused: hideTimer.stop()
        onFocusLost: hideTimer.start()
      }
    }
  }
}
