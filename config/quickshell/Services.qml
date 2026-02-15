pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Services.Pipewire
import Quickshell.Services.Mpris
import QtQuick

Item {
  readonly property string time: Qt.formatDateTime(clock.date, "hh:mm:ss dd/MM/yyyy")
  property MprisPlayer currentPlayer
  signal volumeChanged()
  signal newNotification(iconSource: string, titleText: string, bodyText: string)
  signal trackChanged(player: MprisPlayer)
  signal trackPositionChanged()
 
  Connections {
    target: NotificationServer {}
    function onNotification(n) {
      newNotification(n.image, n.summary,  n.body)
    }
  }

  PwObjectTracker {
		objects: [ Pipewire.defaultAudioSink ]
  }
  Connections {
		target: Pipewire.defaultAudioSink?.audio
    function onVolumeChanged() {
      volumeChanged()
		}
  }

  Timer {
    running: currentPlayer.playbackState == MprisPlaybackState.Playing
    interval: 1000
    repeat: true
    onTriggered: trackPositionChanged()
  }

  Repeater {
    model: Mpris.players
    Item {
      Connections {
        target: modelData
        function onTrackChanged() { 
          trackChanged(modelData)
          currentPlayer = modelData
        }
      }
    }
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  } 
}
