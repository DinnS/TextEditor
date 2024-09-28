import QtQuick

// Menu Bar
Item {
    id: root

    // General
    // For the dropdown outside the mouse area
    property int windowHeight: 300

    // Reference to the Text Editor
    property Item textEditor

    // Body Size
    property int bodyHeight: root.height

    // Body Color
    property color bodyColorDefault: "#1a2127"

    // Item Size
    readonly property int itemWidth: 80
    readonly property int itemHeight: root.bodyHeight

    // Item Color
    readonly property color itemDefaultColor: "#1a2127"
    readonly property color itemHoverColor: "#4a4a4a"

    // Text Color
    readonly property color textColor: "#ffffff"

    // Text Setup
    readonly property int textSize: 11

    // Ensuring this is in top
    z: 1

    // Body
    Rectangle {
        id: body

        // Body Size
        width: root.width
        height: root.bodyHeight

        // Body Color
        color: root.bodyColorDefault

        // Body Row
        Row {
            id: bodyRow

            // Body Row Position
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            spacing: 10

            // Body Item File
            CustomButton {
                id: bodyItemFile

                // Body Item Size
                width: root.itemWidth
                height: root.itemHeight

                // Body Item Color
                bodyColorDefault: root.itemDefaultColor
                bodyColorHover: root.itemHoverColor

                textColorDefault: "#ffffff"
                textColorHover: "#ffffff"
                textColorPressed: "#ffffff"

                // Body Item Text
                text: "File"
                textSize: root.textSize

                // Body Item Clicked Event
                onClicked: {
                    // If Clicked, than Toggle Dropdown
                    dropdownMenuFile.generalVisibility = !dropdownMenuFile.generalVisibility
                }
            }

        }
    }

    // Dropdown Menu File
    CustomDropdownMenu {
        id: dropdownMenuFile

        // Dropdown Menu Size
        width: root.width
        height: root.windowHeight - root.height

        // Dropdown Menu Position
        y: root.bodyHeight

        // Dropdown Menu General
        textEditor: root.textEditor

        // Dropdown Menu Items
        menuItems: [
            {text: "New", action: function() { textEditor.clear(); console.log("New clicked, text cleared."); }}
        ]
    }
}
