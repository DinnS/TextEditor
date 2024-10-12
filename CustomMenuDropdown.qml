import QtQuick
import QtQuick.Effects

/*    DROPDOWN MENU    */
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


    // General Visibility
    property bool generalVisibility: false

    // Window Info for MouseArea
    property int windowWidth: 640
    property int windowHeight: 480

    // Model Of Items
    property var menuItems: []

    // Body Size
    readonly property int bodyWidth: 150


    // Item Size
    property int itemHeight: 50
    property int itemSpacing: 10

    // Item Text Setup
    property int itemTextSize: 12


    /*    THEME SWITCHER COLORS    */

    // Body Color
    property color bodyColor: isDarkTheme ? themeColors.darkMenuDropdown : themeColors.lightMenuDropdown
    property color itemColor: isDarkTheme ? themeColors.darkButtonDefault : themeColors.lightButtonDefault
    property color itemColorHover: isDarkTheme ? themeColors.darkButtonHover : themeColors.lightButtonHover

    // Item Text Color
    readonly property color itemTextColorDefault: isDarkTheme ? themeColors.darkTextDefault : themeColors.lightTextDefault


    /*    INTERACTIONS    */

    /*
    Outside Mouse Area to detect clicks from Outside Dropdown
    */
    MouseArea {
        id: outsideMouseArea

        // Outside Mouse Area Size
        width: root.windowWidth * 3
        height: root.windowHeight

        // Outside Mouse Area Position
        x: -root.windowWidth
        // Ensuring this is below dropdown
        z: -1

        // Outside Mouse Area Visibility
        visible: root.generalVisibility

        // Outside Mouse Area Click Event
        onClicked: {
            // If click on the outside, then exit from dropdown
            root.generalVisibility = false
        }
    }


    /*    BODY    */
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

        /*    ITEM CONTAINER    */
        Column {
            id: bodyColumn

            // Body Column Size
            anchors.fill: body

            /*    ITEM CONTAINER    */
            Repeater {
                model: root.menuItems

                /*    ITEM    */
                delegate: CustomButton {
                    id: bodyItem

                    // Item Size
                    width: body.width
                    height: root.itemHeight

                    // Item Dynamic Text
                    text: modelData.text
                    textSize: root.itemTextSize
                    textAlignment: "left"

                    // Item Button Colors
                    buttonColorDefault: root.itemColor
                    buttonColorHover: modelData.enabled ? root.itemColorHover : root.itemColor

                    // Item Text Colors
                    textColorDefault: modelData.enabled ? root.itemTextColorDefault : "#4c4c4c"
                    textColorHover: modelData.enabled ? root.itemTextColorDefault : "#4c4c4c"
                    textColorPressed: modelData.enabled ? root.itemTextColorDefault : "#4c4c4c"

                    // Item Theme Status
                    isDarkTheme: root.isDarkTheme

                    isTextWrap: modelData.isTextWrapReference ? true : false

                    // Item Options
                    /*
                    Enable Button with Icon View
                    */
                    isButtonWithIcon: modelData.icon ? true : false

                    /*
                    If Button with Icon View On, than enable option to add icons source
                    */
                    iconLightSource: modelData.icon ? modelData.iconLightSource : ""
                    iconDarkSource: modelData.icon ? modelData.iconDarkSource : ""

                    // Item Clicked Event
                    onClicked: {
                        /*
                        Call the action function
                        */
                        modelData.enabled ? modelData.action() : null

                        /*
                        Check if that Button with Icon, if not then
                        If Clicked on button, than hide Dropdown Menu
                        */
                        if(!isButtonWithIcon) {
                            root.generalVisibility = modelData.enabled ? false : true
                        }
                    }
                }

            }
        }
    }

}
