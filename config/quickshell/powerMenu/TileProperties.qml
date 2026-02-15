import Quickshell.Io
import QtQuick

QtObject {
  id: root

  property string iconGlyph
  property string command
  property int keybind
  property Process proc: Process {
    command: ["sh", "-c", root.command]
  }
}
