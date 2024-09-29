import QtQuick

// Dropdown Menu
Item {
    id: root

    // General Visibility
    property bool generalVisibility: false

    // Window Info for MouseArea
    property int windowWidth: 640
    property int windowHeight: 480

    // Model Of Items
    property var menuItems: []

    // Body Size
    readonly property int bodyWidth: 125

    // Body Color
    readonly property color bodyColor: "#2b2b2b"

    // Item Size
    property int itemHeight: 50
    property int itemSpacing: 10

    // Item Text Setup
    property int itemTextSize: 12

    // Outside Mouse Area To Detect Click From Outside
    MouseArea {
        id: outsideMouseArea

        // Outside Mouse Area Size
        //anchors.fill: root
        width: root.windowWidth
        height: root.windowHeight

        // Outside Mouse Area Position
        x: -root.itemSpacing
        // Ensuring this is below dropdown
        z: -1

        // Outside Mouse Area Visibility
        visible: root.generalVisibility

        // Outside Mouse Area Click Event
        onClicked: {
            // If click on the outside, than exit from dropdown
            root.generalVisibility = false
        }
    }

    // Body
    Rectangle {
        id: body

        // Body Visibility
        visible: root.generalVisibility

        // Body Size
        width: root.bodyWidth
        height: (bodyColumn.children.length - 1) * root.itemHeight

        // Body Color
        color: root.bodyColor

        // Body Radius
        radius: 10

        // Body Column
        Column {
            id: bodyColumn

            // Body Column Size
            anchors.fill: body

            // Body Item Repeter
            Repeater {
                model: root.menuItems

                // Body Item
                CustomButton {
                    id: bodyItemNew

                    // Body Item Size
                    width: body.width
                    height: root.itemHeight

                    // Body Item Color
                    bodyColorDefault: "#00000000"
                    bodyColorHover: modelData.enabled ? "#383838" : bodyColorDefault

                    textColorDefault: modelData.enabled ? "#ffffff" : "#4c4c4c"
                    textColorHover: modelData.enabled ? "#ffffff" : "#4c4c4c"
                    textColorPressed: modelData.enabled ? "#ffffff" : "#4c4c4c"

                    // Body Item Dynamic Text
                    text: modelData.text
                    textSize: root.itemTextSize
                    textAlignment: "left"

                    // Body Item Clicked Event
                    onClicked: {
                        // Call the action function
                        modelData.enabled ? modelData.action() : null

                        // If Clicked, than Close Dropdown
                        root.generalVisibility = modelData.enabled ? false : true
                    }
                }

            }
        }
    }

}
