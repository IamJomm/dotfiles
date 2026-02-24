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
      hideTimer.restart()
    }
  }

  Timer {
    id: hideTimer
    interval: 3000
    onTriggered: root.shouldShowTrack = false
  }

  LazyLoader {
    active: root.shouldShowTrack
    PanelWindow {
      anchors.top: true
      margins.top: screen.height / 20
      exclusiveZone: 0
      implicitWidth: card.width
      implicitHeight: card.height
      color: "transparent"
      PlayerCard {
        id: card
        cardWidth: 350
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
