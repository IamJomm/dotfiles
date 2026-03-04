import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import ".."

Scope {
  id: root
  
  property bool shouldShowTrack: false

  Connections {
    target: Services
    function onCurrentTrackChanged() {
      root.shouldShowTrack = true
      if(shouldShowTrack) {
        popupLoader.item.cardOpacity = 1
        hideWindow.stop()
        hideAnimation.restart()
      }
      else root.shouldShowTrack = true
    }
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
      popupLoader.item.cardOpacity = 0
      hideWindow.start()
    }
  }

  LazyLoader {
    id: popupLoader
    active: root.shouldShowTrack
    PanelWindow {
      property alias cardOpacity: card.opacity

      anchors {
        top: true
        left: true
      }
      margins {
        top: 30
        left: 30
      }
      exclusiveZone: 0
      implicitWidth: card.implicitWidth
      implicitHeight: card.implicitHeight
      color: "transparent"
      PlayerCard {
        id: card
        cardWidth: 350
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
