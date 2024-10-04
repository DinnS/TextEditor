import QtQuick

// Button
Item {
    id: root

    // Theme Colors
    CustomColors {
        id: themeColors
    }

    // Theme Changer
    property bool isDarkTheme: true

    // Body Color
    property color buttonColorDefault: root.isDarkTheme ? themeColors.darkMenuBar : themeColors.lightMenuBar
    property color buttonColorHover: root.isDarkTheme ? themeColors.darkMenuHover : themeColors.lightMenuHover

    // Text Color
    property color textColorDefault: root.isDarkTheme ? themeColors.darkTextDefault : themeColors.lightTextDefault
    property color textColorHover: root.isDarkTheme ? themeColors.darkTextDefault : themeColors.lightTextDefault
    property color textColorPressed: root.isDarkTheme ? themeColors.darkTextDefault : themeColors.lightTextDefault
    // Text Setup
    property string text: "Default"
    property int textSize: 12

    // Text Alignment
    property string textAlignment: "center"

    // Clicked Signal
    signal clicked()

    // To instantly change colors after changing the theme
    onIsDarkThemeChanged: {
        body.color = root.isDarkTheme ? themeColors.darkMenuBar : themeColors.lightMenuBar
        text.color = root.isDarkTheme ? themeColors.darkTextDefault : themeColors.lightTextDefault
    }

    // Body
    Rectangle {
        id: body

        // Body Size
        anchors.fill: root

        // Body Color
        color: root.buttonColorDefault

        // Body Radius
        radius: 7

        // Text
        Text {
            id: text

            // Text Position
            anchors.verticalCenter: body.verticalCenter
            anchors.horizontalCenter: (root.textAlignment === "center" ? parent.horizontalCenter : undefined)
            anchors.left: (root.textAlignment === "left" ? parent.left : undefined)
            // Add a margin if left aligned
            anchors.leftMargin: (root.textAlignment === "left" ? 20 : 0)

            // Text Setup
            text: root.text
            font.pointSize: root.textSize

            // Text Color
            color: root.textColorDefault
        }

        // Mouse Area
        MouseArea {
            id: mouseArea

            // Mouse Area Size
            anchors.fill: body

            // Mouse Area Setup
            hoverEnabled: true

            // Mouse Area Pressed Event
            onPressed: {
                // If Pressed, than Change Button Body Color
                body.color = root.buttonColorHover

                // If Pressed, than Invoke Custom Click Event
                root.clicked()
            }

            // Mouse Area Entered Event
            onEntered: {
                // If Entered, than Change Button Body Color
                body.color = root.buttonColorHover
            }

            // Mouse Area Exited Event
            onExited: {
                // If Exited, than Change Button Body Color
                body.color = root.buttonColorDefault
            }
        }
    }
}
