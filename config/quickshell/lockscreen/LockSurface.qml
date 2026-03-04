import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import ".."

Item {
  id: root

  required property LockContext context

  anchors.fill: parent
  ScreencopyView {
    id: screen
    anchors.fill: parent
    captureSource: Quickshell.screens[0]
  }
  FastBlur {
    anchors.fill: screen
    source: screen
    radius: 100
  }
  Rectangle {
    anchors.fill: parent
    color: Theme.background
    ColumnLayout {
      anchors.centerIn: parent
      spacing: 20
      Text {
        font {
          family: Theme.font
          pixelSize: 40
        }
        color: Theme.primary
        text: Services.time
      }
      TextField {
        id: passwordField
        Layout.alignment: Qt.AlignHCenter
        implicitWidth: 250
        implicitHeight: 35
        leftPadding: 20
        rightPadding: 20
        font {
          family: Theme.font
          pixelSize: Theme.fontSize
        }
        color: Theme.primary
        background: Rectangle{
          anchors.fill: parent
          radius: Theme.borderRadius
          border {
            color: root.context.unlockInProgress ? Theme.secondary : Theme.primary
            width: Theme.borderWidth
          }
          Behavior on border.color {
            ColorAnimation {
              duration: Theme.animationSpeed
              easing.type: Easing.OutCubic
            }
          }
          color: Theme.background
        }
        focus: true
				enabled: !root.context.unlockInProgress
				echoMode: TextInput.Password
				inputMethodHints: Qt.ImhSensitiveData
				onTextChanged: root.context.currentText = this.text;
				onAccepted: root.context.tryUnlock();
				Connections {
					target: root.context
					function onCurrentTextChanged() {
						passwordField.text = root.context.currentText;
					}
				}
      }
    }
    ColumnLayout {
      anchors {
        horizontalCenter: parent.horizontalCenter
        bottom: parent.bottom
        bottomMargin: screen.height / 6
      }
      spacing: Theme.spacing
      Text {
        id: trackTitle
        Layout.alignment: Qt.AlignHCenter
        font {
          family: Theme.font
          pixelSize: Theme.fontSize * 1.5
        }
        color: Theme.primary
        text: Services.currentPlayer ? `${Services.currentPlayer.trackTitle} - ${Services.currentPlayer.identity}` : "" 
      }
      Process {
        id: upProcess
        running: true
        command: ["uptime", "-p"]
        stdout: StdioCollector {
          onStreamFinished: uptime.text = this.text
        }
      }
      Timer {
        running: true
        interval: 60000
        repeat: true
        onTriggered: upProcess.running = true
      }
      Text {
        id: uptime
        Layout.alignment: Qt.AlignHCenter
        font {
          family: Theme.font
          pixelSize: Theme.fontSize
        }
        color: Theme.primary
      }
    }
  }
  //Test button
  Button {
    visible: false
    text: "unlock me"
    onClicked: context.unlocked()
  }
}
