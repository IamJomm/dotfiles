import Quickshell
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import ".."

Rectangle {
  id: root

  property int cardSize : 350
  property MprisPlayer player
  signal focused()
  signal focusLost()

  width: content.width + Theme.spacing * 2
  height: content.height + Theme.spacing * 2
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
    width: cardSize - Theme.spacing * 2
    spacing: Theme.spacing 
    Item {
      width: details.implicitHeight
      height: details.implicitHeight
      Image {
        id: art
        anchors.fill: parent
        source: player.trackArtUrl
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
      spacing: 0
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
          text: player.trackArtist
        }
        Text {
          Layout.fillWidth: true
          elide: Text.ElideRight
          font {
            family: Theme.font
            pixelSize: Theme.fontSize
          }
          color: Theme.primary
          text: player.trackTitle
        }
      }
      RowLayout {
        spacing: Theme.spacing
        Layout.alignment: Qt.AlignHCenter
        TrackButton {
          iconGlyph: "\uf0d9"
          onTriggered: player.previous()
        }
        TrackButton {
          property bool status: true
          iconGlyph: "\uf04c"
          onTriggered: {
            if(status) {
              player.pause()
              iconGlyph = "\uf04b"
              status = false
            }
            else {
              player.play()
              iconGlyph = "\uf04c"
              status = true
            }
          }
        }
        TrackButton {
          iconGlyph: "\uf0da"
          onTriggered: player.next()
        }
      }
      RowLayout {
        Layout.fillWidth: true
        spacing: Theme.spacing
        Connections {
          target: Services
          function onTrackPositionChanged() {
            var min = Math.floor(player.position / 60)
            var sec = Math.floor(player.position % 60)
            currentTrackPosition.text = `${min}:${sec < 10 ? "0" + sec : sec}`
            trackSlider.value = player.position
          }
        }
        Text {
          id: currentTrackPosition
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
          to: player.length
          background: Rectangle {
            x: trackSlider.leftPadding
            y: trackSlider.topPadding + trackSlider.availableHeight / 2 - height / 2
            width: trackSlider.availableWidth
            implicitHeight: 6
            height: implicitHeight
            radius: this.implicitHeight / 2
            color: Theme.secondary
            Rectangle {
              width: trackSlider.visualPosition * parent.width
              height: parent.height
              radius: this.height
              color: Theme.primary
            }
          }
          handle: Item {}
          onMoved: player.seek(this.value - player.position)
        }
        Text {
          id: currentTrackLength
          font {
            family: Theme.font
            pixelSize: Theme.fontSize
          }
          color: Theme.primary
          text: {
            if(!player) return "0:00"
            var min = Math.floor(player.length / 60)
            var sec = Math.floor(player.length % 60)
            return `${min}:${sec < 10 ? "0" + sec : sec}`
          }
        }
      }
    }
  }
}
