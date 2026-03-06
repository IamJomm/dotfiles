import QtQuick
import Quickshell
import Quickshell.Hyprland
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
      var n = Services.notificationList.get(0);
      root.icon = n.icon;
      root.title = n.title;
      root.time = n.time;
      root.body = n.body;
      if (shouldShowNotification) {
        popupLoader.item.windowOpacity = 1;
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
      popupLoader.item.windowOpacity = 0;
      hideWindow.start();
    }
  }
  LazyLoader {
    id: popupLoader

    active: root.shouldShowNotification

    PanelWindow {
      property real windowOpacity: 0

      HyprlandWindow.opacity: windowOpacity
      color: "transparent"
      exclusiveZone: 0
      implicitWidth: card.implicitWidth
      margins.top: 30

      Behavior on HyprlandWindow.opacity {
        NumberAnimation {
          duration: Theme.animationSpeed
          easing.type: Easing.OutCubic
        }
      }
      mask: Region {
        item: card
      }

      Component.onCompleted: {
        windowOpacity = 1;
        hideAnimation.start();
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
        titleText: root.title

        onFocusLost: hideAnimation.start()
        onFocused: {
          hideAnimation.stop();
          hideWindow.stop();
          windowOpacity = 1;
        }
      }
    }
  }
}
