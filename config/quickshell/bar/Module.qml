import QtQuick
import QtQuick.Layouts
import Quickshell
import ".."

Rectangle {
  property alias areaHover: area.hoverEnabled
  property alias contentElide: content.elide
  property alias contentGlyph: glyph.text
  property alias contentText: content.text

  signal triggered

  clip: true
  color: areaHover && area.containsMouse ? Theme.secondary : Theme.background
  height: 35
  implicitWidth: container.width + 20
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
  RowLayout {
    id: container

    spacing: glyph.text && content.text ? Theme.spacing : 0
    anchors.centerIn: parent

    Text {
      id: glyph

      color: Theme.primary

      font {
        family: Theme.glyphFont
        pixelSize: Theme.fontSize
      }
    }
    Text {
      id: content

      color: Theme.primary

      font {
        family: Theme.font
        pixelSize: Theme.fontSize
      }
    }
  }
  MouseArea {
    id: area

    anchors.fill: parent
    cursorShape: hoverEnabled ? Qt.PointingHandCursor : Qt.ArrowCursor

    onClicked: triggered()
  }
}
