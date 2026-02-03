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
      Process {
        id: timeProc
        command: ["date"]
        running: true
        stdout: StdioCollector {
          onStreamFinished: timeModule.contentText = this.text.trim()
        }
      }
      Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: timeProc.running = true
      }
    }
  } 
}
