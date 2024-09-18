import QtQuick 2.15
import QtQuick.Window 2.15
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
        icon.color: "transparent"
        icon.source: "qrc:/icons/icons/oNew.png"

        onTriggered: editor.clear()
    }

    Action {
        id: actionOpen
        text: qsTr("&Open...")
        icon.color: "transparent"
        icon.source: "qrc:/icons/icons/oOpen.png"

        onTriggered: openDialog.open()
    }

    Action {
        id: actionSave
        text: qsTr("&Save...")
        icon.color: "transparent"
        icon.source: "qrc:/icons/icons/oSave.png"

        onTriggered: saveDialog.open()
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
        icon.color: "transparent"
        icon.source: "qrc:/icons/icons/oCopy.png"
        onTriggered: editor.copy()
    }

    Action {
        id: actionCut
        text: qsTr("&Cut...")
        icon.color: "transparent"
        icon.source: "qrc:/icons/icons/oCut.png"
        onTriggered: editor.cut()
    }

    Action {
        id: actionPaste
        text: qsTr("&Paste...")
        icon.color: "transparent"
        icon.source: "qrc:/icons/icons/oPaste.png"
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


    header: ToolBar {
        Row {
            ToolButton {
                action: actionNew
                display: AbstractButton.IconOnly;
            }

            ToolButton {
                action: actionOpen
                display: AbstractButton.IconOnly;
            }

            ToolButton {
                action: actionSave
                display: AbstractButton.IconOnly;
            }

            ToolButton {
                action: actionCopy
                display: AbstractButton.IconOnly;
            }

            ToolButton {
                action: actionCut
                display: AbstractButton.IconOnly;
            }

            ToolButton {
                action: actionPaste
                display: AbstractButton.IconOnly;
            }
        }
    }

    ScrollView {
        anchors.fill: parent

        // Policy for Scrool Bar
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AsNeeded

        TextArea {
            id: editor

            // Placeholder text
            text: "Hello World"

            // Wrap Text
            wrapMode: TextEdit.WrapAnywhere

            // !Mouse Settings
            focus: true
            selectByMouse:  true

            // !Allowing copy and paste
            persistentSelection: true
        }
    }

}
