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

  visible: apps.children.length
  implicitHeight: 35
  implicitWidth: apps.implicitWidth
  color: Theme.background
  radius: Theme.borderRadius
  border {
    color: Theme.borderColor
    width: Theme.borderWidth
  }
  RowLayout {
    id: apps
    spacing: 0
    Repeater {
      model: SystemTray.items
      Rectangle {
        id: app
        implicitHeight: trayModule.implicitHeight
        implicitWidth: trayModule.implicitHeight
        color: "transparent"
        IconImage {
          id: icon
          height: parent.implicitHeight - 15
          width: parent.implicitHeight - 15
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
            menuAnchor.anchor.rect = Qt.rect(globalCoordinares.x + app.implicitWidth, globalCoordinares.y + app.implicitHeight, 0, 0)
            menuAnchor.menu = modelData.menu
            menuAnchor.open()
          }
        }
      }
    }
  }
}
