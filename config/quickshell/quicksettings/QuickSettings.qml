import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import ".."

PanelWindow {
  anchors {
    right: true
    top: true
    bottom: true
  }
  exclusiveZone: 0
  visible: false
  color: "transparent"
  implicitWidth: container.width + container.anchors.margins
  Rectangle {
    id: container
    anchors {
      right: parent.right
      top: parent.top
      bottom: parent.bottom
      margins: Theme.spacing
    } 
    width: switches.implicitWidth + Theme.spacing * 2
    color: Theme.background
    radius: Theme.borderRadius
    border {
      color: Theme.borderColor
      width: Theme.borderWidth
    }
    ColumnLayout {
      anchors {
        fill: parent
        margins: Theme.spacing
      }
      spacing: Theme.spacing
      SwitchesGrid { id: switches }
      NotificationList {
          Layout.fillHeight: true
          Layout.fillWidth: true
      }
      Rectangle {
        Layout.fillWidth: true
        height: 100
        color: "darkblue"
      }
    }
  }
}
