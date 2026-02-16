//@ pragma UseQApplication

import Quickshell
import "notifications"
import "mpris"
import "powerMenu"
import "bar"

ShellRoot {
  NotificationPopup {}
  PlayerPopup {}
  LockScreen {}
  PowerMenu {}
  Bar {}
  Osd {}
}
