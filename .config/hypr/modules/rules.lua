-- Floating windows and workspace rules.
-- The previous two-position move arrays were not valid x/y pairs.
-- These rules center the 960x550 windows horizontally, 38px from the top.

hl.window_rule({
    name = "qs-nmtui-topcenter",
    match = { class = "^qs-nmtui$" },
    float = true,
    size = { 960, 550 },
    move = { "(monitor_w - 960) / 2", "38" },
})

hl.window_rule({
    name = "qs-bluetui-topcenter",
    match = { class = "^qs-bluetui$" },
    float = true,
    size = { 960, 550 },
    move = { "(monitor_w - 960) / 2", "38" },
})

hl.window_rule({
    name = "qs-pavucontrol-topcenter",
    match = { class = [[^org\.pulseaudio\.pavucontrol$]] },
    float = true,
    size = { 960, 550 },
    move = { "(monitor_w - 960) / 2", "38" },
})

hl.window_rule({
    name = "spotify-workspace-4",
    match = { class = "^spotify$" },
    workspace = "4",
    float = false,
})
