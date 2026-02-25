import Quickshell
import Quickshell.Widgets
import QtQuick
import ".."

Rectangle {
  property alias iconGlyph: icon.text
  property bool active: false
  signal activated
  signal deactivated 

  implicitWidth: 100
  implicitHeight: 65
  radius: Theme.borderRadius
  border {
    color: Theme.secondary
    width: Theme.borderWidth
  }
  color: active ? Theme.secondary : Theme.background
  Behavior on color {
    ColorAnimation {
      duration: Theme.animationSpeed
      easing.type: Easing.OutCubic
    }
  }
  Text {
    id: icon
    anchors.centerIn: parent
    font.pixelSize: parent.implicitHeight * 0.5
    color: active ? Theme.background : Theme.secondary
  } 
  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    cursorShape: hoverEnabled ? Qt.PointingHandCursor : Qt.ArrowCursor
    onClicked: {
      if(active){
        deactivated()
        active = false
      }
      else {
        activated()
        active = true
      }
    }
  }
}
