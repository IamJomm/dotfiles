import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import "../notifications"
import ".."

Rectangle {
  color: Theme.background
  radius: Theme.borderRadius

  border {
    color: Theme.secondary
    width: Theme.borderWidth
  }
  ColumnLayout {
    anchors.centerIn: parent
    height: parent.height - Theme.spacing * 2
    spacing: Theme.spacing
    width: parent.width - Theme.spacing * 2

    ColumnLayout {
      Layout.fillWidth: true
      spacing: 0

      Text {
        color: Theme.primary
        text: "Notifications"

        font {
          family: Theme.font
          pixelSize: Theme.fontSize * 1.75
        }
      }
      Rectangle {
        Layout.fillWidth: true
        color: Theme.secondary
        height: Theme.borderWidth
      }
    }
    ScrollView {
      Layout.fillHeight: true
      Layout.fillWidth: true
      ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
      clip: true

      ScrollBar.vertical: ScrollBar {
        padding: 0
        policy: ScrollBar.AlwaysOn

        contentItem: Rectangle {
          id: scrollBar

          color: Theme.primary
          implicitWidth: 5
          radius: implicitWidth / 2
        }

        anchors {
          bottom: parent.bottom
          right: parent.right
          top: parent.top
        }
      }

      ListView {
        id: listView

        Layout.fillWidth: true
        model: Services.notificationList
        spacing: Theme.spacing

        delegate: NotificationCard {
          bodyText: body
          creationTime: time
          iconSource: icon
          maxCardWidth: listView.width - scrollBar.width - Theme.spacing
          minCardWidth: listView.width - scrollBar.width - Theme.spacing
          titleText: title
        }
      }
    }
  }
}
