import Qt5Compat.GraphicalEffects
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris
import Quickshell.Wayland
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
    radius: 100
    source: screen
  }
  Rectangle {
    anchors.fill: parent
    color: Theme.background

    ColumnLayout {
      anchors.centerIn: parent
      spacing: 20

      Text {
        color: Theme.primary
        text: Services.time

        font {
          family: Theme.font
          pixelSize: 40
        }
      }
      TextField {
        id: passwordField

        Layout.alignment: Qt.AlignHCenter
        color: Theme.primary
        echoMode: TextInput.Password
        enabled: !root.context.unlockInProgress
        focus: true
        implicitHeight: 35
        implicitWidth: 250
        inputMethodHints: Qt.ImhSensitiveData
        leftPadding: 20
        rightPadding: 20

        background: Rectangle {
          anchors.fill: parent
          color: Theme.background
          radius: Theme.borderRadius

          Behavior on border.color {
            ColorAnimation {
              duration: Theme.animationSpeed
              easing.type: Easing.OutCubic
            }
          }

          border {
            color: root.context.unlockInProgress ? Theme.secondary : Theme.primary
            width: Theme.borderWidth
          }
        }

        onAccepted: root.context.tryUnlock()
        onTextChanged: root.context.currentText = this.text

        font {
          family: Theme.font
          pixelSize: Theme.fontSize
        }
        Connections {
          function onCurrentTextChanged() {
            passwordField.text = root.context.currentText;
          }

          target: root.context
        }
      }
    }
    ColumnLayout {
      spacing: Theme.spacing

      anchors {
        bottom: parent.bottom
        bottomMargin: screen.height / 6
        horizontalCenter: parent.horizontalCenter
      }
      Text {
        id: trackTitle

        Layout.alignment: Qt.AlignHCenter
        color: Theme.primary
        text: Services.currentPlayer ? `${Services.currentPlayer.trackTitle} - 
${Services.currentPlayer.identity}` : ""

        font {
          family: Theme.font
          pixelSize: Theme.fontSize * 1.5
        }
      }
      Process {
        id: upProcess

        command: ["uptime", "-p"]
        running: true

        stdout: StdioCollector {
          onStreamFinished: uptime.text = this.text
        }
      }
      Timer {
        interval: 60000
        repeat: true
        running: true

        onTriggered: upProcess.running = true
      }
      Text {
        id: uptime

        Layout.alignment: Qt.AlignHCenter
        color: Theme.primary

        font {
          family: Theme.font
          pixelSize: Theme.fontSize
        }
      }
    }
  }

  //Test button
  Button {
    text: "unlock me"
    visible: false

    onClicked: context.unlocked()
  }
}
