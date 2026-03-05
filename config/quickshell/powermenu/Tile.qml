import QtQuick
import Quickshell
import Quickshell.Io
import ".."

Rectangle {
  property alias iconGlyph: icon.text

  signal triggered

  color: area.containsMouse ? Theme.secondary : Theme.background
  implicitHeight: 100
  implicitWidth: 200
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
  Text {
    id: icon

    anchors.centerIn: parent
    color: area.containsMouse ? Theme.background : Theme.secondary
    font.pixelSize: parent.implicitHeight / 2
  }
  MouseArea {
    id: area

    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    hoverEnabled: true

    onClicked: triggered()
  }
}
