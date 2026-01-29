import Quickshell
import "modules/bar"
import Quickshell.Wayland
import "theme" as Theme

ShellRoot {
    readonly property var theme: Theme.ThemeManager
    Variants {
        model: Quickshell.screens.filter(scr => !isExcluded(scr.name))

        Bar {
            property var modelData
            screen: modelData
        }
    }

    function isExcluded(screenName) {
        const excluded = [
            // "DP-2",
        ];
        return excluded.includes(screenName);
    }
}
