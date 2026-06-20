import QtQuick
import ".."

Rectangle {
  property alias iconGlyph: actionButton.text

  signal triggered

  color: "transparent"
  implicitHeight: 20
  implicitWidth: 20

  Text {
    id: actionButton

    anchors.centerIn: parent
    color: buttonArea.containsMouse ? Theme.primary : Theme.secondary

    Behavior on color {
      ColorAnimation {
        duration: Theme.animationSpeed
        easing.type: Easing.OutCubic
      }
    }

    font {
      pixelSize: parent.height
      family: Theme.glyphFont
      weight: Font.Bold
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
