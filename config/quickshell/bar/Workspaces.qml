import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import ".."

Rectangle {
  id: workspacesModule
  height: 35
  implicitWidth: workspaces.implicitWidth
  color: Theme.background
  radius: Theme.borderRadius
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
        height: workspacesModule.height
        width: workspacesModule.height
        color: "transparent"
        Text {
          anchors.centerIn: parent
          text: modelData.id
          font {
            family: Theme.font
            pixelSize: Theme.fontSize
          }
          color: modelData.active ? Theme.primary : Theme.secondary
        }
        MouseArea {
          anchors.fill: parent
          hoverEnabled: true
          cursorShape: hoverEnabled ? Qt.PointingHandCursor : Qt.ArrowCursor
          onClicked: modelData.activate()
        }
      }
    }
  }
}
