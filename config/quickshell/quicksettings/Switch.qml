import QtQuick
import Quickshell
import Quickshell.Widgets
import ".."

Rectangle {
  property bool active: false
  property alias iconGlyph: icon.text

  signal activated
  signal deactivated

  color: active ? Theme.secondary : Theme.background
  implicitHeight: 65
  implicitWidth: 100
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
    color: active ? Theme.background : Theme.secondary

    font {
      pixelSize: parent.implicitHeight * 0.5
      family: Theme.glyphFont
      weight: Font.Bold
    }
  }
  MouseArea {
    anchors.fill: parent
    cursorShape: hoverEnabled ? Qt.PointingHandCursor : Qt.ArrowCursor
    hoverEnabled: true

    onClicked: {
      if (active) {
        deactivated();
        active = false;
      } else {
        activated();
        active = true;
      }
    }
  }
}
