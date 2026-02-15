import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import ".."

Scope {
  id: root
  
  property MprisPlayer player
  property bool shouldShowTrack: false

  Connections {
    target: Services
    function onTrackChanged(player) {
      root.player = player
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
      TrackCard {
        id: card
        player: root.player
        onFocused: hideTimer.stop()
        onFocusLost: hideTimer.start()
      }
    }
  }
}
