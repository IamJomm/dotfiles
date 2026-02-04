import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Layouts

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }
  height: content.implicitHeight + 10
  color: "transparent"
  RowLayout {
    id: content
    spacing: 10
    anchors {
      top: parent.top
      left: parent.left
      right: parent.right
      margins: 10
    } 
    
    BarModule {
      id: titleModule 
      contentText: Hyprland.activeToplevel?.title.length > 60 ?
        `...${Hyprland.activeToplevel?.title.slice(-60)}` :
        Hyprland.activeToplevel?.title
    }

    Item { Layout.fillWidth: true }



    Item { Layout.fillWidth: true }

    BarModule {
      id: trayModule

    }
    BarModule {
      id: soundModule
      PwObjectTracker {
    		objects: [ Pipewire.defaultAudioSink ]
    	}	
      contentText: `\uf025  ${Math.floor(Pipewire.defaultAudioSink?.audio.volume * 100)}%`
    }
    BarModule {
      id: timeModule
      SystemClock {
        id: clock
        precision: SystemClock.Seconds
      }
      contentText: Qt.formatDateTime(clock.date, "\uf017  hh:mm:ss dd/MM/yyyy")
    }
    BarModule {
      id: quickSettings
      contentText: "\uf0c9"
      areaHover: true
      implicitHeight: 35
      implicitWidth: 35
      onActivated: {}
    }
  }
}
