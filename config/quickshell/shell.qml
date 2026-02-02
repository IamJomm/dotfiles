import Quickshell
import QtQuick
import QtQuick.Layouts

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }
  height: content.implicitHeight + 10
  color: "transparent"
  RowLayout {
    id: content
    spacing: 0
    anchors {
      top: parent.top
      left: parent.left
      right: parent.right
      margins: 10
    }
    Rectangle {
      Layout.fillWidth: true
      implicitHeight: 30
      color: "blue"
    }
    Rectangle {
      Layout.fillWidth: true
      implicitHeight: 30
      color: "red"
    }
    Rectangle {
      Layout.fillWidth: true
      implicitHeight: 30
      color: "green"
    }
  } 
}
