-- Decorations and animations.
hl.config({
    decoration = {
        rounding = 8,
        blur = {
            enabled = true,
            size = 6,
            passes = 3,
            ignore_opacity = false,
            new_optimizations = true,
        },
    },
})

hl.curve("ease", {
    type = "bezier",
    points = {
        { 0.25, 0.1 },
        { 0.25, 1.0 },
    },
})

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 7,
    bezier = "ease",
    style = "slide",
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 7,
    bezier = "ease",
    style = "slide",
})

hl.animation({
    leaf = "border",
    enabled = true,
    speed = 10,
    bezier = "ease",
})

hl.animation({
    leaf = "fade",
    enabled = true,
    speed = 7,
    bezier = "ease",
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 6,
    bezier = "ease",
})
