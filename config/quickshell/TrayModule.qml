import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Rectangle {
  id: trayModule
  visible: apps.children.length
  implicitHeight: 35
  implicitWidth: apps.implicitWidth
  color: Theme.background
  radius: 5
  border {
    color: Theme.border
    width: 1
  }
  RowLayout {
    id: apps
    spacing: 0
    Repeater {
      model: SystemTray.items
      Rectangle {
        implicitHeight: trayModule.implicitHeight
        implicitWidth: trayModule.implicitHeight
        color: "transparent"
        Image {
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
          onClicked: function(mouse) {
            if(modelData.hasMenu){
              modelData.display(trayModule, mouse.x, mouse.y)
            }
          }
        }
      }
    }
  }
}
