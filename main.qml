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
    readonly property bool editorTextWrapOn: true

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
    ScrollView {
        id: scrollView

        // Text Editor Scroll Size
        width: root.width
        height: root.height

        // Text Editor Scroll Position

        anchors.top: parent.top
        anchors.topMargin: root.menuBarHeight - 5
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom


        // Text Editor Scroll Bar Policy
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AsNeeded

        // Text Editor Area
        TextArea {
            id: editor

            // Text Editor Area Size
            width: root.width
            height: root.height

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
            // Enable text wrapping to break anywhere
            wrapMode: root.editorTextWrapOn ? TextEdit.WrapAnywhere : TextEdit.NoWrap
            // !Enable focus and mouse interaction
            focus: true
            selectByMouse:  true
            // !Allow persistent selection for copy-paste
            persistentSelection: true

            // Text Editor Background
            background: Rectangle {
                id: editorBackground

                // Text Editor Background Color
                color: editorBackgroundColor
            }

        }
    }

}
