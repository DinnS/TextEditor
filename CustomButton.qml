import QtQuick

/*    BUTTON    */
Item {
    id: root

    /*    THEME COLORS    */

    /*
    Provide Access to the Colors Library
    !!!Not the best approach
    */
    CustomColors {
        id: themeColors
    }

    /*    STATUS PROPERTIES    */
    property bool isDarkTheme: true
    property bool isButtonWithIcon: false
    property bool isTextWrap: true
    property bool isBorderColorAnimation: true

    property bool currentTrackFeature: false


    /*    BUTTON SOURCE    */

    // Icons Source
    property url iconLightSource: "qrc:/icons/icons/IconLightCheck.svg"
    property url iconDarkSource: "qrc:/icons/icons/IconDarkCheck.svg"
    property url iconSource: root.isDarkTheme ? root.iconLightSource : root.iconDarkSource


    /*    BUTTON COLORS    */

    // Body Color
    property color buttonColorDefault: root.isDarkTheme ? themeColors.darkButtonDefault : themeColors.lightButtonDefault
    property color buttonColorHover: root.isDarkTheme ? themeColors.darkButtonHover : themeColors.lightButtonHover

    // Text Color
    property color textColorDefault: root.isDarkTheme ? themeColors.darkTextDefault : themeColors.lightTextDefault
    property color textColorHover: root.isDarkTheme ? themeColors.darkTextDefault : themeColors.lightTextDefault
    property color textColorPressed: root.isDarkTheme ? themeColors.darkTextDefault : themeColors.lightTextDefault


    /*    BUTTON TEXT    */

    // Text Setup
    property string text: "Default"
    property int textSize: 12

    // Text Alignment
    property string textAlignment: "center"


    /*    BUTTON SIGNALS    */

    // Clicked Signal
    signal clicked()


    /*    INDICATOR ICON    */
    Image {
        id: indicatorIcon

        source: root.isDarkTheme ? root.iconLightSource : root.iconDarkSource

        // Size
        width: 15
        height: 15
        sourceSize.width: 15
        sourceSize.height: 15

        // Visibility
        opacity: root.currentTrackFeature ? 1.0 : 0

        // Position
        anchors.verticalCenter: body.verticalCenter
        anchors.horizontalCenter: (root.textAlignment === "center" ? parent.horizontalCenter : undefined)
        anchors.left: (root.textAlignment === "left" ? parent.left : undefined)
        // Add a margin if left aligned
        anchors.leftMargin: (root.textAlignment === "left" ? 20 : 0)

        visible: root.isButtonWithIcon

        // Layer
        z: 1
    }

    /*    BODY    */
    Rectangle {
        id: body

        // Size
        width: root.width
        height: root.height

        // Color
        color: root.buttonColorDefault

        // Radius
        radius: 7

        /*    BODY TEXT    */
        Text {
            id: text

            // Position
            anchors.verticalCenter: body.verticalCenter
            anchors.horizontalCenter: (root.textAlignment === "center" ? parent.horizontalCenter : undefined)
            anchors.left: (root.textAlignment === "left" ? parent.left : undefined)
            // Add a margin if left aligned
            anchors.leftMargin: (root.isButtonWithIcon ? (root.textAlignment === "left" ? 50 : 0) : (root.textAlignment === "left" ? 20 : 0))

            // Text
            text: root.text
            font.pointSize: root.textSize

            // Color
            color: root.textColorDefault
        }
    }

    /*    INTERACTIONS    */

    MouseArea {
        id: mouseArea

        // Size
        anchors.fill: root

        // General
        hoverEnabled: true

        /*
        Change cursor shape when hovering
        */
        cursorShape: Qt.PointingHandCursor

        // Pressed Event
        onPressed: {
            /*
            If Pressed, then Change Button Body Color
            */
            body.color = root.buttonColorHover

            /*
            If Pressed, then Invoke Custom Click Event
            */
            root.clicked()
        }

        // Entered Event
        onEntered: {
            /*
            If Entered, then Change Button Body Color
            */
            body.color = root.buttonColorHover
        }

        // Exited Event
        onExited: {
            /*
            If Exited, then Change Button Body Color
            */
            body.color = root.buttonColorDefault
        }
    }



}
