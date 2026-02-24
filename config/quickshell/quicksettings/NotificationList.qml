import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../notifications"
import ".."

Rectangle {
  radius: Theme.borderRadius
  border {
    color: Theme.secondary
    width: Theme.borderWidth
  }
  color: Theme.background
  ColumnLayout {
    anchors.centerIn: parent
    width: parent.width - Theme.spacing * 2
    height: parent.height - Theme.spacing * 2
    spacing: Theme.spacing
    ColumnLayout {
      Layout.fillWidth: true
      spacing: 0
      Text {
        font {
          family: Theme.font
          pixelSize: Theme.fontSize * 1.75
        }
        color: Theme.primary
        text: "Notifications"
      } 
      Rectangle {
        Layout.fillWidth: true
        height: Theme.borderWidth
        color: Theme.secondary
      } 
    }
    ScrollView {
      Layout.fillWidth: true
      Layout.fillHeight: true
      clip: true
      ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
      ScrollBar.vertical: ScrollBar {
        policy: ScrollBar.AlwaysOn
        anchors {
          top: parent.top
          bottom: parent.bottom
          right: parent.right
        }
        padding: 0
        contentItem: Rectangle {
          id: scrollBar
          implicitWidth: 5
          radius: this.implicitWidth / 2
          color: Theme.primary
        }
      }
      ListView {
        id: listView
        Layout.fillWidth: true
        spacing: Theme.spacing
        model: Services.notificationList
        delegate: NotificationCard {
          maxCardWidth: listView.width - scrollBar.width - Theme.spacing
          minCardWidth: listView.width - scrollBar.width - Theme.spacing
          iconSource: icon
          titleText: title
          bodyText: body
        }
      }
    } 
  }
}
