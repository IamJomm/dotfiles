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
  required property list<QtObject> appList
  property int current: -1

  signal triggered(exec: string)

  implicitHeight: appListGrid.implicitHeight + Theme.spacing * 2
  implicitWidth: appListGrid.implicitWidth + Theme.spacing * 2
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
  GridLayout {
    id: appListGrid

    rows: root.rows
    columns: root.columns
    rowSpacing: Theme.spacing
    columnSpacing: Theme.spacing
    flow: GridLayout.TopToBottom
    anchors.centerIn: parent

    Repeater {
      id: appCardRepeater

      readonly property int appCount: appList.length < root.rows * root.columns ? appList.length : root.rows * root.columns

      model: appCount

      AppCard {
        required property int index
        readonly property int actualColumns: Math.ceil(appCardRepeater.appCount / root.rows)

        cardWidth: root.columns / actualColumns * root.cardWidth + (root.columns - actualColumns) * Theme.spacing / actualColumns
        name: appList[index].name
        icon: appList[index].icon
        description: appList[index].description
        active: index == root.current

        onTriggered: root.triggered(appList[index].exec)
      }
    }
  }
}
