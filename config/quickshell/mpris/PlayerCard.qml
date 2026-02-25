import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import ".."

Rectangle {
  id: root

  property alias cardWidth: root.implicitWidth
  signal focused()
  signal focusLost()

  implicitHeight: content.implicitHeight + Theme.spacing * 2
  color: Theme.background
  radius: Theme.borderRadius
  border {
    color: Theme.secondary
    width: Theme.borderWidth
  }
  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onEntered: focused()
    onExited: focusLost()
  }
  RowLayout {
    id: content
    anchors.centerIn: parent
    width: parent.width - Theme.spacing * 2
    spacing: Theme.spacing 
    Item {
      implicitWidth: details.implicitHeight
      implicitHeight: details.implicitHeight
      Image {
        id: art
        anchors.fill: parent
        source: Services.currentPlayer ? Services.currentPlayer.trackArtUrl : ""
        layer.enabled: true
        layer.effect: OpacityMask {
          maskSource: Rectangle {
            width: art.width
            height: art.height
            radius: Theme.borderRadius
          }
        }
      }
    }
    ColumnLayout {
      id: details
      spacing: Theme.spacing
      Layout.fillWidth: true
      ColumnLayout {
        spacing: 0
        Text {
          Layout.fillWidth: true
          elide: Text.ElideRight
          font {
            family: Theme.font
            pixelSize: Theme.fontSize
          }
          color: Theme.primary
          text: Services.currentPlayer ? Services.currentPlayer.trackArtist : "Absolutely"
        }
        Text {
          Layout.fillWidth: true
          elide: Text.ElideRight
          font {
            family: Theme.font
            pixelSize: Theme.fontSize
          }
          color: Theme.primary
          text: Services.currentPlayer ? Services.currentPlayer.trackTitle : "Nothing is playing."
        }
      }
      ColumnLayout { 
        spacing: 0
        RowLayout {
          spacing: Theme.spacing
          Layout.alignment: Qt.AlignHCenter
          PlayerButton {
            iconGlyph: "\uf0d9"
            onTriggered: Services.currentPlayer.previous()
          }
          PlayerButton {
            property bool status: true
            iconGlyph: "\uf04c"
            onTriggered: {
              if(status) {
                Services.currentPlayer.pause()
                iconGlyph = "\uf04b"
                status = false
              }
              else {
                Services.currentPlayer.play()
                iconGlyph = "\uf04c"
                status = true
              }
            }
          }
          PlayerButton {
            iconGlyph: "\uf0da"
            onTriggered: Services.currentPlayer.next()
          }
        } 
        RowLayout {
          Layout.fillWidth: true
          spacing: Theme.spacing
          Connections {
            target: Services
            function onTrackPositionChanged() {
              if (!Services.currentPlayer) return
              var min = Math.floor(Services.currentPlayer.position / 60)
              var sec = Math.floor(Services.currentPlayer.position % 60)
              trackPosition.text = `${min}:${sec < 10 ? "0" + sec : sec}`
              trackSlider.value = Services.currentPlayer.position
            }
          }
          Text {
            id: trackPosition
            font {
              family: Theme.font
              pixelSize: Theme.fontSize
            }
            color: Theme.primary
            text: "0:00"
          }
          Slider {
            id: trackSlider
            Layout.fillWidth: true
            to: Services.currentPlayer ? Services.currentPlayer.length : 0
            background: Rectangle {
              x: trackSlider.leftPadding
              y: trackSlider.topPadding + trackSlider.availableHeight / 2 - height / 2
              width: trackSlider.availableWidth
              implicitHeight: 6
              height: implicitHeight
              radius: height / 2
              color: Theme.secondary
              Rectangle {
                width: trackSlider.visualPosition * parent.width
                height: parent.height
                radius: height / 2
                color: Theme.primary
              }
            }
            handle: Item {}
            onMoved: Services.currentPlayer.seek(value - Services.currentPlayer.position)
          }
          Text {
            id: trackLength
            font {
              family: Theme.font
              pixelSize: Theme.fontSize
            }
            color: Theme.primary
            text: {
              if(!Services.currentPlayer) return "0:00"
              var min = Math.floor(Services.currentPlayer.length / 60)
              var sec = Math.floor(Services.currentPlayer.length % 60)
              return `${min}:${sec < 10 ? "0" + sec : sec}`
            }
          }
        }
      }
    }
  }
}
