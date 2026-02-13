import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
import "../quicksettings"
import ".."

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }
  implicitHeight: content.implicitHeight + 10
  color: "transparent"

  LazyLoader {
    id: quickSettingsLoader
    loading: true
    QuickSettings {}
  }

  IpcHandler {
    target: "quickSettingsLoader"
    function toggle() { quickSettingsLoader.item.visible = !quickSettingsLoader.item.visible }
  }

  Workspaces {
    anchors {
      top: parent.top
      horizontalCenter: parent.horizontalCenter
      topMargin: 10
    }
  }

  RowLayout {
    id: content
    spacing: Theme.spacing
    anchors {
      top: parent.top
      left: parent.left
      right: parent.right
      margins: 10
    } 
    
    Module {
      contentElide: Text.ElideLeft
      contentText: Hyprland.activeToplevel?.title
    } 

    Item { Layout.fillWidth: true }

    Tray {}

    Module {
      contentText: `\uf025  ${Math.floor(Pipewire.defaultAudioSink?.audio.volume * 100)}%`
    }

    Module {
      SystemClock {
        id: clock
        precision: SystemClock.Seconds
      }
      contentText: Qt.formatDateTime(clock.date, "\uf017  hh:mm:ss dd/MM/yyyy")
    }

    Module {
      contentText: "\uf0c9"
      areaHover: true
      implicitHeight: 35
      implicitWidth: 35
      onTriggered: quickSettingsLoader.item.visible = !quickSettingsLoader.item.visible
    }
  }
}
