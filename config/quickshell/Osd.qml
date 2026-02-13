import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

Scope {
	id: root
  
  property bool shouldShowOsd: false
	
	Connections {
		target: Services
		function onVolumeChanged() {
			root.shouldShowOsd = true;
			hideTimer.restart();
		}
	}

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
        radius: Theme.borderRadius
				border {
          color: Theme.borderColor
          width: Theme.borderWidth
        }

				RowLayout {
					anchors {
            fill: parent
            leftMargin: Theme.spacing
            rightMargin: Theme.spacing
          }

          Text {
            color: Theme.textColor
            font {
              pixelSize: Theme.fontSize
              family: Theme.font
            }
            text: `${Math.floor(Pipewire.defaultAudioSink?.audio.volume * 100)}%`
          }

					Rectangle {
						Layout.fillWidth: true
						implicitHeight: 10
						radius: Theme.borderRadius
						color: Theme.borderColor

						Rectangle {
							anchors {
								left: parent.left
								top: parent.top
								bottom: parent.bottom
              }
							radius: parent.radius
              color: Theme.textColor
							implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
						}
					}
				}
			}
		}
	}
}
