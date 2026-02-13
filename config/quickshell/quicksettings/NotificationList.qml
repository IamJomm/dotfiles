import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../notifications"
import ".."

Rectangle {
  ListModel{ id: notificationList }
  Connections {
    target: Services
    function onNewNotification(iconSource, titleText, bodyText) {
      notificationList.insert(0, {"icon": iconSource, "title": titleText, "body": bodyText})
    }
  }

  Layout.fillHeight: true
  Layout.fillWidth: true
  color: "transparent"
  Text {
    id: notificationsTitle
    font {
      family: Theme.font
      pixelSize: 20
    }
    color: Theme.textColor
    text: "Notifications"
  } 
  Rectangle {
    anchors {
      top: notificationsTitle.bottom
      left: parent.left
      right: parent.right
    }
    height: Theme.borderWidth
    color: Theme.borderColor
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
    ListView {
      anchors {
        left: parent.left
        right: parent.right
      }
      spacing: Theme.spacing
      model: notificationList
      delegate: NotificationCard {
        maxCardWidth: parent.width
        minCardWidth: parent.width
        iconSource: icon
        titleText: title
        bodyText: body
      }
    }
  } 
      }
