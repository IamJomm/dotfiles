import Quickshell
import QtQuick
import ".."

Rectangle {
  property alias contentText: content.text
  property alias contentElide: content.elide
  property alias areaHover: area.hoverEnabled
  signal triggered()

  implicitHeight: 35
  implicitWidth: content.width + 20
  color: areaHover && area.containsMouse ? Theme.borderColor : Theme.background
  radius: Theme.borderRadius
  border {
    color: Theme.borderColor
    width: Theme.borderWidth
  }

  Text {
    id: content
    width: Math.min(implicitWidth, 400)
    anchors.centerIn: parent
    font {
      family: Theme.font
      pixelSize: Theme.fontSize
    }
    color: Theme.textColor
  }

  MouseArea {
    id: area
    anchors.fill: parent
    cursorShape: hoverEnabled ? Qt.PointingHandCursor : Qt.ArrowCursor
    onClicked: triggered()
  }
}
