import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import ".."

Rectangle {
  id: trayModule

  QsMenuAnchor {
    id: menuAnchor
    anchor.window: QsWindow.window
    anchor.gravity: Edges.Bottom | Edges.Left
  }

  visible: apps.children.length > 1
  height: 35
  implicitWidth: apps.implicitWidth
  Behavior on implicitWidth {
    NumberAnimation {
      duration: Theme.animationSpeed
      easing.type: Easing.OutCubic
    }
  }
  clip: true
  radius: Theme.borderRadius
  border {
    color: Theme.secondary
    width: Theme.borderWidth
  }
  color: Theme.background
  RowLayout {
    id: apps
    spacing: 0
    Repeater {
      model: SystemTray.items
      Rectangle {
        id: app
        height: trayModule.height
        width: trayModule.height
        color: "transparent"
        IconImage {
          id: icon
          height: parent.height - 15
          width: parent.height - 15
          anchors.centerIn: parent
          source: modelData.icon
        } 
        Desaturate {
          anchors.fill: icon
          source: icon
          desaturation: 1
        } 
        MouseArea {
          anchors.fill: parent
          hoverEnabled: true
          cursorShape: hoverEnabled ? Qt.PointingHandCursor : Qt.ArrowCursor
          onClicked: if(modelData.hasMenu) {
            if(menuAnchor.visible) menuAnchor.close()
            var globalCoordinares = app.mapToItem(QsWindow.parent, 0, 0)
            menuAnchor.anchor.rect = Qt.rect(globalCoordinares.x + app.width, globalCoordinares.y + app.height, 0, 0)
            menuAnchor.menu = modelData.menu
            menuAnchor.open()
          }
        }
      }
    }
  }
}
