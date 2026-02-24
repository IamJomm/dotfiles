import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import ".."

Scope {
  id: root
  
  property string icon
  property string title
  property string body
  property bool shouldShowNotification: false

  Connections {
    target: Services
    function onNewNotification() {
      if(Settings.dnd) return
      root.icon = Services.notificationList.get(0).icon
      root.title = Services.notificationList.get(0).title
      root.body = Services.notificationList.get(0).body
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
        iconSource: root.icon
        titleText: root.title
        bodyText: root.body
        onFocused: hideTimer.stop()
        onFocusLost: hideTimer.start()
        opacity: 0
        NumberAnimation on opacity {
          id: cardAnimation
          running: false
          to: 1; duration: Theme.animationSpeed
          easing.type: Easing.OutCubic
        }
        Component.onCompleted: { cardAnimation.running = true }
      }
    }
  }
}
