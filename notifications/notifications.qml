import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Scope {
    property var currentNotification: null
    Connections {
        target: NotificationServer {
            onNotification: (n) => {
                // Handle new notification 'n' here
                console.log(n.summary + ": " + n.body);

                // Keep the notification around
                n.tracked = true
                currentNotification = n

                // Hide it after 5 seconds
                hideTimer.restart()
            }
        }
    }
    Timer {
        id: hideTimer
        interval: 5000

        onTriggered: {
            if (currentNotification) {
                currentNotification.dismiss()
                currentNotification = null
            }
        }
    }
    PanelWindow {
        anchors {
            bottom: true
            right: true
        }
        color: "transparent"

        margins {
            bottom: 20
            right: 20
        }
        implicitWidth: 350
        implicitHeight: 100
        visible: currentNotification !== null
        Rectangle {
            anchors {
                fill: parent
            }
            color: "#171717"
            border.color: "#257D3D"
            border.width: 1
            Column {
                anchors {
                        fill: parent
                        margins: 16
                    }

                spacing: 6
                Text {
                    width: parent.width
                    text: currentNotification
                        ? currentNotification.summary
                        : ""

                    color: "white"
                    font.pixelSize: 20

                    elide: Text.ElideRight
                    font.family: "FiraCode"
                }
                Text {
                    width: parent.width
                    text: currentNotification
                        ? currentNotification.body
                        : ""

                    color: "white"
                    font.pixelSize: 16
                    font.family: "FiraCode"

                    elide: Text.ElideRight
                }
            }
        }
    }
}
