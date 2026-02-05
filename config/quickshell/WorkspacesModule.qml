import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts

Rectangle {
  id: workspacesModule
  implicitHeight: 35
  implicitWidth: workspaces.implicitWidth
  color: Theme.background
  radius: 5
  border {
    color: Theme.border
    width: 1
  }
  RowLayout {
    id: workspaces
    spacing: 0
    Repeater {
      model: Hyprland.workspaces
      Rectangle {
        implicitHeight: workspacesModule.implicitHeight
        implicitWidth: workspacesModule.implicitHeight
        color: "transparent"
        Text {
          anchors.centerIn: parent
          text: modelData.id
          font.family: Theme.font
          font.pixelSize: Theme.fontSize
          color: modelData.active ? Theme.text : Theme.border
        }
        MouseArea {
          anchors.fill: parent
          hoverEnabled: true
          cursorShape: hoverEnabled ? Qt.PointingHandCursor : Qt.ArrowCursor
          onClicked: {
            modelData.activate()
          }
        }
      }
    }
  }
}
