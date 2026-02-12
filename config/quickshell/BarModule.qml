import Quickshell
import QtQuick

Rectangle {
  property alias contentText: content.text
  property alias contentElide: content.elide
  property alias areaHover: area.hoverEnabled
  signal triggered()

  implicitHeight: 35
  implicitWidth: content.width + 20
  color: areaHover && area.containsMouse ? Theme.border : Theme.background
  radius: 5
  border {
    color: Theme.border
    width: 1
  }

  Text {
    id: content
    width: Math.min(implicitWidth, 400)
    anchors.centerIn: parent
    font {
      family: Theme.font
      pixelSize: Theme.fontSize
    }
    color: Theme.text
  }

  MouseArea {
    id: area
    anchors.fill: parent
    cursorShape: hoverEnabled ? Qt.PointingHandCursor : Qt.ArrowCursor
    onClicked: triggered()
  }
}
