import Quickshell
import QtQuick

Rectangle {
  id: module

  property alias contentText: content.text
  property alias areaHover: area.hoverEnabled
  signal activated()

  implicitHeight: 35
  implicitWidth: content.implicitWidth + 20
  color: areaHover && area.containsMouse ? Theme.border : Theme.background
  radius: 5
  border {
    color: Theme.border
    width: 1
  }

  Text {
    id: content
    anchors.centerIn: module 
    font.family: Theme.font
    font.pixelSize: Theme.fontSize
    color: Theme.text
  }

  MouseArea {
    id: area
    anchors.fill: module
    hoverEnabled: false
    cursorShape: hoverEnabled ? Qt.PointingHandCursor : Qt.ArrowCursor
    onClicked: module.activated()
  }
}
