import QtQuick
import Quickshell
import Quickshell.Services.Pam

Scope {
  id: root

  property string currentText: ""
  property bool showFailure: false
  property bool unlockInProgress: false

  signal failed
  signal unlocked

  function tryUnlock() {
    if (currentText === "")
      return;
    root.unlockInProgress = true;
    pam.start();
  }

  onCurrentTextChanged: showFailure = false

  PamContext {
    id: pam

    config: "password.conf"
    configDirectory: "pam"

    onCompleted: result => {
                   if (result == PamResult.Success) {
                     root.unlocked();
                   } else {
                     root.currentText = "";
                     root.showFailure = true;
                   }
                   root.unlockInProgress = false;
                 }
    onPamMessage: {
      if (this.responseRequired) {
        this.respond(root.currentText);
      }
    }
  }
}
