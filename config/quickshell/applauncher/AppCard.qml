import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import ".."

Rectangle {
  id: root

  property alias cardWidth: root.implicitWidth
  property string description
  property string icon
  property string name
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
      readonly property real lineHeight: (appName.contentHeight / appName.lineCount - appName.font.pixelSize) / 2 + appName.font.pixelSize + (appDescription.contentHeight / appDescription.lineCount - appDescription.font.pixelSize) / 2 + appDescription.font.pixelSize

      Layout.topMargin: (appName.contentHeight / appName.lineCount - appName.font.pixelSize) / 2
      height: lineHeight
      source: Quickshell.iconPath(root.icon)
      width: lineHeight
    }
    ColumnLayout {
      Layout.fillWidth: true

      Text {
        id: appName

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
        id: appDescription

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
