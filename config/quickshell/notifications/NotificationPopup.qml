import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import ".."

Scope {
  id: root
  
  property string icon
  property string title
  property double time
  property string body
  property bool shouldShowNotification: false

  Connections {
    target: Services
    function onNewNotification() {
      if(Settings.dnd) return
      root.icon = Services.notificationList.get(0).icon
      root.title = Services.notificationList.get(0).title
      root.time = Services.notificationList.get(0).time
      root.body = Services.notificationList.get(0).body
      if(shouldShowNotification) {
        popupLoader.item.cardOpacity = 1
        hideWindow.stop()
        hideAnimation.restart()
      }
      else root.shouldShowNotification = true
    }
  }

  Timer {
    id: hideWindow
    interval: Theme.animationSpeed
    onTriggered: root.shouldShowNotification = false
  }
  Timer {
    id: hideAnimation
    interval: 5000 - Theme.animationSpeed
    onTriggered: {
      popupLoader.item.cardOpacity = 0
      hideWindow.start()
    }
  }

  LazyLoader {
    id: popupLoader
    active: root.shouldShowNotification
    PanelWindow {
      property alias cardOpacity: card.opacity

      anchors {
        top: true
        bottom: true
      }
      margins.top: 30
      exclusiveZone: 0
      implicitWidth: card.implicitWidth
      color: "transparent"
      mask: Region { item: card }
      NotificationCard { 
        id: card
        iconSource: root.icon
        titleText: root.title
        creationTime: root.time
        bodyText: root.body
        opacity: 0
        onFocused: {
          hideAnimation.stop()
          hideWindow.stop()
          opacity = 1
        }
        onFocusLost: hideAnimation.start()
        Behavior on opacity {
          NumberAnimation {
            duration: Theme.animationSpeed
            easing.type: Easing.OutCubic
          }
        }
        Component.onCompleted: {
          opacity = 1
          hideAnimation.start()
        }
      }
    }
  }
}
