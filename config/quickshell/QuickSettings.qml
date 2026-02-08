import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

PanelWindow {
  anchors {
    right: true
    top: true
    bottom: true
  }
  exclusiveZone: 0
  visible: false
  color: "transparent"
  implicitWidth: container.implicitWidth + container.anchors.margins

  Rectangle {
    id: container
    anchors {
      right: parent.right
      top: parent.top
      bottom: parent.bottom
      margins: 10
    } 
    implicitWidth: switches.implicitWidth + 20
    color: Theme.background
    radius: 5
    border {
      color: Theme.border
      width: 1
    }
    ColumnLayout {
      anchors {
        fill: parent
        margins: 10
      }
      spacing: 10
      //Switches
      Grid {
        id: switches
        columns: 3
        spacing: 10 
        QuickSettingsSwitch {
          iconGlyph: "\uf1f6"
          onActivated: console.log("ac")
          onDeactivated: console.log("deac")
        }
        QuickSettingsSwitch {
          iconGlyph: "\uf1eb"
          onActivated: console.log("ac")
          onDeactivated: console.log("deac")
        }
        QuickSettingsSwitch {
          iconGlyph: "\uf294"
          onActivated: console.log("ac")
          onDeactivated: console.log("deac")
        }
        QuickSettingsSwitch {
          iconGlyph: "\uf185"
          onActivated: console.log("ac")
          onDeactivated: console.log("deac")
        }
        QuickSettingsSwitch {
          iconGlyph: "\uf186"
          onActivated: console.log("ac")
          onDeactivated: console.log("deac")
        }
        QuickSettingsSwitch {
          iconGlyph: "\uf017"
          onActivated: console.log("ac")
          onDeactivated: console.log("deac")
        }
      }
      //Notifications
      Rectangle {
        Layout.fillHeight: true
        implicitWidth: parent.implicitWidth
        color: "transparent"
        Text {
          id: notificationsTitle
          font {
            family: Theme.font
            pixelSize: 20
          }
          color: Theme.text
          text: "Notifications"
        }
        Rectangle {
          anchors {
            top: notificationsTitle.bottom
            left: parent.left
            right: parent.right
          }
          height: 1
          color: Theme.border 
        }
        ScrollView {
          anchors {
            top: notificationsTitle.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            topMargin: 10
          }
          ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
          ScrollBar.vertical.policy: ScrollBar.AlwaysOn
        }
      }
      Rectangle {
        anchors {
          left: parent.left
          right: parent.right
        }
        height: 100
        color: "darkblue"
      }
    }
  }
}
