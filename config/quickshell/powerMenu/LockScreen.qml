import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
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

  LazyLoader {
    active: root.shouldShowLockScreen
    WlSessionLock {
      id: lock
      locked: true
      WlSessionLockSurface {
        ScreencopyView {
          id: screen
          anchors.fill: parent
          captureSource: Quickshell.screens[0]
        }
        FastBlur {
          anchors.fill: screen
          source: screen
          radius: 100
        }
        Rectangle {
          anchors.fill: parent
          color: Theme.background
          ColumnLayout {
            anchors.centerIn: parent
            spacing: 20
            Text {
              font {
                family: Theme.font
                pixelSize: 40
              }
              color: Theme.primary
              text: Services.time
            }
            TextField {
              id: passwordField
              Layout.alignment: Qt.AlignHCenter
              implicitWidth: 300
              implicitHeight: 35
              leftPadding: 20
              rightPadding: 20
              font {
                family: Theme.font
                pixelSize: Theme.fontSize
              }
              color: Theme.primary
              focus: true
              echoMode: TextInput.Password
              background: Rectangle{
                anchors.fill: parent
                radius: Theme.borderRadius
                border {
                  color: Theme.primary
                  width: Theme.borderWidth
                }
                color: Theme.background
              }
              onAccepted: {
                console.log(passwordField.text)
                lock.locked = false
                if(root.focusedTitle) Hyprland.dispatch(`focuswindow title:${root.focusedTitle}`)
                root.shouldShowLockScreen = false
              }
            }
          }
          ColumnLayout {
            anchors {
              horizontalCenter: parent.horizontalCenter
              bottom: parent.bottom
              bottomMargin: screen.height / 6
            }
            spacing: Theme.spacing
            Text {
              Layout.alignment: Qt.AlignHCenter
              font {
                family: Theme.font
                pixelSize: Theme.fontSize * 1.5
              }
              color: Theme.primary
              text: "aaa"
            }
            Text {
              Layout.alignment: Qt.AlignHCenter
              font {
                family: Theme.font
                pixelSize: Theme.fontSize
              }
              color: Theme.primary
              text: "aaa"
            }
          }
        }
        Button {
          visible: false
          text: "unlock me"
          onClicked: {
            lock.locked = false
            if(root.focusedTitle) Hyprland.dispatch(`focuswindow title:${root.focusedTitle}`)
            root.shouldShowLockScreen = false
          }
        }
      }
    }
  }
}
