import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

Rectangle {
  property Notification notification

  implicitHeight: content.implicitHeight + 10
  implicitWidth: content.implicitWidth + 15
  radius: 5
  border {
    color: Theme.border
    width: 1
  }
  color: Theme.background
  RowLayout {
    id: content
    anchors.centerIn: parent
    spacing: 5
    IconImage {
      id: icon

      property real lineHeight: (title.contentHeight / title.lineCount - title.font.pixelSize) / 2 + title.font.pixelSize + (body.contentHeight / body.lineCount - body.font.pixelSize) / 2 + body.font.pixelSize
      
      anchors {
        top: parent.top
        topMargin: (title.contentHeight / title.lineCount - title.font.pixelSize) / 2
      }
      source: notification.image
      implicitHeight: lineHeight
      implicitWidth: lineHeight
    }
    ColumnLayout {
      spacing: 0
      Text {
        id: title
        Layout.maximumWidth: 300
        elide: Text.ElideRight
        font {
          family: Theme.font
          pixelSize: Theme.fontSize
        }
        color: Theme.text
        text: `${notification.appName} ${notification.summary}`
      }
      Text {
        id: body
        Layout.maximumWidth: 300
        wrapMode: Text.WordWrap
        font {
          family: Theme.font
          pixelSize: Theme.fontSize
        }
        color: Theme.border
        text: notification.body
      }
    }
  }
}
