import QtQuick
import Quickshell.Io

QtObject {
  id: root

  property string command
  property string iconGlyph
  property int keybind
  property Process proc: Process {
    command: ["sh", "-c", root.command]
  }
}
