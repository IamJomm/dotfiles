import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import ".."
import "../mpris"

PanelWindow {
  property alias contentOpacity: content.opacity

  anchors {
    top: true
    bottom: true
    right: true
  }
  margins {
    top: Theme.spacing
    bottom: Theme.spacing
  }
  implicitWidth: content.implicitWidth + Theme.spacing
  exclusiveZone: 0
  color: "transparent"
  ColumnLayout {
    id: content
    anchors {
      top: parent.top
      bottom: parent.bottom
      right: parent.right
      rightMargin: Theme.spacing
    }
    spacing: Theme.spacing
    Behavior on opacity {
      NumberAnimation {
        duration: Theme.animationSpeed
        easing.type: Easing.OutCubic
      }
    }
    Item {
      implicitWidth: switchesGrid.implicitWidth
      implicitHeight: switchesGrid.implicitHeight
      SwitchesGrid {
        id: switchesGrid
        x: width + Theme.spacing
        NumberAnimation on x {
          id: switchesGridAnimation
          running: false
          to: 0; duration: Theme.animationSpeed
          easing.type: Easing.OutCubic
        }
      }
    }
    Item {
      Layout.fillWidth: true
      implicitHeight: playerCard.implicitHeight
      PlayerCard {
        id: playerCard
        cardWidth: parent.width
        x: width + Theme.spacing
        SequentialAnimation on x {
          id: playerCardAnimation
          running: false
          PauseAnimation { duration: Theme.animationSpeed / 4 }
          NumberAnimation {
            to: 0; duration: Theme.animationSpeed
            easing.type: Easing.OutCubic
          }
        }
      }
    }
    Item {
      Layout.fillWidth: true
      Layout.fillHeight: true
      NotificationList {
        width: parent.width
        height: parent.height
        x: width + Theme.spacing
        SequentialAnimation on x {
          id: notificationListAnimation
          running: false
          PauseAnimation { duration: Theme.animationSpeed / 3 }
          NumberAnimation {
            to: 0; duration: Theme.animationSpeed
            easing.type: Easing.OutCubic
          }
        }
      }
    }
    Item {
      Layout.fillWidth: true
      implicitHeight: 250
      CalendarModule {
        width: parent.width
        height: parent.height
        x: width + Theme.spacing
        SequentialAnimation on x {
          id: calendarModuleAnimation
          running: false
          PauseAnimation { duration: Theme.animationSpeed / 2 }
          NumberAnimation {
            to: 0; duration: Theme.animationSpeed
            easing.type: Easing.OutCubic
          }
        }
      }
    }
    Component.onCompleted: {
      switchesGridAnimation.running = true
      playerCardAnimation.running = true
      notificationListAnimation.running = true
      calendarModuleAnimation.running = true
    }
  }
}
