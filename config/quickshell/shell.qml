//@ pragma UseQApplication

import Quickshell
import "notifications"
import "mpris"
import "powerMenu"
import "bar"

ShellRoot {
  NotificationPopup {}
  TrackPopup {}
  LockScreen {}
  PowerMenu {}
  Bar {}
  Osd {}
}
