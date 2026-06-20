import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Backend
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import ".."

Scope {
  id: root

  readonly property int cardWidth: 350
  property bool shouldShowAppLauncher: false

  Timer {
    id: hideWindow

    interval: Theme.animationSpeed

    onTriggered: root.shouldShowAppLauncher = false
  }
  IpcHandler {
    function toggle() {
      if (hideWindow.running)
        return;
      if (!root.shouldShowAppLauncher)
        root.shouldShowAppLauncher = true;
      else {
        appLauncherLoader.item.windowOpacity = 0;
        hideWindow.start();
      }
    }

    target: "appLauncher"
  }
  LazyLoader {
    id: appLauncherLoader

    active: root.shouldShowAppLauncher

    PanelWindow {
      property real windowOpacity: 0

      HyprlandWindow.opacity: windowOpacity
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
      WlrLayershell.layer: WlrLayer.Overlay
      color: "transparent"
      exclusionMode: ExclusionMode.Ignore

      Behavior on HyprlandWindow.opacity {
        NumberAnimation {
          duration: Theme.animationSpeed
          easing.type: Easing.OutCubic
        }
      }

      Component.onCompleted: windowOpacity = 1

      anchors {
        bottom: true
        left: true
        right: true
        top: true
      }
      AppLauncherBackend {
        id: appLauncherBackend

      }
      Process {
        id: runApp

        command: ["sh", "-c", ""]
      }
      Rectangle {
        anchors.fill: parent
        color: Theme.background

        ColumnLayout {
          clip: true
          height: gridContainer.implicitHeight
          spacing: Theme.spacing
          width: gridContainer.implicitWidth

          TextField {
            Layout.fillWidth: true
            color: Theme.primary
            focus: true
            implicitHeight: 35
            leftPadding: 20
            rightPadding: 20

            background: Rectangle {
              anchors.fill: parent
              color: Theme.background
              radius: Theme.borderRadius

              border {
                color: Theme.primary
                width: Theme.borderWidth
              }
            }

            onTextChanged: appLauncherBackend.filterAppList(this.text)

            font {
              family: Theme.font
              pixelSize: Theme.fontSize
            }
          }
          Item {
            id: gridContainer

            clip: true
            implicitHeight: cardWidth * appList.columns + Theme.spacing * (appList.columns - 1)
            implicitWidth: cardWidth * appList.columns + Theme.spacing * (appList.columns - 1)

            Grid {
              id: appList

              anchors.fill: parent
              columns: 3
              spacing: Theme.spacing

              Repeater {
                model: appLauncherBackend.appList

                AppCard {
                  id: appCard

                  cardWidth: root.cardWidth
                  description: modelData.description
                  icon: modelData.icon
                  name: modelData.name

                  onTriggered: {
                    runApp.command[2] = modelData.exec;
                    runApp.startDetached();
                    appLauncherLoader.item.windowOpacity = 0;
                    hideWindow.start();
                  }
                }
              }
            }
          }
        }
      }
    }
  }
}
