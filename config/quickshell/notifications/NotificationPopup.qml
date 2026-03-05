import QtQuick
import Quickshell
import Quickshell.Services.Notifications
import ".."

Scope {
  id: root

  property string body
  property string icon
  property bool shouldShowNotification: false
  property double time
  property string title

  Connections {
    function onNewNotification() {
      if (Settings.dnd)
        return;
      root.icon = Services.notificationList.get(0).icon;
      root.title = Services.notificationList.get(0).title;
      root.time = Services.notificationList.get(0).time;
      root.body = Services.notificationList.get(0).body;
      if (shouldShowNotification) {
        popupLoader.item.cardOpacity = 1;
        hideWindow.stop();
        hideAnimation.restart();
      } else
        root.shouldShowNotification = true;
    }

    target: Services
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
      popupLoader.item.cardOpacity = 0;
      hideWindow.start();
    }
  }
  LazyLoader {
    id: popupLoader

    active: root.shouldShowNotification

    PanelWindow {
      property alias cardOpacity: card.opacity

      color: "transparent"
      exclusiveZone: 0
      implicitWidth: card.implicitWidth
      margins.top: 30

      mask: Region {
        item: card
      }

      anchors {
        bottom: true
        top: true
      }
      NotificationCard {
        id: card

        bodyText: root.body
        creationTime: root.time
        iconSource: root.icon
        opacity: 0
        titleText: root.title

        Behavior on opacity {
          NumberAnimation {
            duration: Theme.animationSpeed
            easing.type: Easing.OutCubic
          }
        }

        Component.onCompleted: {
          opacity = 1;
          hideAnimation.start();
        }
        onFocusLost: hideAnimation.start()
        onFocused: {
          hideAnimation.stop();
          hideWindow.stop();
          opacity = 1;
        }
      }
    }
  }
}
