import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts
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
    target: "quickSettings"
    function toggle() { 
      if(hideQuicksettings.running) return
      if(!shouldShowQuickSettings) shouldShowQuickSettings = true
      else {
        quickSettingsLoader.item.contentOpacity = 0
        hideQuicksettings.start()
      }
    }
  }

  PanelWindow {
    anchors {
      top: true
      left: true
      right: true
    }
    implicitHeight: content.implicitHeight + Theme.spacing
    color: "transparent"

    Workspaces {
      anchors {
        top: parent.top
        topMargin: Theme.spacing
        horizontalCenter: parent.horizontalCenter
      }
    }
    RowLayout {
      id: content
      spacing: Theme.spacing
      anchors {
        top: parent.top
        left: parent.left
        right: parent.right
        margins: Theme.spacing
      } 
      
      Module {
        contentElide: Text.ElideLeft
        contentText: Hyprland.activeToplevel ? Hyprland.activeToplevel.title : "Empty"
      }
 
      Item { Layout.fillWidth: true }
  
      Tray {}
  
      Module { contentText: `\uf025  ${Math.floor(Pipewire.defaultAudioSink?.audio.volume * 100)}%` }
  
      Module {
        contentText: `\uf017  ${Services.time}`
      }
  
      Module {
        contentText: "\uf0c9"
        areaHover: true
        width: 35
        onTriggered: {
          if(hideQuicksettings.running) return
          if(!shouldShowQuickSettings) shouldShowQuickSettings = true
          else {
            quickSettingsLoader.item.contentOpacity = 0
            hideQuicksettings.start()
          }
        }
      }
    }
  }
}
