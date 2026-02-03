import Quickshell
import QtQuick

Rectangle {
  id: module

  property alias contentText: content.text
  signal activated()

  implicitHeight: 30
  implicitWidth: content.implicitWidth + 15
  color: "blue"
  radius: 5
  border {
    color: "red"
    width: 1
  }

  Text {
    id: content
    anchors.centerIn: module 
    color: "green"
  }
  MouseArea {
    anchors.fill: module
    onClicked: module.activated()
  }
}
