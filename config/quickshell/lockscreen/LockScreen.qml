import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import ".."

Scope {
  id: root

  property bool shouldShowLockScreen: false
  property string focusedTitle

  IpcHandler {
    target: "lockScreen"
    function lock() {
      if(Hyprland.activeToplevel) root.focusedTitle = Hyprland.activeToplevel.title
      root.shouldShowLockScreen = true
    }
  }

  LockContext {
    id: lockContext
    onUnlocked: {
    	lockLoader.item.locked = false
      if(root.focusedTitle) Hyprland.dispatch(`focuswindow title:${root.focusedTitle}`)
      root.shouldShowLockScreen = false
      currentText = ""
    }
	}

  LazyLoader {
    id: lockLoader
    active: root.shouldShowLockScreen
	  WlSessionLock {
	  	id: lock
	  	locked: true
	  	WlSessionLockSurface { LockSurface { context: lockContext } }
    }
  }
}
