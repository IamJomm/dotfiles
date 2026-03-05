import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import ".."

Rectangle {
  id: root

  property alias bodyText: body.text
  property double creationTime
  property bool expanded: false
  property alias iconSource: icon.source
  property int maxCardWidth: 300
  property int minCardWidth: 150
  property alias titleText: title.text

  signal focusLost
  signal focused

  clip: true
  color: Theme.background
  implicitHeight: content.height + Theme.spacing * 2
  implicitWidth: content.width + Theme.spacing * 2
  radius: Theme.borderRadius

  Behavior on implicitHeight {
    NumberAnimation {
      duration: Theme.animationSpeed
      easing.type: Easing.OutCubic
    }
  }

  border {
    color: Theme.secondary
    width: Theme.borderWidth
  }
  MouseArea {
    anchors.fill: parent
    hoverEnabled: true

    onClicked: {
      if (root.expanded) {
        expandIcon.text = "\uf107";
        body.wrapMode = Text.NoWrap;
        body.elide = Text.ElideRight;
        root.expanded = false;
      } else {
        expandIcon.text = "\uf106";
        body.wrapMode = Text.WordWrap;
        body.elide = Text.ElideNone;
        root.expanded = true;
      }
    }
    onEntered: focused()
    onExited: focusLost()
  }
  RowLayout {
    id: content

    spacing: Theme.spacing
    width: Math.min(Math.max(implicitWidth, minCardWidth - Theme.spacing * 2), maxCardWidth - Theme.spacing
                    * 2)

    anchors {
      left: parent.left
      margins: Theme.spacing
      top: parent.top
    }
    Item {
      id: iconContainer

      readonly property real lineHeight: (title.contentHeight / title.lineCount
                                          - title.font.pixelSize) / 2 + title.font.pixelSize + (
                                           body.contentHeight / body.lineCount
                                           - body.font.pixelSize) / 2 + body.font.pixelSize

      Layout.alignment: Qt.AlignTop
      Layout.topMargin: (title.contentHeight / title.lineCount - title.font.pixelSize) / 2
      implicitHeight: lineHeight
      implicitWidth: lineHeight

      Image {
        id: icon

        anchors.fill: parent
      }
    }
    ColumnLayout {
      Layout.fillWidth: true
      spacing: 0

      RowLayout {
        spacing: 10

        Text {
          id: title

          Layout.fillWidth: true
          color: Theme.primary
          elide: Text.ElideRight

          font {
            family: Theme.font
            pixelSize: Theme.fontSize
          }
        }
        Timer {
          interval: 1000
          repeat: true
          running: true
          triggeredOnStart: true

          onTriggered: {
            const seconds = (Date.now() - root.creationTime) / 1000;
            time.text = seconds < 60 ? `${Math.floor(seconds)}sec` : `${Math.floor(seconds / 60)
                                       }min`;
          }
        }
        Text {
          id: time

          color: Theme.primary

          font {
            family: Theme.font
            pixelSize: Theme.fontSize
          }
        }
      }
      Text {
        id: body

        Layout.fillWidth: true
        color: Theme.primary
        elide: Text.ElideRight
        wrapMode: Text.NoWrap

        font {
          family: Theme.font
          pixelSize: Theme.fontSize
        }
      }
    }
    Rectangle {
      Layout.alignment: Qt.AlignTop
      color: "transparent"
      implicitHeight: 20
      implicitWidth: 20
      visible: body.implicitWidth >= content.width - iconContainer.implicitWidth - Theme.spacing

      Text {
        id: expandIcon

        anchors.centerIn: parent
        color: Theme.secondary
        font.pixelSize: Theme.fontSize
        text: "\uf107"
      }
    }
  }
}
