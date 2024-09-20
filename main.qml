import QtQuick
import QtQuick.Window
import QtQuick.Controls
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
    property int menuBarWidth: 100

    // Connecting to the backend
    Backend {
        id: backend
        onFilePathChanged: console.log("Path:", filePath)
        onFileContentChanged: console.log("Data:", fileContent)
    }

    // File Dialogs Popups
    FileDialog {
        id: openDialog
        title: "Please select a file to open"
        fileMode: FileDialog.OpenFile
        nameFilters: ["Text Files (*.txt)"]

        onAccepted: {
            backend.filePath = openDialog.selectedFile
            editor.text = backend.fileContent
        }
    }

    FileDialog {
        id: saveDialog
        title: "Please select a file to save"
        fileMode: FileDialog.SaveFile
        nameFilters: ["Text Files (*.txt)"] // "All Files (*)"

        onAccepted: {
            backend.filePath = saveDialog.selectedFile
            backend.fileContent = editor.text
        }
    }

    // File Menu Options
    Action {
        id: actionNew
        text: qsTr("&New...")

        onTriggered: editor.clear()
    }

    Action {
        id: actionOpen
        text: qsTr("&Open...")

        onTriggered: openDialog.open()
    }

    Action {
        id: actionSave
        text: qsTr("&Save")

        enabled: backend.filePath !== ''


        onTriggered: {
            backend.fileContent = editor.text
        }
    }

    Action {
        id: actionSaveAs
        text: qsTr("&Save As...")

        onTriggered: saveDialog.open()
    }

    Action {
        id: actionQuit
        text: qsTr("&Quit")

        onTriggered: Qt.quit()
    }

    // Edit Menu Options
    Action {
        id: actionCopy
        text: qsTr("&Copy...")

        onTriggered: editor.copy()
    }

    Action {
        id: actionCut
        text: qsTr("&Cut...")

        onTriggered: editor.cut()
    }

    Action {
        id: actionPaste
        text: qsTr("&Paste...")

        onTriggered: editor.paste()
    }

    menuBar: MenuBar {
        Menu {
            id: menuFile
            title: qsTr("&File")
            width: root.menuBarWidth

            MenuItem {
                action: actionNew
                display: AbstractButton.TextOnly
            }

            MenuItem {
                action: actionOpen
                display: AbstractButton.TextOnly
            }

            MenuItem {
                action: actionSave
                display: AbstractButton.TextOnly
            }

            MenuItem {
                action: actionSaveAs
            }

            MenuItem {
                action: actionQuit
            }

        }
        Menu {
            id: menuEdit
            title: qsTr("&Edit")
            width: root.menuBarWidth

            MenuItem {
                action: actionCut
                display: AbstractButton.TextOnly
            }

            MenuItem {
                action: actionCopy
                display: AbstractButton.TextOnly
            }

            MenuItem {
                action: actionPaste
                display: AbstractButton.TextOnly
            }
        }
        Menu {
            id: menuHelp
            title: qsTr("&Help")
            width: root.menuBarWidth

            MenuItem {
                // action:
                // text: qsTr("&About")
            }
        }
    }

    ScrollView {
        anchors.fill: parent

        // Scroll bar policy settings
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AsNeeded


        TextArea {
            id: editor

            // Initial placeholder text
            text: "Hello World"

            // Enable text wrapping to break anywhere
            wrapMode: TextEdit.WrapAnywhere

            // !Enable focus and mouse interaction
            focus: true
            selectByMouse:  true

            // !Allow persistent selection for copy-paste
            persistentSelection: true
        }
    }

}
