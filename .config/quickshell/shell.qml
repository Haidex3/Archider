
import Quickshell
import "modules/bar"
import Quickshell.Wayland
import "modules/launchers/themeLauncher"

/*!
    Root of the configuration, this is where components,
    launchers, and widgets are declared
*/
ShellRoot {
    Variants {
        model: Quickshell.screens.filter(scr => !isExcluded(scr.name))
        
        Bar {
            property var modelData
            screen: modelData
        }
    }

    // Theme Launcher - Toggle with hyprctl dispatch
    ThemeLauncher {
        id: themeLauncher
        externalScriptPath: "/home/andrex/.config/quickshell/lucy/scripts/apply-theme.sh"
    }
    
    /*!
        Create multiple Bars to each monitor & exclude the creation in tarjet monitor
    */
    function isExcluded(screenName) {
        const excluded = [
            // "DP-2",
        ];
        return excluded.includes(screenName);
    }

}