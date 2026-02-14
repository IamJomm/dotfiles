//@ pragma UseQApplication

import Quickshell
import "bar"
import "notifications"
import "powerMenu"

ShellRoot {
  PowerMenu {}
  Osd {}
  NotificationPopup {}
  Bar {}
}
