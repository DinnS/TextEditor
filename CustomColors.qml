import QtQuick

/*    LIBRARY THEME COLORS    */

QtObject {
    id: themeColors

    /*    LIGHT THEME COLORS    */

    // Editor
    readonly property color lightEditor: "#f9f9f9"

    // Menu Bar
    readonly property color lightMenuBar: "#E9E9E9"
    readonly property color lightButtonDefault: "#00000000"
    readonly property color lightButtonHover: "#D8D8F2"
    readonly property color lightMenuDropdown: "#E9E9E9"

    // Text
    readonly property color lightTextDefault: "#1a1a1a"
    readonly property color lightTextHover: "#1a1a1a"
    readonly property color lightTextPressed: "#1a1a1a"

    // Cursor
    readonly property color lightCursor: "#1a1a1a"

    // Scroll Bar
    readonly property color lightScrollBar: "#1a1a1a"

    // Theme Switcher
    readonly property color lightThemeSwitcher: "#f4edf4"
    readonly property color lightThemeSwitcherBorderFirst: "#FFD700"
    readonly property color lightThemeSwitcherBorderSecond: "#FFC500"
    readonly property color lightThemeSwitcherBorderThird: "#FFB200"
    readonly property color lightThemeSwitcherBorderDisable: "transparent"


    /*    DARK THEME COLORS    */

    // Editor
    readonly property color darkEditor: "#272727"

    // Menu Bar
    readonly property color darkMenuBar: "#191B19"
    readonly property color darkButtonDefault: "#00000000"
    readonly property color darkButtonHover: "#383838"
    readonly property color darkMenuDropdown: "#2c2c2c"

    // Text
    readonly property color darkTextDefault: "#ffffff"
    readonly property color darkTextHover: "#ffffff"
    readonly property color darkTextPressed: "#ffffff"

    // Cursor
    readonly property color darkCursor: "#ffffff"

    // Scroll Bar
    readonly property color darkScrollBar: "#ffffff"

    // Theme Switcher
    readonly property color darkThemeSwitcher: "#2C302E"
    readonly property color darkThemeSwitcherBorderFirst: "#002855"
    readonly property color darkThemeSwitcherBorderSecond: "#002E5E"
    readonly property color darkThemeSwitcherBorderThird: "#003366"
    readonly property color darkThemeSwitcherBorderDisable: "transparent"

}
