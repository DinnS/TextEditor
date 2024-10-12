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
    property bool isButtonWithIcon: false


    /*    THEME SWITCHER SIZE    */

    // Window Info for MouseArea
    property int windowWidth: 640
    property int windowHeight: 480

    // Body Size
    readonly property int bodyWidth: root.isButtonWithIcon ? 225 : 125

    // Item Size
    property int itemHeight: 50
    property int itemSpacing: 10


    /*    THEME SWITCHER ITEM TEXT    */

    // Item Button Text Setup
    readonly property int itemTextSize: 12
    readonly property string fontFamily: "Trebuchet MS"


    /*    THEME SWITCHER GENERAL    */

    // General Visibility
    property bool generalVisibility: false

    // Model Of Items
    property var menuItems: []


    /*    THEME SWITCHER COLORS    */

    // Body Color
    property color bodyColor: root.isDarkTheme ? themeColors.darkMenuDropdown : themeColors.lightMenuDropdown
    property color itemColor: root.isDarkTheme ? themeColors.darkButtonDefault : themeColors.lightButtonDefault
    property color itemColorHover: root.isDarkTheme ? themeColors.darkButtonHover : themeColors.lightButtonHover

    // Item Text Color
    property color itemTextColorDefault: root.isDarkTheme ? themeColors.darkTextDefault : themeColors.lightTextDefault


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

        // Visibility
        visible: root.generalVisibility

        // Size
        width: root.bodyWidth
        height: (bodyColumn.children.length - 1) * root.itemHeight

        // Color
        color: root.bodyColor

        // Radius
        bottomLeftRadius: 12
        bottomRightRadius: 12

        /*    ITEM CONTAINER    */
        Column {
            id: bodyColumn

            // Column Size
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
                    fontFamily: root.fontFamily

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

                    isBorderColorAnimation: modelData.isBorderColorAnimationReference ? true : false

                    currentTrackFeature: (modelData.isTextWrapReference ? true : modelData.isBorderColorAnimationReference ? true : false)

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
