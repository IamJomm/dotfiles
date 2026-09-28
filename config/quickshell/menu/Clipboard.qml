import QtQuick
import Quickshell
import Quickshell.Backend
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland
import ".."

Scope {
  id: root

  readonly property int rows: 10
  readonly property int columns: 1
  readonly property int cardWidth: 400
  property bool shouldShowClipboard: false

  function hideWindow() {
    clipboardLoader.item.windowOpacity = 0;
    hideWindowTimer.start();
  }

  Timer {
    id: hideWindowTimer

    interval: Theme.animationSpeed

    onTriggered: root.shouldShowClipboard = false
  }
  IpcHandler {
    function toggle() {
      if (hideWindowTimer.running)
        return;
      if (!root.shouldShowClipboard)
        root.shouldShowClipboard = true;
      else {
        hideWindow();
      }
    }

    target: "clipboard"
  }
  LazyLoader {
    id: clipboardLoader

    active: root.shouldShowClipboard

    Item {
      property alias windowOpacity: menu.windowOpacity

      Item {
        id: clipboardBackend

        property list<QtObject> clipList
        property list<QtObject> filteredClipList

        function filterClipList(filter) {
          filteredClipList.length = 0;
          for (let x of clipList)
            if (x.name.search(new RegExp(filter, "gi")) != -1)
              filteredClipList.push(x);
        }

        Component {
          id: clip

          QtObject {
            property string name
            property string description: ""
            property string icon: ""
            property string exec
          }
        }
        Process {
          command: ["sh", "-c", "cliphist list"]
          running: true

          stdout: StdioCollector {
            onStreamFinished: {
              let currentLine = 0;
              let tabIndex = this.text.indexOf('\t', 0);
              let nextLine = this.text.indexOf('\n', 0);
              while (nextLine != -1) {
                const component = clip.createObject(null, {
                  name: this.text.slice(tabIndex + 1, nextLine),
                  exec: this.text.slice(currentLine, tabIndex)
                });
                clipboardBackend.clipList.push(component);
                clipboardBackend.filteredClipList.push(component);
                currentLine = nextLine + 1;
                tabIndex = this.text.indexOf('\t', currentLine);
                nextLine = this.text.indexOf('\n', currentLine);
              }
            }
          }
        }
      }
      Menu {
        id: menu

        elementList: clipboardBackend.filteredClipList
        filterElementList: clipboardBackend.filterClipList
        hideWindow: root.hideWindow
        startOfCommand: "wl-copy $(cliphist decode "
        endOfCommand: ")"
        anchorLeft: true
        cardWidth: root.cardWidth
        singleLine: true
        rows: root.rows
        columns: root.columns
      }
    }
  }
}
// menu.clipList = this.text.split(/\n/g).map(m => {
//   const tabIndex = m.indexOf('\t');
//   return clip.createObject(null, {
//     name: m.substr(tabIndex + 1),
//     exec: m.substr(0, tabIndex)
//   });
// });
