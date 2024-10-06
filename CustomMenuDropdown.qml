import QtQuick
import QtQuick.Effects

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

    // Theme Colors
    CustomColors {
        id: themeColors
    }

    // Body Size
    readonly property int bodyWidth: 125

    // Body Color
    readonly property color bodyColor: isDarkThemeReference ? themeColors.darkMenuDropdown : themeColors.lightMenuDropdown

    readonly property color itemColorHover: isDarkThemeReference ? themeColors.darkMenuHover : themeColors.lightMenuHover

    // Item Size
    property int itemHeight: 50
    property int itemSpacing: 10

    // Item Text Color
    readonly property color itemTextColorDefault: isDarkThemeReference ? themeColors.darkTextDefault : themeColors.lightTextDefault

    // Item Text Setup
    property int itemTextSize: 12

    // Reference to Is Dark Theme
    property bool isDarkThemeReference

    // Outside Mouse Area To Detect Click From Outside
    MouseArea {
        id: outsideMouseArea

        // Outside Mouse Area Size
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
        bottomLeftRadius: 12
        bottomRightRadius: 12

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
                    buttonColorDefault: "#00000000"
                    buttonColorHover: modelData.enabled ? root.itemColorHover : buttonColorDefault

                    textColorDefault: modelData.enabled ? itemTextColorDefault : "#4c4c4c"
                    textColorHover: modelData.enabled ? itemTextColorDefault : "#4c4c4c"
                    textColorPressed: modelData.enabled ? itemTextColorDefault : "#4c4c4c"

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
