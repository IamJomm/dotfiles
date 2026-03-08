pragma Singleton
import QtQuick

import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Services.Notifications
import Quickshell.Services.Pipewire

Item {
  property MprisPlayer currentPlayer
  property ListModel notificationList: ListModel {
  }
  readonly property string time: Qt.formatDateTime(clock.date, "hh:mm:ss dd/MM/yyyy")

  signal currentTrackChanged
  signal currentTrackStatusChanged
  signal newNotification
  signal trackPositionChanged
  signal volumeChanged

  Connections {
    function onNotification(notification) {
      notificationList.insert(0, {
        "icon": notification.image,
        "title": notification.summary,
        "time": Date.now(),
        "body": notification.body
      });
      newNotification();
    }

    target: NotificationServer {
    }
  }
  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }
  Connections {
    function onVolumeChanged() {
      volumeChanged();
    }

    target: Pipewire.defaultAudioSink?.audio
  }
  Timer {
    interval: 1000
    repeat: true
    running: currentPlayer && currentPlayer.isPlaying
    triggeredOnStart: true

    onTriggered: trackPositionChanged()
  }
  Repeater {
    model: Mpris.players

    Item {
      Connections {
        function onIsPlayingChanged() {
          currentTrackStatusChanged();
        }
        function onTrackChanged() {
          currentPlayer = modelData;
          currentTrackChanged();
        }

        target: modelData
      }
    }
  }
  SystemClock {
    id: clock

    precision: SystemClock.Seconds
  }
}
