import Quickshell
import QtQuick
import ".."

Rectangle {
  property alias iconGlyph: icon.text
  signal triggered()

  implicitWidth: 200
  implicitHeight: 100
  color: area.containsMouse ? Theme.secondary : Theme.background
  radius: Theme.borderRadius
  border {
    color: Theme.secondary
    width: Theme.borderWidth
  }
  Text {
    id: icon
    anchors.centerIn: parent
    color: area.containsMouse ? Theme.background : Theme.secondary
    font.pixelSize: parent.implicitHeight / 2
  }
  MouseArea {
    id: area
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: triggered()
  }
}
