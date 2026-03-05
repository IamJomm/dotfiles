import Qt5Compat.GraphicalEffects
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Wayland

Scope {
  id: root

  property bool shouldTestScreen: false

  IpcHandler {
    function toggle() {
      root.shouldTestScreen = !root.shouldTestScreen;
    }

    target: "test"
  }
  LazyLoader {
    active: root.shouldTestScreen

    PanelWindow {
      WlrLayershell.layer: WlrLayer.Overlay
      exclusionMode: ExclusionMode.Ignore

      anchors {
        bottom: true
        left: true
        right: true
        top: true
      }
      ScreencopyView {
        id: screen

        anchors.fill: parent
        captureSource: Quickshell.screens[0]
      }
      FastBlur {
        anchors.fill: screen
        radius: 10
        source: screen
      }
    }
  }
}
