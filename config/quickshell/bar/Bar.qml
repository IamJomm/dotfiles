import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray
import "../quicksettings"
import ".."

Scope {
  property bool shouldShowQuickSettings: false

  LazyLoader {
    id: quickSettingsLoader

    active: shouldShowQuickSettings

    QuickSettings {}
  }
  Timer {
    id: hideQuicksettings

    interval: Theme.animationSpeed

    onTriggered: shouldShowQuickSettings = false
  }
  IpcHandler {
    function toggle() {
      if (hideQuicksettings.running)
        return;
      if (!shouldShowQuickSettings)
        shouldShowQuickSettings = true;
      else {
        quickSettingsLoader.item.windowOpacity = 0;
        hideQuicksettings.start();
      }
    }

    target: "quickSettings"
  }
  PanelWindow {
    color: "transparent"
    implicitHeight: content.implicitHeight + Theme.spacing

    anchors {
      left: true
      right: true
      top: true
    }
    Workspaces {
      anchors {
        horizontalCenter: parent.horizontalCenter
        top: parent.top
        topMargin: Theme.spacing
      }
    }
    RowLayout {
      id: content

      spacing: Theme.spacing

      anchors {
        left: parent.left
        margins: Theme.spacing
        right: parent.right
        top: parent.top
      }
      Module {
        contentElide: Text.ElideLeft
        contentText: Hyprland.activeToplevel ? Hyprland.activeToplevel.title : "Empty"
      }
      Item {
        Layout.fillWidth: true
      }
      Tray {}
      Module {
        contentGlyph: "\uf025"
        contentText: `${Math.floor(Pipewire.defaultAudioSink?.audio.volume * 100)}%`
      }
      Module {
        contentGlyph: "\uf017"
        contentText: `${Services.time}`
      }
      Module {
        areaHover: true
        contentGlyph: "\uf0c9"
        width: 35

        onTriggered: {
          if (hideQuicksettings.running)
            return;
          if (!shouldShowQuickSettings)
            shouldShowQuickSettings = true;
          else {
            quickSettingsLoader.item.windowOpacity = 0;
            hideQuicksettings.start();
          }
        }
      }
    }
  }
}
