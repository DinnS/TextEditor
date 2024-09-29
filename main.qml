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
        y: root.menuBarHeight

        // Text Editor Scroll Bar Policy
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AsNeeded

        // Text Editor Area
        TextArea {
            id: editor

            // Text Editor Area Position
            y: parent.y

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

                // Text Editor Background Position
                y: editor.y

                // Text Editor Background Color
                color: editorBackgroundColor
            }
        }
    }
}


// File Dialogs Popups
// FileDialog {
//     id: openDialog
//     title: "Please select a file to open"
//     fileMode: FileDialog.OpenFile
//     nameFilters: ["Text Files (*.txt)"]

//     onAccepted: {
//         backend.filePath = openDialog.selectedFile
//         editor.text = backend.fileContent
//     }
// }

// FileDialog {
//     id: saveDialog
//     title: "Please select a file to save"
//     fileMode: FileDialog.SaveFile
//     nameFilters: ["Text Files (*.txt)"] // "All Files (*)"

//     onAccepted: {
//         backend.filePath = saveDialog.selectedFile
//         backend.fileContent = editor.text
//     }
// }


// Action {
//     id: actionOpen
//     text: qsTr("&Open...")

//     onTriggered: openDialog.open()
// }

// Action {
//     id: actionSave
//     text: qsTr("&Save")

//     enabled: backend.filePath !== ''


//     onTriggered: {
//         backend.fileContent = editor.text
//     }
// }

// Action {
//     id: actionSaveAs
//     text: qsTr("&Save As...")

//     onTriggered: saveDialog.open()
// }


