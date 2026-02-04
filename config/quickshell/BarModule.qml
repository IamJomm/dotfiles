import Quickshell
import QtQuick

Rectangle {
  id: module

  property alias contentText: content.text
  signal activated()

  implicitHeight: 35
  implicitWidth: content.implicitWidth + 20
  color: Theme.background
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
    anchors.fill: module
    onClicked: module.activated()
  }
}
