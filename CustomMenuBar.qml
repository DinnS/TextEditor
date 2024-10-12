import QtQuick
import QtQuick.Dialogs
import org.din.backend 1.0

/*    MENU BAR    */
Item {
    id: root

    /*    MENU BAR PROPERTIES    */

    /*
    Ensuring this is in top
    */
    z: 1

    /*    THEME COLORS    */

    /*
    Provide Access to the Colors Library
    !!!Not the best approach
    */
    CustomColors {
        id: themeColors
    }

    /*    STATUS PROPERTIES    */
    property bool isDarkTheme: themeSwitcher.isDarkTheme
    property bool isTextWrap: true


    /*    GENERAL    */

    /*
    For Mouse Area to exit the Dropdown
    */
    property int windowWidth: 640
    property int windowHeight: 480

    // Reference to the Text Editor
    property Item textEditor

    // Reference to the Window Title
    property string windowTitleReference: "Text Editor - Untitled"


    /*    MENU BAR SIZES    */

    // Body Size
    property int bodyWidth: root.width
    property int bodyHeight: root.height

    // Item Size
    readonly property int itemWidth: 80
    readonly property int itemHeight: root.bodyHeight

    // For fix subitem position x
    readonly property int subitemXFix: 4


    /*    MENU BAR COLORS    */

    // Body Color
    readonly property color bodyColorDefault: root.isDarkTheme ? themeColors.darkMenuBar : themeColors.lightMenuBar


    /*    MENU BAR TEXT    */

    readonly property int textSize: 11


    /*    FUNCTIONS    */

    /*
    Close all dropdown menus except the current one
    */
    function closeOtherDropdowns(currentDropdown) {
        if (currentDropdown !== dropdownMenuFile) {
            dropdownMenuFile.generalVisibility = false
        }
        if (currentDropdown !== dropdownMenuEdit) {
            dropdownMenuEdit.generalVisibility = false
        }
        if (currentDropdown !== dropdownMenuView) {
            dropdownMenuView.generalVisibility = false
        }
    }

    /*    BODY    */
    Rectangle {
        id: body

        // Body Size
        width: root.bodyWidth
        height: root.bodyHeight

        // Body Color
        color: root.bodyColorDefault

        /*    ITEM CONTAINER    */
        Row {
            id: itemContainer

            // Item Container Position
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 15
            spacing: 10

            /*    BODY CONTAINER ITEM FILE    */
            CustomButton {
                id: bodyItemFile

                // Item Size
                width: root.itemWidth
                height: root.itemHeight

                // Item Text
                text: "File"
                textSize: root.textSize

                // Item Theme Status
                isDarkTheme: root.isDarkTheme

                // Item Clicked Event
                onClicked: {
                    /*
                    Close all dropdown menus except the dropdownMenuFile
                    */
                    root.closeOtherDropdowns(dropdownMenuFile)

                    /*
                    If Clicked, than Toggle dropdownMenuFile
                    */
                    dropdownMenuFile.generalVisibility = !dropdownMenuFile.generalVisibility
                }

            }

            /*    BODY CONTAINER ITEM EDIT    */
            CustomButton {
                id: bodyItemEdit

                // Item Size
                width: root.itemWidth
                height: root.itemHeight

                // Item Text
                text: "Edit"
                textSize: root.textSize

                // Item Theme Status
                isDarkTheme: root.isDarkTheme

                // Item Clicked Event
                onClicked: {
                    /*
                    Close all dropdown menus except the dropdownMenuEdit
                    */
                    root.closeOtherDropdowns(dropdownMenuEdit)

                    /*
                    If Clicked, than Toggle dropdownMenuEdit
                    */
                    dropdownMenuEdit.generalVisibility = !dropdownMenuEdit.generalVisibility
                }
            }

            /*    BODY CONTAINER ITEM VIEW    */
            CustomButton {
                id: bodyItemView

                // Item Size
                width: root.itemWidth
                height: root.itemHeight

                // Item Text
                text: "View"
                textSize: root.textSize

                // Item Theme Status
                isDarkTheme: root.isDarkTheme

                // Item Clicked Event
                onClicked: {
                    /*
                    Close all dropdown menus except the dropdownMenuView
                    */
                    root.closeOtherDropdowns(dropdownMenuView)

                    /*
                    If Clicked, than Toggle dropdownMenuView
                    */
                    dropdownMenuView.generalVisibility = !dropdownMenuView.generalVisibility
                }

            }
        }

        /*    BODY ITEM THEME SWITCHER    */
        ThemeSwitcher {
            id: themeSwitcher

            // Item Size
            itemWidth: 60
            itemHeight: body.height - 10

            // Item Position
            anchors.right: body.right
            anchors.rightMargin: 40
            anchors.verticalCenter: body.verticalCenter
        }
    }


    /*    DROPDOWN MENU FILE    */

    CustomMenuDropdown {
        id: dropdownMenuFile

        // General
        /*
        For Mouse Area to exit the Dropdown
        */
        windowWidth: root.windowWidth
        windowHeight: root.windowHeight - root.height

        // Dropdown Position
        x: itemContainer.spacing + root.subitemXFix
        y: root.bodyHeight

        // Dropdown Theme Status
        isDarkTheme: root.isDarkTheme

        // Dropdown Items
        itemSpacing: itemContainer.spacing
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


    /*    DROPDOWN MENU EDIT    */

    CustomMenuDropdown {
        id: dropdownMenuEdit

        // Dropdown Menu Size
        windowWidth: root.windowWidth
        windowHeight: root.windowHeight - root.height

        // Dropdown Menu Position
        x: root.itemWidth + (itemContainer.spacing * 2) + root.subitemXFix
        y: root.bodyHeight

        // Dropdown Theme Status
        isDarkTheme: root.isDarkTheme

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


    /*    DROPDOWN MENU VIEW    */

    CustomMenuDropdown {
        id: dropdownMenuView

        // Dropdown Menu Size
        windowWidth: root.windowWidth
        windowHeight: root.windowHeight - root.height

        // Dropdown Menu Position
        x: (root.itemWidth * 2) + (itemContainer.spacing * 3) + subitemXFix
        y: root.bodyHeight

        // Reference to Is Dark Theme
        isDarkTheme: root.isDarkTheme

        // Dropdown Menu Items
        menuItems: [
            {
                text: "Text Wrap",
                action: function() {
                    root.isTextWrap = !root.isTextWrap
                },
                enabled: true,
                icon: true,
                iconLightSource: "qrc:/icons/icons/IconLightCheck.svg",
                iconDarkSource: "qrc:/icons/icons/IconDarkCheck.svg",
                isTextWrapReference: root.isTextWrap
            }
        ]

    }


    /*    FILE DIALOGS POPUPS    */

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


    /*    CONNECTING TO BACKEND    */

    Backend {
        id: backend

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

}

