import QtQuick
import Quickshell
import Quickshell.Services.Mpris
import ".."

Scope {
  id: root

  property bool shouldShowTrack: false

  Connections {
    function onCurrentTrackChanged() {
      root.shouldShowTrack = true;
      if (shouldShowTrack) {
        popupLoader.item.cardOpacity = 1;
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
      popupLoader.item.cardOpacity = 0;
      hideWindow.start();
    }
  }
  LazyLoader {
    id: popupLoader

    active: root.shouldShowTrack

    PanelWindow {
      property alias cardOpacity: card.opacity

      color: "transparent"
      exclusiveZone: 0
      implicitHeight: card.implicitHeight
      implicitWidth: card.implicitWidth

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
        opacity: 0

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
