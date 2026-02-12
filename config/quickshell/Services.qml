pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Services.Pipewire
import QtQuick

Item {
  signal volumeChanged()
  signal newNotification(notification: Notification)
 
  Connections {
    target: NotificationServer {}
    function onNotification(n) {
      newNotification(n)
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
}
