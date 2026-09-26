//@ pragma UseQApplication

import Quickshell
import "applauncher"
import "bar"
import "lockscreen"
import "mpris"
import "notifications"
import "powermenu"

ShellRoot {
  Wallpaper {}
  Bar {}
  AppLauncher {}
  PowerMenu {}
  LockScreen {}
  NotificationPopup {}
  PlayerPopup {}
  Osd {}
  Test {}
}
