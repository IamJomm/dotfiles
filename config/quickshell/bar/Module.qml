import QtQuick
import Quickshell
import ".."

Rectangle {
  property alias areaHover: area.hoverEnabled
  property alias contentElide: content.elide
  property alias contentText: content.text

  signal triggered

  clip: true
  color: areaHover && area.containsMouse ? Theme.secondary : Theme.background
  height: 35
  implicitWidth: content.width + 20
  radius: Theme.borderRadius

  Behavior on color {
    ColorAnimation {
      duration: Theme.animationSpeed
      easing.type: Easing.OutCubic
    }
  }
  Behavior on implicitWidth {
    NumberAnimation {
      duration: Theme.animationSpeed
      easing.type: Easing.OutCubic
    }
  }

  border {
    color: Theme.secondary
    width: Theme.borderWidth
  }
  Text {
    id: content

    anchors.centerIn: parent
    color: Theme.primary
    width: Math.min(implicitWidth, 400)

    font {
      family: Theme.font
      pixelSize: Theme.fontSize
    }
  }
  MouseArea {
    id: area

    anchors.fill: parent
    cursorShape: hoverEnabled ? Qt.PointingHandCursor : Qt.ArrowCursor

    onClicked: triggered()
  }
}
