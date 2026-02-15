import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import ".."

Scope {
  id: root

  property bool shouldShowMenu: false
  property list<TileProperties> tiles: [
    TileProperties {
      iconGlyph: "\uf023"
      keybind: Qt.Key_L
      command: "qs ipc call lockScreen lock"
    },
    TileProperties {
      iconGlyph: "\uf08b"
      keybind: Qt.Key_O
      command: "hyprctl dispatch exit"
    },
    TileProperties {
      iconGlyph: "\uf04c"
      keybind: Qt.Key_S
      command: "systemctl suspend"
    },
    TileProperties {
      iconGlyph: "\uf0b1"
      keybind: Qt.Key_H
      command: "systemctl hibernate"
    },
    TileProperties {
      iconGlyph: "\uf01e"
      keybind: Qt.Key_R
      command: "systemctl reboot"
    },
    TileProperties {
      iconGlyph: "\uf011"
      keybind: Qt.Key_U
      command: "systemctl poweroff"
    }
  ]

  IpcHandler {
    target: "powerMenu"
    function toggle() {
      root.shouldShowMenu = !root.shouldShowMenu
    }
  }

  LazyLoader {
    active: root.shouldShowMenu
    PanelWindow {
      anchors {
        top: true
        left: true
      }
      margins {
        top: (screen.height - content.height) / 2
        left: (screen.width - content.width) / 2
      }
      implicitWidth: content.width
      implicitHeight: content.height
      exclusionMode: ExclusionMode.Ignore
      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
      color: "transparent"
      contentItem {
		  	focus: true
		  	Keys.onPressed: event => {
          if (event.key == Qt.Key_Escape) root.shouldShowMenu = false
          else for(let i = 0; i < tiles.length; i++) {
            let tile = tiles[i]
            if(event.key == tile.keybind) {
              console.log("hello")
              tile.proc.startDetached()
              root.shouldShowMenu = false
            }
          }
		  	}
		  }
      Rectangle {
        id: content
        width: tilesGrid.implicitWidth + Theme.spacing * 2
        height: tilesGrid.implicitHeight + Theme.spacing * 2
        radius: Theme.borderRadius
        border {
          color: Theme.secondary
          width: Theme.borderWidth
        }
        color: Theme.background
        Grid {
          id: tilesGrid
          anchors.centerIn: parent
          columns: 3
          spacing: Theme.spacing
          Repeater {
            model: tiles
            Tile {
              iconGlyph: modelData.iconGlyph
              onTriggered: {
                modelData.proc.startDetached()
                root.shouldShowMenu = false
              }
            }
          }
        }
      }
    }
  }
}
