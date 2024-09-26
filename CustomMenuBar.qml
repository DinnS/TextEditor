import QtQuick

Item {
    readonly property color textColor: "#ffffff"
    readonly property int textSize: 11

    Rectangle {
        id: menuBar
        width: parent.width
        height: 35
        color: "#1a2127"

        Row {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            spacing: 30

            // File Menu
            Item {
                id: menuFile
                width: 30
                height: parent.height

                Text {
                    text: "File"
                    color: textColor
                    font.pointSize: textSize
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("menuFile Clicked")
                    }
                }
            }

            // Edit Menu
            Text {
                id: menuEdit
                text: "Edit"
                color: textColor
                font.pointSize: textSize
                anchors.verticalCenter: parent.verticalCenter
            }

            // About Menu
            Text {
                id: menuAbout
                text: "About"
                color: textColor
                font.pointSize: textSize
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
