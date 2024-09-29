import QtQuick
import QtQuick.Controls.Fusion
import QtQuick.Window

// Main Window
ApplicationWindow {
    id: root

    // Window Size
    width: 640
    height: 480

    // Window Setup
    title: qsTr("Text Editor")
    visible: true

    // Menu Bar
    readonly property int menuBarWidth: root.width
    readonly property int menuBarHeight: 40

    // Editor Background
    readonly property color editorBackgroundColor: "#272727"

    // Menu Bar
    CustomMenuBar {
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
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.topMargin: root.menuBarHeight

            // Text Editor Scroll Bar Policy
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
            ScrollBar.vertical.policy: ScrollBar.AsNeeded

            // Text Editor Area
            TextArea {
                id: editor

                // Text Editor Area Position
                topPadding: 10
                bottomPadding: 15
                leftPadding: 25
                rightPadding: 25

                // Text Editor Area Size
                width: root.width
                height: root.height

                // Text Editor Area Text
                text: ""
                font.pointSize: 14
                color: "#ffffff"

                // Text Editor Area Setups
                // Enable text wrapping to break anywhere
                wrapMode: TextEdit.WrapAnywhere
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
