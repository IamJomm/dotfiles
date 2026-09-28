import QtQuick
import Quickshell
import Quickshell.Backend
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland
import ".."

Scope {
  id: root

  readonly property int rows: 5
  readonly property int columns: 3
  readonly property int cardWidth: 300
  property bool shouldShowAppLauncher: false

  function hideWindow() {
    appLauncherLoader.item.windowOpacity = 0;
    hideWindowTimer.start();
  }

  Timer {
    id: hideWindowTimer

    interval: Theme.animationSpeed

    onTriggered: root.shouldShowAppLauncher = false
  }
  IpcHandler {
    function toggle() {
      if (hideWindowTimer.running)
        return;
      if (!root.shouldShowAppLauncher)
        root.shouldShowAppLauncher = true;
      else {
        hideWindow();
      }
    }

    target: "appLauncher"
  }
  LazyLoader {
    id: appLauncherLoader

    active: root.shouldShowAppLauncher

    Item {
      property alias windowOpacity: menu.windowOpacity

      AppLauncherBackend {
        id: appLauncherBackend
      }
      Menu {
        id: menu

        elementList: appLauncherBackend.appList
        filterElementList: appLauncherBackend.filterAppList
        hideWindow: root.hideWindow
        cardWidth: root.cardWidth
        rows: root.rows
        columns: root.columns
      }
    }
  }
}
