import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Widgets

Scope {
  id: root

  property bool shouldShowOsd: false

  Connections {
    function onVolumeChanged() {
      if (shouldShowOsd) {
        osdLoader.item.windowOpacity = 1;
        hideWindow.stop();
        hideAnimation.restart();
      } else
        root.shouldShowOsd = true;
    }

    target: Services
  }
  Timer {
    id: hideWindow

    interval: Theme.animationSpeed

    onTriggered: root.shouldShowOsd = false
  }
  Timer {
    id: hideAnimation

    interval: 1000 - Theme.animationSpeed

    onTriggered: {
      osdLoader.item.windowOpacity = 0;
      hideWindow.start();
    }
  }
  LazyLoader {
    id: osdLoader

    active: root.shouldShowOsd

    PanelWindow {
      property real windowOpacity: 0

      HyprlandWindow.opacity: windowOpacity
      anchors.bottom: true
      color: "transparent"
      exclusiveZone: 0
      implicitHeight: 35
      implicitWidth: 250
      margins.bottom: screen.height / 6

      Behavior on HyprlandWindow.opacity {
        NumberAnimation {
          duration: Theme.animationSpeed
          easing.type: Easing.OutCubic
        }
      }
      mask: Region {}

      Component.onCompleted: {
        windowOpacity = 1;
        hideAnimation.start();
      }

      Rectangle {
        id: osd

        anchors.fill: parent
        color: Theme.background
        radius: Theme.borderRadius

        border {
          color: Theme.secondary
          width: Theme.borderWidth
        }
        RowLayout {
          anchors {
            fill: parent
            leftMargin: Theme.spacing
            rightMargin: Theme.spacing
          }
          Text {
            color: Theme.primary
            text: `${Math.floor(Pipewire.defaultAudioSink.audio.volume * 100)}%`

            font {
              family: Theme.font
              pixelSize: Theme.fontSize
            }
          }
          Rectangle {
            Layout.fillWidth: true
            color: Theme.secondary
            implicitHeight: 10
            radius: Theme.borderRadius

            Rectangle {
              color: Theme.primary
              implicitWidth: parent.width * (Pipewire.defaultAudioSink.audio.volume ?? 0)
              radius: parent.radius

              Behavior on implicitWidth {
                NumberAnimation {
                  duration: Theme.animationSpeed
                  easing.type: Easing.OutCubic
                }
              }

              anchors {
                bottom: parent.bottom
                left: parent.left
                top: parent.top
              }
            }
          }
        }
      }
    }
  }
}
