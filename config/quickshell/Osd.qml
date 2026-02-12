import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

Scope {
	id: root
	
	Connections {
		target: Services
		function onVolumeChanged() {
			root.shouldShowOsd = true;
			hideTimer.restart();
		}
	}

  property bool shouldShowOsd: false

	Timer {
		id: hideTimer
		interval: 1000
		onTriggered: root.shouldShowOsd = false
  }

	LazyLoader {
		active: root.shouldShowOsd
		PanelWindow {
			anchors.bottom: true
			margins.bottom: screen.height / 6
			exclusiveZone: 0
			implicitWidth: 250
			implicitHeight: 35
			color: "transparent"
      mask: Region {}

			Rectangle {
				anchors.fill: parent
        color: Theme.background
        radius: 5
				border {
          color: Theme.border
          width: 1
        }

				RowLayout {
					anchors {
            fill: parent
            leftMargin: 10
            rightMargin: 10
          }

          Text {
            color: Theme.text
            font {
              pixelSize: Theme.fontSize
              family: Theme.font
            }
            text: `${Math.floor(Pipewire.defaultAudioSink?.audio.volume * 100)}%`
          }

					Rectangle {
						Layout.fillWidth: true
						implicitHeight: 10
						radius: 5
						color: Theme.border

						Rectangle {
							anchors {
								left: parent.left
								top: parent.top
								bottom: parent.bottom
              }
							radius: parent.radius
              color: Theme.text
							implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
						}
					}
				}
			}
		}
	}
}

