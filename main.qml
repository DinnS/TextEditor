import QtQuick
import QtQuick.Controls.Fusion
import QtQuick.Window
import QtQuick.Dialogs
import org.din.backend 1.0

// Main Window
ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Text Editor")

    // Custom property
    readonly property int menuBarWidth: root.width
    readonly property int menuBarHeight: 40

    readonly property color backgroundEditorColor: "#272727"
    readonly property color backgroundMenuBarColor: "#1a2126"

    // Connecting to the backend
    Backend {
        id: backend
        onFilePathChanged: console.log("Path:", filePath)
        onFileContentChanged: console.log("Data:", fileContent)
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

    // File Menu Options
    // Action {
    //     id: actionNew
    //     text: qsTr("&New...")

    //     onTriggered: editor.clear()
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

    // Action {
    //     id: actionQuit
    //     text: qsTr("&Quit")

    //     onTriggered: Qt.quit()
    // }

    // // Edit Menu Options
    // Action {
    //     id: actionCopy
    //     text: qsTr("&Copy...")

    //     onTriggered: editor.copy()
    // }

    // Action {
    //     id: actionCut
    //     text: qsTr("&Cut...")

    //     onTriggered: editor.cut()
    // }

    // Action {
    //     id: actionPaste
    //     text: qsTr("&Paste...")

    //     onTriggered: editor.paste()
    // }

    CustomMenuBar {
        // General Setup
        windowHeight: root.height
        textEditor: editor

        // Size
        width: menuBarWidth
        bodyHeight: root.menuBarHeight
    }

    ScrollView {
        id: scrollView

        // Size
        width: root.width
        height: root.height

        // Position
        y: root.menuBarHeight

        // Scroll bar policy settings
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AsNeeded

        TextArea {
            id: editor

            // Position
            y: parent.y

            // Text setup
            text: ""
            color: "#ffffff"
            font.pointSize: 14

            // Enable text wrapping to break anywhere
            wrapMode: TextEdit.WrapAnywhere

            // !Enable focus and mouse interaction
            focus: true
            selectByMouse:  true

            // !Allow persistent selection for copy-paste
            persistentSelection: true

            // Background
            background: Rectangle {
                id: backgroundEditor

                // Position
                y: editor.y

                // Background color
                color: backgroundEditorColor
            }
        }
    }

}
