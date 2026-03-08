import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Mpris
import Quickshell.Widgets
import ".."

Rectangle {
  id: root

  property alias cardWidth: root.implicitWidth

  signal focusLost
  signal focused

  color: Theme.background
  implicitHeight: content.implicitHeight + Theme.spacing * 2
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
    spacing: Theme.spacing
    width: parent.width - Theme.spacing * 2

    ClippingWrapperRectangle {
      color: "transparent"
      implicitHeight: visible ? details.implicitHeight : 0
      implicitWidth: visible ? details.implicitHeight / (trackCover.sourceSize.height / trackCover.sourceSize.width) : 0
      radius: Theme.borderRadius
      visible: Services.currentPlayer && Services.currentPlayer.trackArtUrl

      Image {
        id: trackCover

        anchors.fill: parent
        source: visible ? Services.currentPlayer.trackArtUrl : ""
      }
    }
    ColumnLayout {
      id: details

      Layout.fillWidth: true
      spacing: Theme.spacing

      ColumnLayout {
        spacing: 0

        Text {
          Layout.fillWidth: true
          color: Theme.primary
          elide: Text.ElideRight
          text: Services.currentPlayer ? Services.currentPlayer.trackArtist : "Absolutely"

          font {
            family: Theme.font
            pixelSize: Theme.fontSize
          }
        }
        Text {
          Layout.fillWidth: true
          color: Theme.primary
          elide: Text.ElideRight
          text: Services.currentPlayer ? Services.currentPlayer.trackTitle : "Nothing is playing."

          font {
            family: Theme.font
            pixelSize: Theme.fontSize
          }
        }
      }
      ColumnLayout {
        spacing: 0

        RowLayout {
          Layout.alignment: Qt.AlignHCenter
          spacing: Theme.spacing

          PlayerButton {
            iconGlyph: "\uf0d9"

            onTriggered: Services.currentPlayer.previous()
          }
          PlayerButton {
            property bool status: Services.currentPlayer ? Services.currentPlayer.isPlaying : false

            iconGlyph: status ? "\uf04c" : "\uf04b"

            onTriggered: {
              if (status)
                Services.currentPlayer.pause();
              else
                Services.currentPlayer.play();
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

          Component.onCompleted: {
            if (!Services.currentPlayer)
              return;
            const min = Math.floor(Services.currentPlayer.position / 60);
            const sec = Math.floor(Services.currentPlayer.position % 60);
            trackPosition.text = `${min}:${sec < 10 ? "0" + sec : sec}`;
            trackSlider.value = Services.currentPlayer.position;
          }

          Connections {
            function onTrackPositionChanged() {
              if (!Services.currentPlayer)
                return;
              const min = Math.floor(Services.currentPlayer.position / 60);
              const sec = Math.floor(Services.currentPlayer.position % 60);
              trackPosition.text = `${min}:${sec < 10 ? "0" + sec : sec}`;
              trackSlider.value = Services.currentPlayer.position;
            }

            target: Services
          }
          Text {
            id: trackPosition

            color: Theme.primary
            text: "0:00"

            font {
              family: Theme.font
              pixelSize: Theme.fontSize
            }
          }
          Slider {
            id: trackSlider

            Layout.fillWidth: true
            to: Services.currentPlayer ? Services.currentPlayer.length : 0

            background: Rectangle {
              color: Theme.secondary
              height: implicitHeight
              implicitHeight: 6
              radius: height / 2
              width: trackSlider.availableWidth
              x: trackSlider.leftPadding
              y: trackSlider.topPadding + trackSlider.availableHeight / 2 - height / 2

              Rectangle {
                color: Theme.primary
                height: parent.height
                radius: height / 2
                width: trackSlider.visualPosition * parent.width
              }
            }
            handle: Item {
            }

            onMoved: Services.currentPlayer.seek(value - Services.currentPlayer.position)
          }
          Text {
            id: trackLength

            color: Theme.primary
            text: {
              if (!Services.currentPlayer)
                return "0:00";
              const min = Math.floor(Services.currentPlayer.length / 60);
              const sec = Math.floor(Services.currentPlayer.length % 60);
              return `${min}:${sec < 10 ? "0" + sec : sec}`;
            }

            font {
              family: Theme.font
              pixelSize: Theme.fontSize
            }
          }
        }
      }
    }
  }
}
