import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import ".."

Rectangle {
  id: root

  property bool expanded: false
  property int maxCardWidth: 300
  property int minCardWidth: 100
  property alias iconSource: icon.source
  property alias titleText: title.text
  property alias bodyText: body.text
  signal focused()
  signal focusLost()

  height: content.height + Theme.spacing * 2
  width: content.width + Theme.spacing * 2
  radius: Theme.borderRadius
  border {
    color: Theme.secondary
    width: Theme.borderWidth
  }
  color: Theme.background
  MouseArea {
    anchors.fill: parent
    hoverEnabled: true
    onEntered: focused()
    onExited: focusLost()
    onClicked: {
      if(root.expanded) {
        expandIcon.text = "\uf107"
        body.wrapMode = Text.NoWrap
        body.elide = Text.ElideRight
        root.expanded = false        
      }
      else {
        expandIcon.text = "\uf106"
        body.wrapMode = Text.WordWrap
        body.elide = Text.ElideNone
        root.expanded = true
      }
    }
  }
  RowLayout {
    id: content
    anchors {
      top: parent.top
      left: parent.left
      margins: Theme.spacing
    }
    width: Math.min(Math.max(content.implicitWidth, minCardWidth - Theme.spacing * 2), maxCardWidth - Theme.spacing * 2)
    spacing: Theme.spacing
    IconImage {
      id: icon
      readonly property real lineHeight: (title.contentHeight / title.lineCount - title.font.pixelSize) / 2 + title.font.pixelSize + (body.contentHeight / body.lineCount - body.font.pixelSize) / 2 + body.font.pixelSize
      Layout.alignment: Qt.AlignTop
      Layout.topMargin: (title.contentHeight / title.lineCount - title.font.pixelSize) / 2
      height: lineHeight
      width: lineHeight
    }
    ColumnLayout {
      spacing: 0
      Layout.fillWidth: true
      Text {
        id: title
        Layout.fillWidth: true
        elide: Text.ElideRight
        font {
          family: Theme.font
          pixelSize: Theme.fontSize
        }
        color: Theme.primary
      }
      Text {
        id: body
        Layout.fillWidth: true
        elide: Text.ElideRight
        wrapMode: Text.NoWrap
        font {
          family: Theme.font
          pixelSize: Theme.fontSize
        }
        color: Theme.primary
      }
    }
    Rectangle{
      visible: body.implicitWidth >= content.width - icon.width - Theme.spacing
      Layout.alignment: Qt.AlignTop
      height: 20
      width: 20
      color: "transparent"
      Text {
        id: expandIcon
        anchors.centerIn: parent
        font.pixelSize: Theme.fontSize
        color: Theme.secondary
        text: "\uf107"
      }
    }
  }
}
