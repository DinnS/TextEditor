import QtQuick
import QtQuick.Dialogs
import org.din.backend 1.0

// Menu Bar
Item {
    id: root

    // General
    // For the dropdown outside the mouse area
    property int windowWidth: 640
    property int windowHeight: 480

    // Reference to the Text Editor
    property Item textEditor

    // Reference to the Window Title
    property string windowTitleReference: "Text Editor - Untitled"

    // Body Size
    property int bodyWidth: root.width
    property int bodyHeight: root.height

    // Body Color
    property color bodyColorDefault: "#1a2127"

    // Item Size
    readonly property int itemWidth: 80
    readonly property int itemHeight: root.bodyHeight

    // For fix subitem position x
    readonly property int subitemXFix: 4

    // Item Color
    readonly property color itemDefaultColor: "#1a2127"
    readonly property color itemHoverColor: "#4a4a4a"

    // Text Color
    readonly property color textColor: "#ffffff"

    // Text Setup
    readonly property int textSize: 11

    // Ensuring this is in top
    z: 1

    // Functions
    // Function to close all dropdown menu
    function closeAllDropdowns(currentDropdown) {
        if (currentDropdown !== dropdownMenuFile) {
            dropdownMenuFile.generalVisibility = false
        }
        if (currentDropdown !== dropdownMenuEdit) {
            dropdownMenuEdit.generalVisibility = false
        }
    }

    // Body
    Rectangle {
        id: body

        // Body Size
        width: root.bodyWidth
        height: root.bodyHeight

        // Body Color
        color: root.bodyColorDefault

        // Body Row
        Row {
            id: bodyRow

            // Body Row Position
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            spacing: 10

            // Body Item File
            CustomButton {
                id: bodyItemFile

                // Body Item Size
                width: root.itemWidth
                height: root.itemHeight

                // Body Item Color
                bodyColorDefault: root.itemDefaultColor
                bodyColorHover: root.itemHoverColor

                // Body Item Text Color
                textColorDefault: "#ffffff"
                textColorHover: "#ffffff"
                textColorPressed: "#ffffff"

                // Body Item Text
                text: "File"
                textSize: root.textSize

                // Body Item Clicked Event
                onClicked: {
                    // Close all dropdowns before opening the current one
                    root.closeAllDropdowns(dropdownMenuFile)

                    // If Clicked, than Toggle Dropdown
                    dropdownMenuFile.generalVisibility = !dropdownMenuFile.generalVisibility
                }
            }

            // Body Item Edit
            CustomButton {
                id: bodyItemEdit

                // Body Item Size
                width: root.itemWidth
                height: root.itemHeight

                // Body Item Color
                bodyColorDefault: root.itemDefaultColor
                bodyColorHover: root.itemHoverColor

                textColorDefault: "#ffffff"
                textColorHover: "#ffffff"
                textColorPressed: "#ffffff"

                // Body Item Text
                text: "Edit"
                textSize: root.textSize

                // Body Item Clicked Event
                onClicked: {
                    // Close all dropdowns before opening the current one
                    root.closeAllDropdowns(dropdownMenuEdit)

                    // If Clicked, than Toggle Dropdown
                    dropdownMenuEdit.generalVisibility = !dropdownMenuEdit.generalVisibility
                }
            }

        }
    }

    // Dropdown Menu File
    CustomDropdownMenu {
        id: dropdownMenuFile

        // Dropdown Mouse Area Size
        windowWidth: root.windowWidth
        windowHeight: root.windowHeight - root.height

        // Dropdown Menu Position
        x: bodyRow.spacing + subitemXFix
        y: root.bodyHeight

        // Dropdown Menu Items
        itemSpacing: bodyRow.spacing
        menuItems: [
            {
                text: "New",
                action: function() {
                    textEditor.clear()
                    root.windowTitleReference = "Text Editor - Untitled"
                },
                enabled: true
            },
            {
                text: "Open...",
                action: function() {
                    openDialog.open()
                },
                enabled: true
            },
            {
                text: "Save",
                action: function() {
                    backend.fileContent = textEditor.text
                },
                enabled: backend.filePath !== ''
            },
            {
                text: "Save As...",
                action: function() {
                    saveDialog.open()
                },
                enabled: true
            },
            {
                text: "Quit",
                action: function() {
                    Qt.quit()
                },
                enabled: true
            },
        ]
    }

    // Dropdown Menu Edit
    CustomDropdownMenu {
        id: dropdownMenuEdit

        // Dropdown Menu Size
        windowWidth: root.windowWidth
        windowHeight: root.windowHeight - root.height

        // Dropdown Menu Position
        x: root.itemWidth + (bodyRow.spacing * 2) + subitemXFix
        y: root.bodyHeight

        // Dropdown Menu Items
        menuItems: [
            {
                text: "Cut",
                action: function() {
                    textEditor.cut()
                },
                enabled: true
            },
            {
                text: "Copy",
                action: function() {
                    textEditor.copy()
                },
                enabled: true
            },
            {
                text: "Paste",
                action: function() {
                    textEditor.paste()
                },
                enabled: true
            }
        ]

    }

    // Connecting to the backend
    Backend {
        id: backend
        // Backend Debug
        // onFilePathChanged: console.log("Path:", filePath)
        // onFileContentChanged: console.log("Data:", fileContent)
        // Dynamic update the window title
        onFilePathChanged: {
            if (filePath !== "") {
                // Extract the file name
                var fileName = filePath.split("/").pop().split(".")[0];
                // Update the title
                root.windowTitleReference = "Text Editor - " + fileName;
            } else {
                // Update the title when no file is open
                root.windowTitleReference = "Text Editor - Untitled";
            }
        }
    }

    // File Dialogs Popups
    FileDialog {
        id: openDialog
        title: "Please select a file to open"
        fileMode: FileDialog.OpenFile
        nameFilters: ["Text Files (*.txt)"]

        onAccepted: {
            backend.filePath = openDialog.selectedFile
            textEditor.text = backend.fileContent
        }
    }

    FileDialog {
        id: saveDialog
        title: "Please select a file to save"
        fileMode: FileDialog.SaveFile
        // "All Files (*)"
        nameFilters: ["Text Files (*.txt)"]

        onAccepted: {
            backend.filePath = saveDialog.selectedFile
            backend.fileContent = textEditor.text
        }
    }

}


