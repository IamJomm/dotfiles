import QtQuick
import ".."

Rectangle {
  property alias iconGlyph: playPrevious.text
  signal triggered()

  width: 20
  height: 20
  color: "transparent"
  Text {
    id: playPrevious
    anchors.centerIn: parent
    font.pixelSize: parent.height
    color: playPreviousArea.containsMouse ? Theme.primary : Theme.secondary
  }
  MouseArea {
    id: playPreviousArea
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: triggered()
  }
}
