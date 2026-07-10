import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Widgets
import ".."

Rectangle {
  id: root

  property alias bodyText: body.text
  property double creationTime
  property bool dragable: false
  property bool expanded: false
  property string iconSource
  property alias moving: mouseArea.drag.active
  property alias titleText: title.text

  signal focusLost
  signal focused
  signal swiped

  clip: true
  color: Theme.background
  implicitHeight: content.implicitHeight + Theme.spacing * 2
  implicitWidth: content.implicitWidth + Theme.spacing * 2
  radius: Theme.borderRadius

  Behavior on implicitHeight {
    NumberAnimation {
      duration: Theme.animationSpeed
      easing.type: Easing.OutCubic
    }
  }
  Behavior on x {
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
    id: mouseArea

    anchors.fill: parent
    hoverEnabled: true

    onClicked: root.expanded = !root.expanded
    onEntered: focused()
    onExited: focusLost()
    onReleased: {
      if (root.x < root.width / 2)
        root.x = 0;
      else {
        root.x = root.width + Theme.spacing;
        waitSwipeAnimation.start();
      }
    }

    Timer {
      id: waitSwipeAnimation

      interval: Theme.animationSpeed

      onTriggered: swiped()
    }
    drag {
      axis: Drag.XAxis
      maximumX: root.width
      minimumX: 0
      target: root.dragable ? root : null
    }
  }
  RowLayout {
    id: content

    spacing: Theme.spacing
    width: root.width - Theme.spacing * 2

    anchors {
      left: parent.left
      margins: Theme.spacing
      top: parent.top
    }
    ClippingWrapperRectangle {
      id: iconContainer

      readonly property real lineHeight: (title.contentHeight / title.lineCount - title.font.pixelSize) / 2 + title.font.pixelSize + (body.contentHeight / body.lineCount - body.font.pixelSize) / 2 + body.font.pixelSize

      Layout.alignment: Qt.AlignTop
      Layout.topMargin: (title.contentHeight / title.lineCount - title.font.pixelSize) / 2
      color: "transparent"
      implicitHeight: lineHeight
      implicitWidth: lineHeight
      radius: Theme.borderRadius

      Image {
        anchors.fill: parent
        source: root.iconSource ? root.iconSource : "../assets/message.png"
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

            if (seconds >= 3600) {
              time.text = `${Math.floor(seconds / 3600)} hr`;
              return;
            }
            if (seconds >= 60) {
              time.text = `${Math.floor(seconds / 60)} min`;
              return;
            }
            time.text = `${Math.floor(seconds)} sec`;
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
        elide: root.expanded ? Text.ElideNone : Text.ElideRight
        wrapMode: root.expanded ? Text.WordWrap : Text.NoWrap

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
        text: root.expanded ? "\uf106" : "\uf107"

        font {
          pixelSize: Theme.fontSize
          family: Theme.glyphFont
          weight: Font.Bold
        }
      }
    }
  }
}
