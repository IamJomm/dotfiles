import Quickshell
import QtQuick
import ".."

Rectangle {
  property alias contentText: content.text
  property alias contentElide: content.elide
  property alias areaHover: area.hoverEnabled
  signal triggered()

  height: 35
  implicitWidth: content.width + 20
  Behavior on implicitWidth {
    NumberAnimation {
      duration: Theme.animationSpeed
      easing.type: Easing.OutCubic
    }
  }
  clip: true
  radius: Theme.borderRadius
  border {
    color: Theme.secondary
    width: Theme.borderWidth
  }
  color: areaHover && area.containsMouse ? Theme.secondary : Theme.background
  Text {
    id: content
    width: Math.min(implicitWidth, 400)
    anchors.centerIn: parent
    font {
      family: Theme.font
      pixelSize: Theme.fontSize
    }
    color: Theme.primary
  }
  MouseArea {
    id: area
    anchors.fill: parent
    cursorShape: hoverEnabled ? Qt.PointingHandCursor : Qt.ArrowCursor
    onClicked: triggered()
  }
}
