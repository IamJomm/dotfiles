import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland
import ".."

PanelWindow {
  id: root

  required property list<QtObject> elementList
  required property var filterElementList
  required property var hideWindow
  property string startOfCommand: ""
  property string endOfCommand: ""
  property bool anchorLeft: false
  property int cardWidth: 200
  property bool singleLine: false
  property int rows: 10
  property int columns: 1
  property real windowOpacity: 1
  property int current: 0
  property int page: 0

  function runCommand(exec) {
    runCommandProcess.command[2] = root.startOfCommand + exec + endOfCommand;
    runCommandProcess.startDetached();
    hideWindow();
  }

  implicitWidth: content.implicitWidth + anchorLeft * Theme.spacing * 2
  exclusiveZone: 0
  WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
  HyprlandWindow.opacity: windowOpacity
  color: "transparent"

  Behavior on HyprlandWindow.opacity {
    NumberAnimation {
      duration: Theme.animationSpeed
      easing.type: Easing.OutCubic
    }
  }
  mask: Region {
    item: content
  }

  anchors {
    top: true
    bottom: true
    left: anchorLeft
  }
  Process {
    id: runCommandProcess

    command: ["sh", "-c", ""]
  }
  ColumnLayout {
    id: content

    spacing: Theme.spacing

    anchors {
      bottom: parent.bottom
      left: root.anchorLeft ? parent.left : undefined
      bottomMargin: Theme.spacing * 2
      leftMargin: root.anchorLeft * Theme.spacing * 2
    }
    Item {
      implicitWidth: elementList.width
      implicitHeight: elementList.height

      ElementList {
        id: elementList

        rows: root.rows
        columns: root.columns
        cardWidth: root.cardWidth
        singleLine: root.singleLine
        elementList: root.elementList
        current: root.current
        page: root.page

        onTriggered: exec => runCommand(exec)
        Component.onCompleted: {
          if (anchorLeft)
            x = -width - Theme.spacing * 2;
          else
            y = height + searchField.height + Theme.spacing * 3;
          elementListContainerAnimation.running = true;
        }

        NumberAnimation {
          id: elementListContainerAnimation

          target: elementList
          properties: "x,y"
          duration: Theme.animationSpeed
          easing.type: Easing.OutCubic
          running: false
          to: 0
        }
      }
    }
    Item {
      Layout.fillWidth: true
      implicitHeight: searchField.height

      SearchField {
        id: searchField

        implicitWidth: parent.width

        onTextEdited: text => {
          root.filterElementList(text);
          root.page = 0;
          root.current = 0;
        }
        onEscapePressed: hideWindow()
        onEnterPressed: runCommand(root.elementList[current].exec)
        onNPressed: {
          if (root.current < root.elementList.length - 1) {
            root.current++;
            if (root.current >= root.rows * root.columns)
              root.page = root.current / (root.rows * root.columns);
          }
        }
        onPPressed: {
          if (root.current) {
            if (!(root.current % (root.rows * root.columns)))
              page--;
            root.current--;
          }
        }
        onFPressed: {
          if (root.current < root.elementList.length - root.rows) {
            root.current += root.rows;
            if (root.current >= root.rows * root.columns)
              root.page = root.current / (root.rows * root.columns);
          } else
            root.current = root.elementList.length - 1;
        }
        onBPressed: {
          if (root.current >= root.rows) {
            if (root.current % (root.rows * root.columns) < root.rows)
              page--;
            root.current -= root.rows;
          } else
            root.current = 0;
        }
        Component.onCompleted: {
          if (anchorLeft)
            x = -width - Theme.spacing * 2;
          else
            y = height + Theme.spacing * 2;
          searchFieldAnimation.running = true;
        }

        SequentialAnimation {
          id: searchFieldAnimation

          running: false

          PauseAnimation {
            duration: Theme.animationSpeed / 2
          }
          NumberAnimation {
            target: searchField
            properties: "x,y"
            duration: Theme.animationSpeed
            easing.type: Easing.OutCubic
            to: 0
          }
        }
      }
    }
  }
}
