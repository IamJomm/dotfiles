import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import ".."

Rectangle {
  id: root

  property alias cardWidth: root.implicitWidth
  property bool singleLine: false
  required property string name
  property string description
  property string icon
  property bool active: false

  signal triggered

  implicitHeight: content.height + Theme.spacing * 2
  color: area.containsMouse || active ? Theme.secondary : Theme.background
  radius: Theme.borderRadius

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
      readonly property real lineHeight: (elementName.contentHeight / elementName.lineCount - elementName.font.pixelSize) / 2 + elementName.font.pixelSize + (elementDescription.contentHeight / elementDescription.lineCount - elementDescription.font.pixelSize) / 2 + elementDescription.font.pixelSize

      visible: !root.singleLine
      Layout.topMargin: (elementName.contentHeight / elementName.lineCount - elementName.font.pixelSize) / 2
      height: lineHeight
      source: Quickshell.iconPath(root.icon)
      width: lineHeight
    }
    ColumnLayout {
      Layout.fillWidth: true

      Text {
        id: elementName

        text: root.name
        Layout.fillWidth: true
        elide: Text.ElideRight
        color: Theme.primary

        font {
          family: Theme.font
          pixelSize: Theme.fontSize
        }
      }
      Text {
        id: elementDescription

        visible: !root.singleLine
        text: root.description ? root.description : "No Description"
        Layout.fillWidth: true
        elide: Text.ElideRight
        color: Theme.primary

        font {
          family: Theme.font
          pixelSize: Theme.fontSize * 0.75
        }
      }
    }
  }
}
