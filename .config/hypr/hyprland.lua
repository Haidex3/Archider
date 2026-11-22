-- Hyprland 0.57.0 - Main configuration
-- Each module registers its settings directly through the native hl API.

require("modules.env")
require("modules.monitors")
require("modules.inputs")
require("modules.animations")
require("modules.rules")
require("modules.keyblinds")
require("modules.apps")
require("myColors")

hl.config({
    general = {
        gaps_in = 1,
        gaps_out = 1,
        border_size = 2,
        layout = "dwindle",
        resize_on_border = true,
    },
    decoration = {
        active_opacity = 0.95,
        inactive_opacity = 0.85,
        fullscreen_opacity = 1.0,
    },
})
