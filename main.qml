import QtQuick
import QtQuick.Controls.Fusion
import QtQuick.Window
import org.din.backend 1.0

/*    MAIN WINDOW    */
ApplicationWindow {
    id: window

    /*    WINDOW PROPERTIES    */

    // Window Size
    width: 640
    height: 480

    // Window Setup
    title: menuBar.windowTitleReference
    visible: true

    /*    THEME COLORS    */

    /*
    Provide Access to the Colors Library
    !!!Not the best approach
    */
    CustomColors {
        id: themeColors
    }


    /*    MENU BAR PROPERTIES    */

    // Menu Bar Size
    readonly property int menuBarWidth: window.width
    readonly property int menuBarHeight: 51


    /*    EDITOR PROPERTIES    */

    // Editor Background Color
    readonly property color editorBackgroundColor: menuBar.isDarkTheme ? themeColors.darkEditor : themeColors.lightEditor

    // Editor Text Color
    readonly property color editorTextColorDefault: menuBar.isDarkTheme ? themeColors.darkTextDefault : themeColors.lightTextDefault
    readonly property color editorTextColorSelected: menuBar.isDarkTheme ? themeColors.darkTextSelected : themeColors.lightTextSelected
    readonly property color editorCursorTextColor: menuBar.isDarkTheme ? themeColors.darkCursor : themeColors.lightCursor

    // Editor Text Size
    readonly property int editorTextSize: 14

    // Editor Text Wrap Mode
    readonly property bool editorTextWrapOn: menuBar.isTextWrap

    // Editor Scroll Bar Appearance
    readonly property int scrollBarSize: 9
    readonly property int scrollBarRadius: 15
    readonly property color scrollBarColor: menuBar.isDarkTheme ? themeColors.darkScrollBar : themeColors.lightScrollBar

    /*    MENU BAR    */
    CustomMenuBar {
        id: menuBar
        // General
        /*
        For Mouse Area to exit the Dropdown
        */
        windowWidth: window.width
        windowHeight: window.height

        // Reference to the Text Editor
        textEditor: editor

        // Size
        bodyWidth: window.menuBarWidth
        bodyHeight: window.menuBarHeight
    }


    /*    TEXT EDITOR    */
    Flickable  {
        id: scrollView
        clip: true

        // Properties For Fixing Position
        property int editorWidthFix: 45
        property int editorHeightFix: 70

        // Scroll Size
        contentWidth: editor.contentWidth + scrollView.editorWidthFix
        contentHeight: editor.contentHeight + scrollView.editorHeightFix

        // Scroll Signal When Content Width Change
        onContentWidthChanged: {
            // Auto scroll when the text goes beyond the screen
            scrollView.contentX = (scrollView.contentWidth >= window.width) ? (scrollView.contentWidth - scrollView.width) : scrollView.contentX
            // Show scrollbar if necessary
            scrollBarHorizontal.policy = (scrollView.contentWidth >= window.width) ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
        }

        // Scroll Signal When Content Height Change
        onContentHeightChanged: {
            // Auto scroll when the text goes beyond the screen
            scrollView.contentY = scrollView.contentHeight >= (window.height) ? scrollView.contentHeight - scrollView.height : scrollView.contentY
            // Show scrollbar if necessary
            scrollBarVertical.policy = scrollView.contentHeight >= (window.height) ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
        }

        // Scroll Position
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.topMargin: window.menuBarHeight


        // Text Editor Setup
        /*
        Off bounce animation when scrolling
        */
        boundsBehavior: Flickable.StopAtBounds

        // Text Editor Vertical ScrollBar
        ScrollBar.vertical: ScrollBar {
            id : scrollBarVertical

            // Vertical Scroll Bar Size
            width: window.scrollBarSize
            height: scrollView.height

            // Verical Scroll Bar Position
            anchors.right: parent.right

            // Vertical Scroll Bar Appearance
            contentItem: Item {
                Rectangle {
                    // Scroll Bar Size
                    anchors.fill: parent

                    // Scroll Bar Color
                    color: window.scrollBarColor

                    // Scroll Bar Rounding
                    radius: window.scrollBarRadius
                }
            }
        }

        // Text Editor horizontal ScrollBar
        ScrollBar.horizontal: ScrollBar {
            id : scrollBarHorizontal

            // Horizontal Scroll Bar Size
            width: scrollView.width
            height: window.scrollBarSize

            // Horizontal Scroll Bar Position
            anchors.bottom: parent.bottom

            // Horizontal Scroll Bar Appearance
            contentItem: Item {
                Rectangle {
                    // Scroll Bar Size
                    anchors.fill: parent

                    // Scroll Bar Color
                    color: window.scrollBarColor

                    // Scroll Bar Rounding
                    radius: window.scrollBarRadius
                }
            }
        }

        /*    TEXT EDITOR CONTENT    */
        TextArea {
            id: editor

            // Text Editor Area Size
            width:  window.editorTextWrapOn ? window.width : editor.contentWidth + window.width
            height: editor.contentHeight + window.height

            // Text Editor Area Position
            topPadding: 20
            bottomPadding: 15
            leftPadding: 25
            rightPadding: 25

            // Text Editor Area Text
            text: ""
            font.pointSize: window.editorTextSize

            // Text Editor Area Text Color
            color: window.editorTextColorDefault
            selectionColor: window.editorTextColorSelected

            // Text Editor Area Text Cursor
            cursorDelegate: Rectangle {
                id: cursor

                // Text Cursor Size
                width: editor.cursorRectangle.width

                // Text Cursor Color
                color: window.editorCursorTextColor

                // Text Cursor Setup
                visible: false

                // Text Cursor Animation
                SequentialAnimation {
                    loops: Animation.Infinite
                    running: editor.cursorVisible

                    PropertyAction {
                        target: cursor
                        property: 'visible'
                        value: true
                    }

                    PauseAnimation {
                        duration: 600
                    }

                    PropertyAction {
                        target: cursor
                        property: 'visible'
                        value: false
                    }

                    PauseAnimation {
                        duration: 600
                    }
                }
            }

            // Text Editor Area Setups
            wrapMode: window.editorTextWrapOn ? TextEdit.WrapAnywhere : TextEdit.NoWrap

            // !Enable focus and mouse interaction
            focus: true
            selectByMouse:  true
            // !Allow persistent selection for copy-paste
            persistentSelection: true

            // Text Editor Background
            background: Rectangle {
                id: editorBackground

                // Background Size
                width: editor.width
                height: editor.height

                // Background Color
                color: window.editorBackgroundColor
            }
        }
    }

}
