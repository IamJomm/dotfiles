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
  color: active ? Theme.borderColor : Theme.background
  radius: Theme.borderRadius
  border {
    color: Theme.borderColor
    width: Theme.borderWidth
  }
  Text {
    id: icon
    anchors.centerIn: parent
    font.pixelSize: parent.implicitHeight * 0.5
    color: active ? Theme.background : Theme.borderColor
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
