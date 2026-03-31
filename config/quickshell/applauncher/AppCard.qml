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

Rectangle {
  id: root

  required property string description
  required property string icon
  required property string name

  signal triggered

  color: area.containsMouse ? Theme.secondary : Theme.background
  height: content.height + Theme.spacing * 2
  radius: Theme.borderRadius
  width: 350

  Behavior on color {
    ColorAnimation {
      duration: Theme.animationSpeed
      easing.type: Easing.OutCubic
    }
  }

  border {
    color: Theme.secondary
    width: Theme.borderWidth
  }
  MouseArea {
    id: area

    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true

    onClicked: triggered()
  }
  RowLayout {
    id: content

    anchors.centerIn: parent
    width: parent.width - Theme.spacing * 2

    IconImage {
      readonly property real lineHeight: (name.contentHeight / name.lineCount - name.font.pixelSize) / 2 + name.font.pixelSize + (description.contentHeight / description.lineCount - description.font.pixelSize) / 2 + description.font.pixelSize

      Layout.topMargin: (name.contentHeight / name.lineCount - name.font.pixelSize) / 2
      height: lineHeight
      source: Quickshell.iconPath(root.icon)
      width: lineHeight
    }
    ColumnLayout {
      Layout.fillWidth: true

      Text {
        id: name

        color: Theme.primary
        text: root.name

        font {
          family: Theme.font
          pixelSize: Theme.fontSize
        }
      }
      Text {
        id: description

        Layout.fillWidth: true
        color: Theme.primary
        elide: Text.ElideRight
        text: root.description ? root.description : "No Description"

        font {
          family: Theme.font
          pixelSize: Theme.fontSize * 0.75
        }
      }
    }
  }
}
