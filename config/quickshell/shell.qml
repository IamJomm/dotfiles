//@ pragma UseQApplication

import Quickshell
import "bar"
import "lockscreen"
import "mpris"
import "notifications"
import "powermenu"

ShellRoot {
  NotificationPopup {}
  PlayerPopup {}
  LockScreen {}
  PowerMenu {}
  Bar {}
  Osd {}
  Test {}
}
