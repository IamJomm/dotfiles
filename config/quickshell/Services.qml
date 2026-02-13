pragma Singleton

import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Services.Pipewire
import QtQuick

Item {
  signal volumeChanged()
  signal newNotification(iconSource: string, titleText: string, bodyText: string)
 
  Connections {
    target: NotificationServer {}
    function onNotification(n) {
      newNotification(n.image, `${n.appName} ${n.summary}`,  n.body)
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
