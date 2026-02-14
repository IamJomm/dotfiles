import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import ".."

Scope {
  id: root

  property bool shouldShowMenu: false

  IpcHandler {
    target: "powerMenu"
    function toggle() {
      root.shouldShowMenu = !root.shouldShowMenu
    }
  }

  LockScreen { id: lock }
  LazyLoader {
    active: root.shouldShowMenu
    PanelWindow {
      anchors {
        top: true
        bottom: true
        left: true
        right: true
      }
      exclusionMode: ExclusionMode.Ignore
      WlrLayershell.layer: WlrLayer.Overlay
      WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
      color: "transparent"
      contentItem {
		  	focus: true
		  	Keys.onPressed: event => {
		  		if (event.key == Qt.Key_Escape) root.shouldShowMenu = false;
		  	}
		  }
      Rectangle {
        anchors.fill: parent
        color: Theme.background
        Grid {
          anchors.centerIn: parent
          columns: 3
          spacing: Theme.spacing
          Tile {
            iconGlyph: "\uf023"
          }
          Tile {}
          Tile {}
          Tile {}
          Tile {}
          Tile {}
        }
      }
    }
  }
}
