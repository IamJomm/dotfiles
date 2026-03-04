//@ pragma UseQApplication

import Quickshell
import "notifications"
import "lockscreen"
import "powermenu"
import "mpris"
import "bar"

ShellRoot {
  NotificationPopup {}
  PlayerPopup {}
  LockScreen {}
  PowerMenu {}
  Bar {}
  Osd {}
  Test {}
}
