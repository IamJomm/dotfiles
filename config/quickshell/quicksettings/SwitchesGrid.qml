import Quickshell.Io
import QtQuick
import ".."

Grid {
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
    active: true
    iconGlyph: "\uf1eb"
    onActivated: {
      enableWifi.running = true
      airplane.active = false
    }
    onDeactivated: disableWifi.running = true
  }
  Switch {
    id: bluetooth
    active: true
    iconGlyph: "\uf294"
    onActivated: {
      enableBluetooth.running = true
      airplane.active = false
    }
    onDeactivated: disableBluetooth.running = true
  }
  Switch {
    id: airplane
    iconGlyph: "\uf072"
    onActivated: {
      enableAirplane.running = true
      wifi.active = false
      bluetooth.active = false
    }
    onDeactivated: {
      disableAirplane.running = true
      wifi.active = true
      bluetooth.active = true
    }
  }
  Switch {
    iconGlyph: "\uf1f6"
    onActivated: Settings.notifications = false
    onDeactivated: Settings.notifications = true
  }
  Switch {
    iconGlyph: "\uf185"
    onActivated: {}
    onDeactivated: {}
  }
  Switch {
    iconGlyph: ""
    onActivated: {}
    onDeactivated: {}
  }
}
