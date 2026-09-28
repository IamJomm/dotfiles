//@ pragma UseQApplication

import Quickshell
import "bar"
import "lockscreen"
import "menu"
import "mpris"
import "notifications"
import "powermenu"

ShellRoot {
  Wallpaper {}
  Bar {}
  AppLauncher {}
  Clipboard {}
  PowerMenu {}
  LockScreen {}
  NotificationPopup {}
  PlayerPopup {}
  Osd {}
  Test {}
}
