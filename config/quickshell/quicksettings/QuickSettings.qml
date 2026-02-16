import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import ".."
import "../mpris"

PanelWindow {
  anchors {
    top: true
    bottom: true
    right: true
  }
  margins {
    top: Theme.spacing
    bottom: Theme.spacing
    right: Theme.spacing
  }
  exclusiveZone: 0
  implicitWidth: container.width + Theme.spacing
  color: "transparent"
  Rectangle {
    id: container
    anchors {
      top: parent.top
      bottom: parent.bottom
      right: parent.right
    }
    width: content.implicitWidth + Theme.spacing * 2
    radius: Theme.borderRadius
    border {
      color: Theme.secondary
      width: Theme.borderWidth
    }
    color: Theme.background
    ColumnLayout {
      id: content
      anchors.centerIn: parent
      height: parent.height - Theme.spacing * 2
      spacing: Theme.spacing
      SwitchesGrid {}
      PlayerCard { Layout.fillWidth: true }
      NotificationList {
        Layout.fillWidth: true
        Layout.fillHeight: true
      }
    }
  }
}
