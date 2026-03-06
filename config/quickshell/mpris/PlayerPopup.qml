import QtQuick
import Quickshell

import Quickshell.Hyprland
import Quickshell.Services.Mpris
import ".."

Scope {
  id: root

  property bool shouldShowTrack: false

  Connections {
    function onCurrentTrackChanged() {
      root.shouldShowTrack = true;
      if (shouldShowTrack) {
        popupLoader.item.windowOpacity = 1;
        hideWindow.stop();
        hideAnimation.restart();
      } else
        root.shouldShowTrack = true;
    }

    target: Services
  }
  Timer {
    id: hideWindow

    interval: Theme.animationSpeed

    onTriggered: root.shouldShowTrack = false
  }
  Timer {
    id: hideAnimation

    interval: 3000 - Theme.animationSpeed

    onTriggered: {
      popupLoader.item.windowOpacity = 0;
      hideWindow.start();
    }
  }
  LazyLoader {
    id: popupLoader

    active: root.shouldShowTrack

    PanelWindow {
      property real windowOpacity: 0

      HyprlandWindow.opacity: windowOpacity
      color: "transparent"
      exclusiveZone: 0
      implicitHeight: card.implicitHeight
      implicitWidth: card.implicitWidth

      Behavior on HyprlandWindow.opacity {
        NumberAnimation {
          duration: Theme.animationSpeed
          easing.type: Easing.OutCubic
        }
      }

      Component.onCompleted: {
        windowOpacity = 1;
        hideAnimation.start();
      }

      anchors {
        left: true
        top: true
      }
      margins {
        left: 30
        top: 30
      }
      PlayerCard {
        id: card

        cardWidth: 350

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
