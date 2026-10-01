import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Backend
import ".."

Rectangle {
  id: root

  required property int rows
  required property int columns
  property int cardWidth: 200
  property bool singleLine: false
  required property list<QtObject> elementList
  property int current: -1
  property int page: 0

  signal triggered(exec: string)

  implicitHeight: contentLoader.item.implicitHeight + Theme.spacing * 2
  implicitWidth: contentLoader.item.implicitWidth + Theme.spacing * 2
  clip: true
  color: Theme.background
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
  Loader {
    id: contentLoader

    readonly property Component full: Component {
      GridLayout {
        id: elementListGrid

        rows: root.rows
        columns: root.columns
        rowSpacing: Theme.spacing
        columnSpacing: Theme.spacing
        flow: GridLayout.TopToBottom

        Repeater {
          id: elementCardRepeater

          readonly property int elementCount: Math.min(root.elementList.length - page * root.rows * root.columns, root.rows * root.columns)
          readonly property int actualColumns: Math.ceil(elementCount / root.rows)

          model: elementCount

          ElementCard {
            required property int index
            readonly property int actualIndex: index + page * rows * columns

            cardWidth: root.columns / elementCardRepeater.actualColumns * root.cardWidth + (root.columns - elementCardRepeater.actualColumns) * Theme.spacing / elementCardRepeater.actualColumns
            singleLine: root.singleLine
            name: root.elementList[actualIndex].name
            icon: root.elementList[actualIndex].icon
            description: root.elementList[actualIndex].description
            active: actualIndex == root.current

            onTriggered: root.triggered(root.elementList[actualIndex].exec)
          }
        }
      }
    }
    readonly property Component empty: Component {
      Item {
        implicitWidth: root.cardWidth * root.columns + Theme.spacing * (root.columns - 1)
        implicitHeight: 25

        Text {
          text: "Nothing found."
          elide: Text.ElideRight
          color: Theme.primary
          anchors.centerIn: parent

          font {
            family: Theme.font
            pixelSize: Theme.fontSize
          }
        }
      }
    }

    anchors.centerIn: parent
    sourceComponent: root.elementList.length ? full : empty
  }
}
