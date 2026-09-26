import QtQuick
import Quickshell
import Quickshell.Wayland
import ".."

PanelWindow {
  WlrLayershell.layer: WlrLayer.Background
  WlrLayershell.exclusionMode: ExclusionMode.Ignore
  color: Theme.background

  anchors {
    top: true
    bottom: true
    left: true
    right: true
  }
  Image {
    id: wallpaper

    source: Theme.wallpaper
    width: implicitWidth * (height / implicitHeight)

    anchors {
      top: parent.top
      bottom: parent.bottom
    }
  }
}
