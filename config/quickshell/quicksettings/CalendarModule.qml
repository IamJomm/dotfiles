import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import ".."

Rectangle {
  id: root

  readonly property date currentDate: new Date()
  readonly property int currentDay: currentDate.getDate()
  property int currentMonth: currentDate.getMonth()
  property int currentYear: currentDate.getFullYear()
  readonly property var localelele: Qt.locale("en_US")
  readonly property var months: ["January", "February", "March", "April", "May", "June", "July",
    "August", "September", "October", "November", "December"]

  color: Theme.background
  implicitHeight: content.implicitHeight + Theme.spacing * 2
  radius: Theme.borderRadius

  border {
    color: Theme.secondary
    width: Theme.borderWidth
  }
  ColumnLayout {
    id: content

    anchors.centerIn: parent
    spacing: 0
    width: parent.width - Theme.spacing * 2

    DayOfWeekRow {
      Layout.fillWidth: true
      locale: root.localelele

      delegate: Text {
        color: Theme.primary
        horizontalAlignment: Text.AlignHCenter
        text: shortName
        verticalAlignment: Text.AlignVCenter

        font {
          family: Theme.font
          pixelSize: Theme.fontSize
        }
      }
    }
    MonthGrid {
      id: monthGrid

      Layout.fillWidth: true
      locale: root.localelele
      month: root.currentMonth
      year: root.currentYear

      delegate: Text {
        color: root.currentDate.getMonth() == root.currentMonth && root.currentDate.getFullYear()
               == root.currentYear && currentDay == model.day ? Theme.primary : Theme.secondary
        horizontalAlignment: Text.AlignHCenter
        opacity: model.month === monthGrid.month ? 1 : 0
        text: model.day
        verticalAlignment: Text.AlignVCenter

        font {
          family: Theme.font
          pixelSize: Theme.fontSize
        }
      }
    }
    RowLayout {
      Layout.fillWidth: true
      spacing: 0

      CalendarButton {
        iconGlyph: "\uf0d9"

        onTriggered: {
          if (root.currentMonth == 0) {
            root.currentYear--;
            root.currentMonth = 11;
          } else {
            root.currentMonth--;
          }
        }
      }
      Text {
        Layout.fillWidth: true
        color: Theme.primary
        horizontalAlignment: Text.AlignHCenter
        text: `${root.months[root.currentMonth]} ${root.currentYear}`

        font {
          family: Theme.font
          pixelSize: Theme.fontSize * 1.25
        }
      }
      CalendarButton {
        iconGlyph: "\uf0da"

        onTriggered: {
          if (root.currentMonth == 11) {
            root.currentYear++;
            root.currentMonth = 0;
          } else {
            root.currentMonth++;
          }
        }
      }
    }
  }
}
