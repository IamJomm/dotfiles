import QtQuick
import QtQuick.Controls
import Quickshell
import ".."

TextField {
  required property var filterAppList

  signal escapePressed
  signal enterPressed
  signal nPressed
  signal pPressed
  signal fPressed
  signal bPressed

  color: Theme.primary
  focus: true
  implicitHeight: 35
  leftPadding: 20
  rightPadding: 20

  background: Rectangle {
    anchors.fill: parent
    color: Theme.background
    radius: Theme.borderRadius

    border {
      color: Theme.secondary
      width: Theme.borderWidth
    }
  }

  onTextChanged: filterAppList(text)
  onAccepted: enterPressed()
  Keys.onPressed: event => {
    if (event.key == Qt.Key_Escape)
      escapePressed();
    if ((event.modifiers & Qt.ControlModifier))
      switch (event.key) {
      case Qt.Key_N:
        nPressed();
        break;
      case Qt.Key_P:
        pPressed();
        break;
      case Qt.Key_F:
        fPressed();
        break;
      case Qt.Key_B:
        bPressed();
        break;
      case Qt.Key_W:
        const lastSpace = text.lastIndexOf(' ');
        if (lastSpace > 0)
          text = text.substr(0, lastSpace);
        else
          text = "";
        break;
      case Qt.Key_U:
        text = "";
        break;
      }
  }

  anchors {
    left: parent.left
    right: parent.right
  }
  font {
    family: Theme.font
    pixelSize: Theme.fontSize
  }
}
