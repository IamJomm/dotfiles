import Quickshell.Io
import QtQuick
import ".."

Rectangle {
  implicitWidth: content.width + Theme.spacing * 2
  implicitHeight: content.height + Theme.spacing * 2
  radius: Theme.borderRadius
  border {
    color: Theme.secondary
    width: Theme.borderWidth
  }
  color: Theme.background
  Grid {
    id: content
    anchors.centerIn: parent
    Process {
      id: enableWifi
      command: ["rfkill", "unblock wifi"]
    }
    Process {
      id: disableWifi
      command: ["rfkill", "block wifi"]
    }
    Process {
      id: enableBluetooth
      command: ["rfkill", "unblock bluetooth"]
    }
    Process {
      id: disableBluetooth
      command: ["rfkill", "block bluetooth"]
    }
    Process {
      id: enableAirplane
      command: ["rfkill", "block all"]
    }
    Process {
      id: disableAirplane
      command: ["rfkill", "unblock all"]
    }
    columns: 3
    spacing: Theme.spacing
    Switch {
      id: wifi
      active: Settings.wifi
      iconGlyph: "\uf1eb"
      onActivated: {
        enableWifi.running = true
        Settings.wifi = true
        airplane.active = false
        Settings.airplane = false
      }
      onDeactivated: {
        disableWifi.running = true
        Settings.wifi = false
      }
    }
    Switch {
      id: bluetooth
      active: Settings.bluetooth
      iconGlyph: "\uf294"
      onActivated: {
        enableBluetooth.running = true
        Settings.bluetooth = true
        airplane.active = false
        Settings.airplane = false
      }
      onDeactivated: {
        disableBluetooth.running = true
        Settings.bluetooth = false
      }
    }
    Switch {
      id: airplane
      active: Settings.airplane
      iconGlyph: "\uf072"
      onActivated: {
        enableAirplane.running = true
        Settings.airplane = true
        wifi.active = false
        Settings.wifi = false
        bluetooth.active = false
        Settings.bluetooth = false
      }
      onDeactivated: {
        disableAirplane.running = true
        Settings.airplane = false
        wifi.active = true
        Settings.wifi = true
        bluetooth.active = true
        Settings.bluetooth = true
      }
    }
    Switch {
      active: Settings.dnd
      iconGlyph: "\uf1f6"
      onActivated: Settings.dnd = true
      onDeactivated: Settings.dnd = false
    }
    Switch {
      active: Settings.sunset
      iconGlyph: "\uf185"
      onActivated: Settings.sunset = true
      onDeactivated: Settings.sunset = false
    }
    Switch {
      active: Settings.idk
      iconGlyph: ""
      onActivated: Settings.idk = true
      onDeactivated: Settings.idk = false
    }
  }
}
