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
      if(shouldShowOsd) {
        osdLoader.item.osdOpacity = 1
        hideWindow.stop()
        hideAnimation.restart()
      }
      else root.shouldShowOsd = true
		}
	}

	Timer {
    id: hideWindow
    interval: Theme.animationSpeed
    onTriggered: root.shouldShowOsd = false
  }
  Timer {
    id: hideAnimation
    interval: 1000 - Theme.animationSpeed
    onTriggered: {
      osdLoader.item.osdOpacity = 0
      hideWindow.start()
    }
  }

	LazyLoader {
    id: osdLoader
		active: root.shouldShowOsd
		PanelWindow {
      property alias osdOpacity: osd.opacity
      
			anchors.bottom: true
			margins.bottom: screen.height / 6
			exclusiveZone: 0
			implicitWidth: 250
			implicitHeight: 35
			color: "transparent"
      mask: Region {}
			Rectangle {
        id: osd

				anchors.fill: parent
        color: Theme.background
        radius: Theme.borderRadius
				border {
          color: Theme.secondary
          width: Theme.borderWidth
        }
				RowLayout {
					anchors {
            fill: parent
            leftMargin: Theme.spacing
            rightMargin: Theme.spacing
          }
          Text {
            color: Theme.primary
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
						color: Theme.secondary
						Rectangle {
							anchors {
								left: parent.left
								top: parent.top
								bottom: parent.bottom
              }
							radius: parent.radius
              color: Theme.primary
							implicitWidth: parent.width * (Pipewire.defaultAudioSink?.audio.volume ?? 0)
              Behavior on implicitWidth {
                NumberAnimation {
                  duration: Theme.animationSpeed
                  easing.type: Easing.OutCubic
                }
              }
						}
					}
				}
        opacity: 0
        Behavior on opacity {
          NumberAnimation {
            duration: Theme.animationSpeed
            easing.type: Easing.OutCubic
          }
        }
        Component.onCompleted: {
          opacity = 1
          hideAnimation.start()
        }
			}
		}
	}
}
