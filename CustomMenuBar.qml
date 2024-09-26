import QtQuick

Item {
    id: root

    property alias menuWidth: root.width
    property alias menuHeight: root.height

    readonly property int menuItemWidth: 50
    readonly property int menuItemHeight: menuHeight

    readonly property color textColor: "#ffffff"
    readonly property int textSize: 11

    Rectangle {
        id: menuBar

        // Size
        width: root.width
        height: root.height

        // Background color
        color: "#1a2127"

        Row {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            spacing: 30

            // File Menu
            Item {
                id: menuFile
                width: menuItemWidth
                height: menuItemHeight

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
            Item {
                id: menuEdit
                width: menuItemWidth
                height: menuItemHeight

                Text {
                    text: "Edit"
                    color: textColor
                    font.pointSize: textSize
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        console.log("menuEdit Clicked")
                    }
                }
            }

            // About Menu
            Item {
                id: menuAbout
                width: menuItemWidth
                height: menuItemHeight

                Text {
                    text: "About"
                    color: textColor
                    font.pointSize: textSize
                    anchors.centerIn: parent
                }

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        console.log("menuAbout Clicked")
                    }
                }
            }
        }
    }
}
