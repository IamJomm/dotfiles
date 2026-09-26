import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "../mpris"
import ".."

PanelWindow {
  property real windowOpacity: 1

  HyprlandWindow.opacity: windowOpacity
  color: "transparent"
  exclusiveZone: 0
  implicitWidth: content.implicitWidth + Theme.spacing

  Behavior on HyprlandWindow.opacity {
    NumberAnimation {
      duration: Theme.animationSpeed
      easing.type: Easing.OutCubic
    }
  }

  anchors {
    bottom: true
    right: true
    top: true
  }
  margins {
    bottom: Theme.spacing
    top: Theme.spacing
  }
  ColumnLayout {
    id: content

    spacing: Theme.spacing

    anchors {
      bottom: parent.bottom
      right: parent.right
      rightMargin: Theme.spacing
      top: parent.top
    }
    Item {
      implicitHeight: switchesGrid.implicitHeight
      implicitWidth: switchesGrid.implicitWidth

      SwitchesGrid {
        id: switchesGrid

        NumberAnimation on x {
          id: switchesGridAnimation

          duration: Theme.animationSpeed
          easing.type: Easing.OutCubic
          running: false
          to: 0
        }

        Component.onCompleted: {
          x = width + Theme.spacing;
          switchesGridAnimation.running = true;
        }
      }
    }
    Item {
      Layout.fillWidth: true
      implicitHeight: playerCard.implicitHeight

      PlayerCard {
        id: playerCard

        cardWidth: parent.width

        SequentialAnimation on x {
          id: playerCardAnimation

          running: false

          PauseAnimation {
            duration: Theme.animationSpeed / 4
          }
          NumberAnimation {
            duration: Theme.animationSpeed
            easing.type: Easing.OutCubic
            to: 0
          }
        }

        Component.onCompleted: {
          x = width + Theme.spacing;
          playerCardAnimation.running = true;
        }
      }
    }
    Item {
      Layout.fillHeight: true
      Layout.fillWidth: true

      NotificationList {
        id: notificationList

        height: parent.height
        width: parent.width

        SequentialAnimation on x {
          id: notificationListAnimation

          running: false

          PauseAnimation {
            duration: Theme.animationSpeed / 3
          }
          NumberAnimation {
            duration: Theme.animationSpeed
            easing.type: Easing.OutCubic
            to: 0
          }
        }

        Component.onCompleted: {
          x = width + Theme.spacing;
          notificationListAnimation.running = true;
        }
      }
    }
    Item {
      Layout.fillWidth: true
      implicitHeight: calendarModule.implicitHeight

      CalendarModule {
        id: calendarModule

        width: parent.width

        SequentialAnimation on x {
          id: calendarModuleAnimation

          running: false

          PauseAnimation {
            duration: Theme.animationSpeed / 2
          }
          NumberAnimation {
            duration: Theme.animationSpeed
            easing.type: Easing.OutCubic
            to: 0
          }
        }

        Component.onCompleted: {
          x = width + Theme.spacing;
          calendarModuleAnimation.running = true;
        }
      }
    }
  }
}
