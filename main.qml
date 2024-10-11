import QtQuick
import QtQuick.Controls.Fusion
import QtQuick.Window
import org.din.backend 1.0

// Main Window
ApplicationWindow {
    id: root

    // Window Size
    width: 640
    height: 480

    // Window Setup
    title: menuBar.windowTitleReference
    visible: true

    // Theme Colors
    CustomColors {
        id: themeColors
    }

    // Menu Bar
    readonly property int menuBarWidth: root.width
    readonly property int menuBarHeight: 50

    // Editor Background
    readonly property color editorBackgroundColor: menuBar.isDarkTheme ? themeColors.darkEditor : themeColors.lightEditor

    // Editor Text Color
    readonly property color editorTextColor: menuBar.isDarkTheme ? themeColors.darkTextDefault : themeColors.lightTextDefault
    readonly property color editorCursorTextColor: menuBar.isDarkTheme ? themeColors.darkCursor : themeColors.lightCursor

    // Editor Text Size
    readonly property int editorTextSize: 14

    // Editor Text Wrap Mode
    readonly property bool editorTextWrapOn: false

    // Scroll Bar Appearance
    readonly property int scrollBarSize: 9
    readonly property int scrollBarRadius: 15
    readonly property color scrollBarColor: menuBar.isDarkTheme ? themeColors.darkScrollBar : themeColors.lightScrollBar

    // Menu Bar
    CustomMenuBar {
        id: menuBar
        // General
        // For the dropdown outside the mouse area
        windowWidth: root.width
        windowHeight: root.height

        // Reference to the Text Editor
        textEditor: editor

        // Menu Bar Size
        bodyWidth: root.menuBarWidth
        bodyHeight: root.menuBarHeight
    }

    // Text Editor
    Flickable  {
        id: scrollView
        clip: true

        // Text Editor Properties For Fixing Position
        property int editorWidthFix: 45
        property int editorHeightFix: 70

        // Text Editor Scroll Size
        contentWidth: editor.contentWidth + editorWidthFix
        contentHeight: editor.contentHeight + editorHeightFix

        // Text Editor Scroll Signal When Content Width Change
        onContentWidthChanged: {
            // Auto scroll when the text goes beyond the screen
            scrollView.contentX = (scrollView.contentWidth >= root.width) ? (scrollView.contentWidth - scrollView.width) : scrollView.contentX
            // Show scrollbar if necessary
            scrollBarHorizontal.policy = (scrollView.contentWidth >= root.width) ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
        }

        // Text Editor Scroll Signal When Content Height Change
        onContentHeightChanged: {
            // Auto scroll when the text goes beyond the screen
            scrollView.contentY = scrollView.contentHeight >= (root.height) ? scrollView.contentHeight - scrollView.height : scrollView.contentY
            // Show scrollbar if necessary
            scrollBarVertical.policy = scrollView.contentHeight >= (root.height) ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
        }

        // Text Editor Scroll Position
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.topMargin: root.menuBarHeight


        // Text Editor Setup
        // Off bounce animation
        boundsBehavior: Flickable.StopAtBounds

        // Text Editor Vertical ScrollBar
        ScrollBar.vertical: ScrollBar {
            id : scrollBarVertical

            // Vertical Scroll Bar Size
            width: root.scrollBarSize
            height: scrollView.height

            // Verical Scroll Bar Position
            anchors.right: parent.right

            // Vertical Scroll Bar Appearance
            contentItem: Item {
                Rectangle {
                    // Scroll Bar Size
                    anchors.fill: parent

                    // Scroll Bar Color
                    color: root.scrollBarColor

                    // Scroll Bar Rounding
                    radius: root.scrollBarRadius
                }
            }
        }

        // Text Editor horizontal ScrollBar
        ScrollBar.horizontal: ScrollBar {
            id : scrollBarHorizontal

            // Horizontal Scroll Bar Size
            width: scrollView.width
            height: root.scrollBarSize

            // Horizontal Scroll Bar Position
            anchors.bottom: parent.bottom

            // Horizontal Scroll Bar Appearance
            contentItem: Item {
                Rectangle {
                    // Scroll Bar Size
                    anchors.fill: parent

                    // Scroll Bar Color
                    color: root.scrollBarColor

                    // Scroll Bar Rounding
                    radius: root.scrollBarRadius
                }
            }
        }

        // Text Editor Area
        TextArea {
            id: editor

            // Text Editor Area Size
            width:  root.editorTextWrapOn ? root.width : editor.contentWidth + root.width
            height: editor.contentHeight + root.height

            // Text Editor Area Position
            topPadding: 20
            bottomPadding: 15
            leftPadding: 25
            rightPadding: 25

            // Text Editor Area Text
            text: ""
            font.pointSize: root.editorTextSize

            // Text Editor Area Text Color
            color: root.editorTextColor

            // Text Editor Area Text Cursor
            cursorDelegate: Rectangle {
                id: cursor

                // Text Cursor Size
                width: editor.cursorRectangle.width

                // Text Cursor Color
                color: root.editorCursorTextColor

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
            wrapMode: root.editorTextWrapOn ? TextEdit.WrapAnywhere : TextEdit.NoWrap

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
                color: root.editorBackgroundColor
            }

        }
    }

}
