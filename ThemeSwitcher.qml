import QtQuick
import QtQuick.Controls 2.15

// Theme Switcher
Item {
    id: root

    // Switch Size
    property int itemWidth: 100
    property int itemHeight: 100

    // Icons source
    property url iconLightMode: "qrc:/icons/icons/IconLightMode.png"
    property url iconDarkMode: "qrc:/icons/icons/IconDarkMode.png"

    // Switch status
    property bool isDarkTheme: true

    // Switch Container
    width: itemWidth * 2
    height: itemHeight

    // Switch Border Setup
    property int switchBorderRadius: 5
    property int switchBorderWidth: 3

    // Switch Light Color
    property color lightColor: "#f4edf4"
    property color lightBorderColorActive: "#EC4E20"
    property color lightBorderColorDisable: "transparent"

    // Switch Dark Color
    property color darkColor: "#2C302E"
    property color darkBorderColorActive: "#EC4E20"
    property color darkBorderColorDisable: "transparent"

    // Switch Container
    Row {
        // Switch Container Size
        width: root.width
        height: root.height

        // Switch Container Setup
        spacing: 10

        // Switch Light
        Rectangle {
            id: switchLight

            // Switch Light Size
            width: root.itemWidth
            height: root.itemHeight
            radius: root.switchBorderRadius

            // Switch Light Color
            color: root.lightColor

            // Switch Light Border
            border.width: root.switchBorderWidth
            border.color: root.isDarkTheme ? root.lightBorderColorDisable : root.lightBorderColorActive

            // Switch Light Icon
            Image {
                // Switch Light Icon Source
                source: root.iconLightMode

                // Switch Light Icon Size
                width: 30
                height: 30

                // Switch Light Icon Position
                anchors.centerIn: switchLight
            }

            // Switch Light Mouse Area
            MouseArea {
                // Switch Light Mouse Area Size
                anchors.fill: switchLight

                // Switch Light Mouse Area Event Clicked
                onClicked: {
                    // If clicked and status dark, then change to light status
                    if(root.isDarkTheme === true) {
                        root.isDarkTheme = false
                    }
                }
            }

        }

        // Switch Dark
        Rectangle {
            id: switchDark

            // Switch Dark Size
            width: root.itemWidth
            height: root.itemHeight
            radius: root.switchBorderRadius

            // Switch Dark Color
            color: root.darkColor

            // Switch Dark Border
            border.width: root.switchBorderWidth
            border.color: root.isDarkTheme ?  root.darkBorderColorActive : root.darkBorderColorDisable

            // Switch Dark Icon
            Image {
                // Switch Dark Icon Source
                source: root.iconDarkMode

                // Switch Dark Icon Size
                width: 25
                height: 25

                // Switch Dark Icon Position
                anchors.centerIn: switchDark
            }

            // Switch Dark Mouse Area
            MouseArea {
                // Switch Dark Mouse Area Size
                anchors.fill: switchDark

                // Switch Dark Mouse Area Event Clicked
                onClicked: {
                    // If clicked and status light, then change to dark status
                    if(root.isDarkTheme === false) {
                        root.isDarkTheme = true
                    }
                }
            }
        }
    }

}
