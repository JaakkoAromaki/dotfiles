import Quickshell 
import Quickshell.Wayland 
import Quickshell.Hyprland 
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick
import Quickshell.Services.Mpris


PanelWindow {
	id: panel

	readonly property list<MprisPlayer> playerList: Mpris.players.values
    property MprisPlayer selectedPlayer: playerList.length > 0 ? playerList[activeIndex] : null
    readonly property MprisPlayer activePlayer: selectedPlayer
    property int activeIndex: 0
	property string playerName: selectedPlayer?.identity ?? ""
	property int imageSize: 60


	color: "transparent";
	anchors { 
		top: true 
		left: true 
		right: true 
	} 
	implicitHeight: 40 
	SystemClock { 
		id: clock 
		precision: SystemClock.Seconds 
	} 
	PopupWindow { 
		id: menu 
		anchor.window: panel 
		anchor.rect.x: 425 
		anchor.rect.y: panel.height - 33
		width: 600 
		height: 40 
		visible: true 
		color: "transparent" 

		Rectangle { 
			id: contentt 
			color: "#1e1d1d" 
			opacity: 0.8
			radius: 6 
			border.color: "#3d3d3d" 
			border.width: 1 
			width: 150 
			height: 35 
			anchors.horizontalCenter: parent.horizontalCenter 
			anchors.top: parent.top 

			Text {
					id: "kello"
					text: Qt.formatDateTime(clock.date, "hh:mm:ss")
					font.pointSize: 13
					color: "white"
					anchors.centerIn: parent 
				

					Behavior on opacity {
						NumberAnimation {
							duration: 500
							easing.type: Easing.InOutQuad
						}
					}
				}

			 RowLayout { 
				anchors.fill: parent
				anchors.margins: 18
				spacing: 8

				// tänään kortti
				ColumnLayout {
					id: "today"
					Layout.alignment: Qt.AlignTop
					spacing: 6
					opacity: 0
					visible: false

					Text {
						text: "tänään"
						color: '#465f4b'
						font.pointSize: 11
					}

					Text {
						text: new Date().toLocaleDateString(Qt.locale("fi_FI"))
						color: "white"
						font.pointSize: 11
						fontSizeMode: Text.Fit
					}

					Text {
						color: "white"
						font.pointSize: 11
						text: "viikko " + getWeekNumber(new Date())
						fontSizeMode: Text.Fit

						function getWeekNumber(d) {
							// Copy date so don't modify original
							d = new Date(Date.UTC(d.getFullYear(), d.getMonth(), d.getDate()));
							// Set to nearest Thursday: current date + 4 - current day number (make Sunday 7)
							d.setUTCDate(d.getUTCDate() + 4 - (d.getUTCDay() || 7));
							// Get first day of year
							var yearStart = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));
							// Calculate full weeks to nearest Thursday
							var weekNo = Math.ceil((((d - yearStart) / 86400000) + 1) / 7);
							return weekNo;
						}
					}
					Rectangle {
						width: 120
						height: 1
						color: "#cfcfcf"
					}

					Behavior on opacity {
						NumberAnimation {
							duration: 200
							easing.type: Easing.InOutQuad
						}
					}
				}

				// musiikkisoitin
				RowLayout {
					id: "audio"
    					visible: false
					opacity: 0.0
					anchors.horizontalCenter: parent

					Image {
						Layout.preferredWidth: imageSize
						Layout.preferredHeight: imageSize
						Layout.maximumWidth: imageSize
						Layout.maximumHeight: imageSize
						fillMode: Image.PreserveAspectFit
						smooth: true
						source: activePlayer.trackArtUrl
					}

					ColumnLayout {
						Text {
							id: "biisi"
							text: activePlayer.trackTitle || "Tuntematon biisi"
							color: "white"
							font.pointSize: 16
							font.family: "FiraCode"
							fontSizeMode: Text.Fit
						}

						Text {
							text: activePlayer.trackArtist || "Tuntematon artisti"
							color: "lightgray"
							font.pointSize: 10
							font.family: "FiraCode"
							fontSizeMode: Text.Fit
						}
						Control {
							ProgressBar {
								id: progressBar
								width: 150
								height: 5

								value: activePlayer.length > 0
									? activePlayer.position / activePlayer.length
									: 0

								background: Rectangle {
									implicitWidth: 150
									implicitHeight: 5
									color: "#3d3d3d"
									radius: 0
								}

								contentItem: Rectangle {
									width: progressBar.visualPosition * progressBar.width
									height: progressBar.height
									color: '#458e5d'
									radius: 0
								}
							}
						}
					}
					Behavior on opacity {
						NumberAnimation {
							duration: 200
							easing.type: Easing.InOutQuad
						}
					}
				}
			}

			Behavior on width { 
				NumberAnimation { 
					duration: 200
					easing.type: Easing.InOutQuad 
				} 
			} 

			Behavior on height { 
				NumberAnimation { 
					duration: 250
					easing.type: Easing.InOutQuad 
				} 
			} 

			Timer {
				id: heightTimer 
				interval: 250
				repeat: false 
				onTriggered: { 
					contentt.height = 600 
					contentTimer.start() 
				} 
			}
			Timer {
				id: widthTimer 
				interval: 250
				repeat: false 
				onTriggered: { 
					contentt.width = 150
					menu.implicitHeight = 40
					kello.visible = true
					kello.opacity = 1.0
				} 
			} 
			Timer {
				id: contentTimer 
				interval: 250 
				repeat: false 
				onTriggered: { 
					console.log("hi")

					audio.visible = true
					audio.opacity = 1.0

					today.visible = true
					today.opacity = 1.0
				} 
			} 

			MouseArea { 
				anchors.fill: parent 
				onClicked: { 
					if (contentt.width == 150) { 
						contentt.width = 600 
						menu.anchor.rect.x = 425 
						menu.height = 600 
						kello.visible = false
						kello.opacity = 0.0
						heightTimer.start()
					} else {
						contentt.height = 33
						audio.visible = false
						audio.opacity = 0.0

						today.visible = false
						today.opacity = 0.0
						widthTimer.start()
					}
				} 
			} 
		} 
	} 
}
