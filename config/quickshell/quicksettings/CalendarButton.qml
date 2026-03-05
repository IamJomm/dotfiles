import QtQuick
import ".."

Rectangle {
  property alias iconGlyph: actionButton.text

  signal triggered

  color: "transparent"
  implicitHeight: parent.height
  implicitWidth: this.implicitHeight

  Text {
    id: actionButton

    anchors.centerIn: parent
    color: buttonArea.containsMouse ? Theme.primary : Theme.secondary
    font.pixelSize: parent.height

    Behavior on color {
      ColorAnimation {
        duration: Theme.animationSpeed
        easing.type: Easing.OutCubic
      }
    }
  }
  MouseArea {
    id: buttonArea

    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true

    onClicked: triggered()
  }
}
