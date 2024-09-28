import QtQuick

// Button
Item {
    id: root

    // Body Color
    property color bodyColorDefault: "#1a2127"
    property color bodyColorHover: "#4a4a4a"

    // Text Color
    property color textColorDefault: "#ffffff"
    property color textColorHover: "#4a4a4a"
    property color textColorPressed: "#4a4a4a"

    // Text Setup
    property string text: "Default"
    property int textSize: 12

    // Clicked Signal
    signal clicked()

    // Body
    Rectangle {
        id: body

        // Body Size
        anchors.fill: root

        // Body Color
        color: root.bodyColorDefault

        // Body Radius
        radius: 7

        // Text
        Text {
            id: text

            // Text Position
            anchors.centerIn: body

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
                body.color = root.bodyColorHover

                // If Pressed, than Invoke Custom Click Event
                root.clicked()
            }

            // Mouse Area Entered Event
            onEntered: {
                // If Entered, than Change Button Body Color
                body.color = root.bodyColorHover
            }

            // Mouse Area Exited Event
            onExited: {
                // If Exited, than Change Button Body Color
                body.color = root.bodyColorDefault
            }
        }
    }
}
