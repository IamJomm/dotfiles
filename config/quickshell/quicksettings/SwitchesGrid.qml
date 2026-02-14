import QtQuick
import ".."

Grid {
  columns: 3
  spacing: Theme.spacing 
  Switch {
    iconGlyph: "\uf1f6"
    onActivated: Settings.notifications = false
    onDeactivated: Settings.notifications = true
  }
  Switch {
    iconGlyph: "\uf1f6"
    onActivated: console.log("ac")
    onDeactivated: console.log("deac")
  }
  Switch {
    iconGlyph: "\uf1f6"
    onActivated: console.log("ac")
    onDeactivated: console.log("deac")
  }
}
