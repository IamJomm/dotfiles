import QtQuick
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
        //appLauncherLoader.item.contentItem.focus = false; //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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
      Rectangle {
        anchors.fill: parent
        color: Theme.background

        Grid {
          columns: 3

          Repeater {
            model: appLauncherBackend.appList

            Rectangle {
              color: Theme.background
              height: content.height
              width: content.width

              MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor

                onClicked: console.log(modelData.exec)
              }
              RowLayout {
                id: content

                IconImage {
                  height: 30
                  source: Quickshell.iconPath(modelData.icon)
                  width: 30
                }
                Text {
                  color: Theme.primary
                  text: modelData.name

                  font {
                    family: Theme.font
                    pixelSize: Theme.fontSize
                  }
                }
                Text {
                  color: Theme.primary
                  text: modelData.description

                  font {
                    family: Theme.font
                    pixelSize: Theme.fontSize
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
