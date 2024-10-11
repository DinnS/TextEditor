import QtQuick
import QtQuick.Controls 2.15

// Theme Switcher
Item {
    id: root

    // Switch Size
    property int itemWidth: 100
    property int itemHeight: 100

    // Icons Source
    property url iconLightMode: "qrc:/icons/icons/IconLightMode.png"
    property url iconDarkMode: "qrc:/icons/icons/IconDarkMode.png"

    // Switch Status
    property bool isDarkTheme: true

    // Switch Border Setup
    readonly property int switchBorderRadius: 5
    readonly property int switchBorderWidth: 4

    // Switch Light Color
    property color lightColor: themeColors.lightThemeSwitcher
    property color lightBorderColorFirst: themeColors.lightThemeSwitcherBorderFirst
    property color lightBorderColorSecond: themeColors.lightThemeSwitcherBorderSecond
    property color lightBorderColorThird: themeColors.lightThemeSwitcherBorderThird

    property color lightBorderColorDisable: themeColors.lightThemeSwitcherBorderDisable

    // Switch Dark Color
    property color darkColor: themeColors.darkThemeSwitcher
    property color darkBorderColorFirst: themeColors.darkThemeSwitcherBorderFirst
    property color darkBorderColorSecond: themeColors.darkThemeSwitcherBorderSecond
    property color darkBorderColorThird: themeColors.darkThemeSwitcherBorderThird

    property color darkBorderColorDisable: themeColors.darkThemeSwitcherBorderDisable

    // Switch Border Color Animation
    readonly property int borderColorAnimationDuration: 500

    // Switch Container
    width: root.itemWidth * 2
    height: root.itemHeight

    // Theme Colors
    CustomColors {
        id: themeColors
    }

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
            border.color: root.isDarkTheme ? root.lightBorderColorDisable : root.lightBorderColorFirst

            // Switch Light Border Animation
            SequentialAnimation {
                id: lightBorderAnimation
                loops: Animation.Infinite

                // Conditions for running
                running: !root.isDarkTheme

                // Transition
                ColorAnimation {
                    target: switchLight.border
                    property: "color"
                    from: root.lightBorderColorFirst
                    to: root.lightBorderColorSecond
                    duration: root.borderColorAnimationDuration
                }

                ColorAnimation {
                    target: switchLight.border
                    property: "color"
                    from: root.lightBorderColorSecond
                    to: root.lightBorderColorThird
                    duration: root.borderColorAnimationDuration
                }

                ColorAnimation {
                    target: switchLight.border
                    property: "color"
                    from: root.lightBorderColorThird
                    to: root.lightBorderColorSecond
                    duration: root.borderColorAnimationDuration
                }

                ColorAnimation {
                    target: switchLight.border
                    property: "color"
                    from: root.lightBorderColorSecond
                    to: root.lightBorderColorFirst
                    duration: root.borderColorAnimationDuration
                }
            }

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
            border.color: root.isDarkTheme ?  root.darkBorderColorFirst : root.darkBorderColorDisable

            // Switch Dark Border Animation
            SequentialAnimation {
                id: darkBorderAnimation
                loops: Animation.Infinite

                // Conditions for running
                running: root.isDarkTheme

                // Transition
                ColorAnimation {
                    target: switchDark.border
                    property: "color"
                    from: root.darkBorderColorFirst
                    to: root.darkBorderColorSecond
                    duration: root.borderColorAnimationDuration
                }

                ColorAnimation {
                    target: switchDark.border
                    property: "color"
                    from: root.darkBorderColorSecond
                    to: root.darkBorderColorThird
                    duration: root.borderColorAnimationDuration
                }

                ColorAnimation {
                    target: switchDark.border
                    property: "color"
                    from: root.darkBorderColorThird
                    to: root.darkBorderColorSecond
                    duration: root.borderColorAnimationDuration
                }

                ColorAnimation {
                    target: switchDark.border
                    property: "color"
                    from: root.darkBorderColorSecond
                    to: root.darkBorderColorFirst
                    duration: root.borderColorAnimationDuration
                }
            }

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
