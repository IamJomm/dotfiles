import QtQuick
import QtQuick.Layouts
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
  readonly property int cardWidth: 350
  property bool shouldShowAppLauncher: false
  property int current: 0

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

    PanelWindow {
      property real windowOpacity: 1

      implicitWidth: content.implicitWidth
      exclusiveZone: 0
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
      HyprlandWindow.opacity: windowOpacity
      color: "transparent"

      Behavior on HyprlandWindow.opacity {
        NumberAnimation {
          duration: Theme.animationSpeed
          easing.type: Easing.OutCubic
        }
      }
      mask: Region {
        item: content
      }

      anchors {
        top: true
        bottom: true
      }
      AppLauncherBackend {
        id: appLauncherBackend
      }
      Process {
        id: runApp

        command: ["sh", "-c", ""]
      }
      ColumnLayout {
        id: content

        spacing: Theme.spacing

        anchors {
          bottom: parent.bottom
          bottomMargin: Theme.spacing * 2
        }
        Item {
          implicitWidth: appListContainer.implicitWidth
          implicitHeight: appListContainer.implicitHeight

          AppList {
            id: appListContainer

            rows: root.rows
            columns: root.columns
            cardWidth: root.cardWidth
            appList: appLauncherBackend.appList
            current: root.current

            NumberAnimation on y {
              id: appListContainerAnimation

              duration: Theme.animationSpeed
              easing.type: Easing.OutCubic
              running: false
              to: 0
            }

            onTriggered: exec => {
              runApp.command[2] = exec;
              runApp.startDetached();
              hideWindow();
            }
            Component.onCompleted: {
              root.current = 0;
              y = height + searchField.height + Theme.spacing * 3;
              appListContainerAnimation.running = true;
            }
          }
        }
        Item {
          Layout.fillWidth: true
          implicitHeight: searchField.implicitHeight

          SearchField {
            id: searchField

            filterAppList: appLauncherBackend.filterAppList

            SequentialAnimation on y {
              id: searchFieldAnimation

              running: false

              PauseAnimation {
                duration: Theme.animationSpeed / 2
              }
              NumberAnimation {
                duration: Theme.animationSpeed
                easing.type: Easing.OutCubic
                to: 0
              }
            }

            onEscapePressed: hideWindow()
            onEnterPressed: console.log("hello")
            onNPressed: current++
            onPPressed: current--
            onFPressed: current += rows
            onBPressed: current -= rows
            Component.onCompleted: {
              y = height + Theme.spacing * 2;
              searchFieldAnimation.running = true;
            }
          }
        }
      }
    }
  }
}
