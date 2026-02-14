pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Services.Pipewire
import QtQuick

Item {
  readonly property string time: Qt.formatDateTime(clock.date, "hh:mm:ss dd/MM/yyyy")
  signal volumeChanged()
  signal newNotification(iconSource: string, titleText: string, bodyText: string)
 
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

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  } 
}
