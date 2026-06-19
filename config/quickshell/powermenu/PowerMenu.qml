import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Wayland
import ".."

Scope {
  id: root

  property bool shouldShowMenu: false
  property list<TileProperties> tiles: [
    TileProperties {
      command: "qs ipc call lockScreen lock"
      iconGlyph: "\uf023"
      keybind: Qt.Key_L
    },
    TileProperties {
      command: "hyprctl dispatch 'hl.dsp.exit()'"
      iconGlyph: "\uf08b"
      keybind: Qt.Key_O
    },
    TileProperties {
      command: "systemctl suspend"
      iconGlyph: "\uf04c"
      keybind: Qt.Key_S
    },
    TileProperties {
      command: "systemctl hibernate"
      iconGlyph: "\uf0b1"
      keybind: Qt.Key_H
    },
    TileProperties {
      command: "hyprctl dispatch 'hl.dsp.exit()' && systemctl reboot"
      iconGlyph: "\uf01e"
      keybind: Qt.Key_R
    },
    TileProperties {
      command: "hyprctl dispatch 'hl.dsp.exit()' && systemctl poweroff"
      iconGlyph: "\uf011"
      keybind: Qt.Key_U
    }
  ]

  Timer {
    id: hideWindow

    interval: Theme.animationSpeed

    onTriggered: root.shouldShowMenu = false
  }
  IpcHandler {
    function toggle() {
      if (hideWindow.running)
        return;
      if (!root.shouldShowMenu)
        root.shouldShowMenu = true;
      else {
        menuLoader.item.contentItem.focus = false;
        menuLoader.item.windowOpacity = 0;
        hideWindow.start();
      }
    }

    target: "powerMenu"
  }
  LazyLoader {
    id: menuLoader

    active: root.shouldShowMenu

    PanelWindow {
      id: menuWindow

      property real windowOpacity: 0

      HyprlandWindow.opacity: windowOpacity
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
      WlrLayershell.layer: WlrLayer.Overlay
      color: "transparent"
      exclusionMode: ExclusionMode.Ignore
      implicitHeight: content.implicitHeight
      implicitWidth: content.implicitWidth

      Behavior on HyprlandWindow.opacity {
        NumberAnimation {
          duration: Theme.animationSpeed
          easing.type: Easing.OutCubic
        }
      }

      Component.onCompleted: windowOpacity = 1

      anchors {
        left: true
        top: true
      }
      margins {
        left: (screen.width - content.width) / 2
        top: (screen.height - content.height) / 2
      }
      contentItem {
        focus: true

        Keys.onPressed: event => {
          if (event.key == Qt.Key_Escape) {
            menuWindow.contentItem.focus = false;
            menuWindow.windowOpacity = 0;
            hideWindow.start();
          } else
            for (let i = 0; i < tiles.length; i++) {
              let tile = tiles[i];
              if (event.key == tile.keybind) {
                tile.proc.startDetached();
                root.shouldShowMenu = false;
              }
            }
        }
      }
      Rectangle {
        id: content

        color: Theme.background
        implicitHeight: tilesGrid.implicitHeight + Theme.spacing * 2
        implicitWidth: tilesGrid.implicitWidth + Theme.spacing * 2
        radius: Theme.borderRadius

        border {
          color: Theme.secondary
          width: Theme.borderWidth
        }
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
                modelData.proc.startDetached();
                root.shouldShowMenu = false;
              }
            }
          }
        }
      }
    }
  }
}
