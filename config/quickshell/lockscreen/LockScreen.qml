import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland
import ".."

Scope {
  id: root

  property string focusedTitle
  property bool shouldShowLockScreen: false

  IpcHandler {
    function lock() {
      if (Hyprland.activeToplevel)
        root.focusedTitle = Hyprland.activeToplevel.title;
      root.shouldShowLockScreen = true;
    }

    target: "lockScreen"
  }
  LockContext {
    id: lockContext

    onUnlocked: {
      lockLoader.item.locked = false;
      if (root.focusedTitle)
        Hyprland.dispatch(`focuswindow title:${root.focusedTitle}`);
      root.shouldShowLockScreen = false;
      currentText = "";
    }
  }
  LazyLoader {
    id: lockLoader

    active: root.shouldShowLockScreen

    WlSessionLock {
      id: lock

      locked: true

      WlSessionLockSurface {
        LockSurface {
          context: lockContext
        }
      }
    }
  }
}
