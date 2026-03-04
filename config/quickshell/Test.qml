import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import Qt5Compat.GraphicalEffects

Scope {
  id: root

  property bool shouldTestScreen: false

  IpcHandler {
    target: "test"
    function toggle() {
      root.shouldTestScreen = !root.shouldTestScreen
    }
  }

  LazyLoader {
    active: root.shouldTestScreen
    PanelWindow {
      anchors {
        top: true
        bottom: true
        left: true
        right: true
      }
      exclusionMode: ExclusionMode.Ignore
      WlrLayershell.layer: WlrLayer.Overlay
      ScreencopyView {
        id: screen
        anchors.fill: parent
        captureSource: Quickshell.screens[0]
      }
      FastBlur {
        anchors.fill: screen
        source: screen
        radius: 10
      }
    }
  }
}
