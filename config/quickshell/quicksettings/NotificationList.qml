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
    Loader {
      readonly property Component emptyList: Rectangle {
        color: "transparent"

        Text {
          anchors.centerIn: parent
          color: Theme.primary
          text: "You have no notifications."

          font {
            family: Theme.font
            pixelSize: Theme.fontSize
          }
        }
      }
      readonly property Component fullList: ScrollView {
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
            dragable: true
            iconSource: icon
            titleText: title
            width: listView.width - scrollBar.width - Theme.spacing

            onMovingChanged: if (!moving) {
              var above = listView.itemAtIndex(index - 1);
              var below = listView.itemAtIndex(index + 1);
              if (above)
                above.x = 0;
              if (below)
                below.x = 0;
            }
            onSwiped: Services.notificationList.remove(index)
            onXChanged: if (moving) {
              var above = listView.itemAtIndex(index - 1);
              var below = listView.itemAtIndex(index + 1);
              if (above)
                above.x = x / 5;
              if (below)
                below.x = x / 5;
            }
          }
          displaced: Transition {
            NumberAnimation {
              duration: Theme.animationSpeed
              easing.type: Easing.OutCubic
              properties: "y"
            }
          }
        }
      }

      Layout.fillHeight: true
      Layout.fillWidth: true
      sourceComponent: !Services.notificationList.count ? emptyList : fullList
    }
  }
}
