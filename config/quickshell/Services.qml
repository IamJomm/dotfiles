pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Services.Pipewire
import Quickshell.Services.Mpris
import QtQuick

Item {
  readonly property string time: Qt.formatDateTime(clock.date, "hh:mm:ss dd/MM/yyyy")
  property ListModel notificationList: ListModel{}
  property MprisPlayer currentPlayer
  signal volumeChanged()
  signal newNotification()
  signal currentTrackChanged()
  signal trackPositionChanged()
 
  Connections {
    target: NotificationServer {}
    function onNotification(notification) {
      notificationList.insert(0, {"icon": notification.image, "title": notification.summary, "time": Date.now(),"body": notification.body})
      newNotification()
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
    running: currentPlayer && currentPlayer.playbackState == MprisPlaybackState.Playing
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
          currentPlayer = modelData
          currentTrackChanged()
        }
      }
    }
  }

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  } 
}
