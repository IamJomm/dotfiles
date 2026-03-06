import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import ".."

Rectangle {
  id: trayModule

  clip: true
  color: Theme.background
  height: 35
  implicitWidth: apps.implicitWidth
  radius: Theme.borderRadius
  visible: apps.children.length > 1

  Behavior on implicitWidth {
    NumberAnimation {
      duration: Theme.animationSpeed
      easing.type: Easing.OutCubic
    }
  }

  QsMenuAnchor {
    id: menuAnchor

    anchor.gravity: Edges.Bottom | Edges.Left
    anchor.window: QsWindow.window
  }
  border {
    color: Theme.secondary
    width: Theme.borderWidth
  }
  RowLayout {
    id: apps

    spacing: 0

    Repeater {
      model: SystemTray.items

      Rectangle {
        id: app

        color: "transparent"
        height: trayModule.height
        width: trayModule.height

        IconImage {
          id: icon

          anchors.centerIn: parent
          height: parent.height - 15
          source: modelData.icon
          width: parent.height - 15
        }
        Desaturate {
          anchors.fill: icon
          desaturation: 1
          source: icon
        }
        MouseArea {
          anchors.fill: parent
          cursorShape: hoverEnabled ? Qt.PointingHandCursor : Qt.ArrowCursor
          hoverEnabled: true

          onClicked: if (modelData.hasMenu) {
            if (menuAnchor.visible)
              menuAnchor.close();
            var globalCoordinares = app.mapToItem(QsWindow.parent, 0, 0);
            menuAnchor.anchor.rect = Qt.rect(globalCoordinares.x + app.width, globalCoordinares.y + app.height, 0, 0);
            menuAnchor.menu = modelData.menu;
            menuAnchor.open();
          }
        }
      }
    }
  }
}
