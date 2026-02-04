import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }
  height: content.implicitHeight + 10
  color: "transparent"
  RowLayout {
    id: content
    spacing: 10
    anchors {
      top: parent.top
      left: parent.left
      right: parent.right
      margins: 10
    } 
    
    

    Item { Layout.fillWidth: true }



    Item { Layout.fillWidth: true }

    BarModule {
      id: timeModule
      SystemClock {
        id: clock
        precision: SystemClock.Seconds
      }
      contentText: Qt.formatDateTime(clock.date, "\uf017  hh:mm:ss dd/MM/yyyy")
    }
  } 
}
