import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import ".."

Rectangle {
  id: workspacesModule

  clip: true
  color: Theme.background
  height: 35
  implicitWidth: workspaces.implicitWidth
  radius: Theme.borderRadius

  Behavior on implicitWidth {
    NumberAnimation {
      duration: Theme.animationSpeed
      easing.type: Easing.OutCubic
    }
  }

  border {
    color: Theme.secondary
    width: Theme.borderWidth
  }
  RowLayout {
    id: workspaces

    spacing: 0

    Repeater {
      model: Hyprland.workspaces

      Rectangle {
        color: "transparent"
        height: workspacesModule.height
        width: workspacesModule.height

        Text {
          anchors.centerIn: parent
          color: modelData.active ? Theme.primary : Theme.secondary
          text: modelData.id

          font {
            family: Theme.font
            pixelSize: Theme.fontSize
          }
        }
        MouseArea {
          anchors.fill: parent
          cursorShape: hoverEnabled ? Qt.PointingHandCursor : Qt.ArrowCursor
          hoverEnabled: true

          onClicked: modelData.activate()
        }
      }
    }
  }
}
