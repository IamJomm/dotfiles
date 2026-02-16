import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../notifications"
import ".."

Rectangle {
  color: "transparent"
  Text {
    id: notificationsTitle
    font {
      family: Theme.font
      pixelSize: Theme.fontSize * 1.75
    }
    color: Theme.primary
    text: "Notifications"
  } 
  Rectangle {
    anchors {
      top: notificationsTitle.bottom
      left: parent.left
      right: parent.right
    }
    height: Theme.borderWidth
    color: Theme.secondary
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
    clip: true
    ListView {
      id: listView
      anchors {
        left: parent.left
        right: parent.right
      }
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
