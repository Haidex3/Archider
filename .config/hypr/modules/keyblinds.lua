
-- Keybindings for Hyprland 0.57.
-- Use exec_cmd for shell commands and Hyprland dispatchers.

local function bind(key, command)
    hl.bind(key, hl.dsp.exec_cmd(command))
end

-- =================================================
-- Applications & System Actions
-- =================================================

bind("SUPER + RETURN", [[alacritty -e bash -c "fastfetch; exec bash"]])
bind("SUPER + E", "alacritty -e yazi")
bind("SUPER + D", "discord")
bind("SUPER + F", "firefox")
bind("SUPER + C", "code --no-sandbox")
bind("SUPER + H", "/opt/trello/Trello")
bind("SUPER + S", "rofi -config ~/.config/rofi/applications.rasi -show drun")
bind("SUPER + O", "quickshell ipc call themeLauncher toggle")

-- Session
bind("SUPER + M", "hyprctl dispatch exit")
hl.bind("SUPER + W", hl.dsp.window.close())

-- =================================================
-- Screenshots
-- =================================================

bind("PRINT", [[grim -g "$(slurp)" - | wl-copy]])

bind("SUPER + PRINT",
    [[bash -c 'grim -g "$(slurp)" /tmp/capture.png && tesseract /tmp/capture.png stdout | wl-copy']])

bind("CTRL + ALT + PRINT",
    "grim -o HDMI-A-1 /tmp/capture.png && wl-copy < /tmp/capture.png")

bind("CTRL + PRINT",
    [[bash -c 'grim -g "$(slurp)" "$HOME/Pictures/Last-image.png"']])

-- =================================================
-- Web Shortcuts
-- =================================================

bind("ALT + W", "firefox https://web.whatsapp.com/")
bind("ALT + G", "firefox https://github.com/")
bind("ALT + C", "firefox https://chatgpt.com/")
bind("ALT + T", "firefox https://trello.com/")

-- =================================================
-- Window State & Layout
-- =================================================

bind("ALT + F4", "$HOME/.config/rofi/powerMenu/powermenu.sh")
bind("ALT + RETURN", "hyprctl dispatch fullscreen 1")
bind("CTRL + RETURN", "hyprctl dispatch fullscreen")
bind("SUPER + L", "hyprctl dispatch togglefloating")


-- =================================================
-- Workspaces
-- =================================================

for i = 1, 8 do

    -- Switch to workspace
    hl.bind(
        "SUPER + " .. i,
        hl.dsp.focus({ workspace = i })
    )

    -- Move active window to workspace
    hl.bind(
        "SUPER + SHIFT + " .. i,
        hl.dsp.window.move({
            workspace = i,
            follow = false
        })
    )

end


-- =================================================
-- Window Movement & Focus
-- =================================================

bind("SUPER + UP", "hyprctl dispatch movewindow l")
bind("SUPER + DOWN", "hyprctl dispatch movewindow r")
bind("SUPER + R", "hyprctl dispatch movewindow l")

-- Original SUPER + L movefocus conflicts with togglefloating.
-- Use SUPER + CTRL + L instead.
bind("SUPER + CTRL + L", "hyprctl dispatch movefocus r")

bind("ALT + TAB", "hyprctl dispatch cyclenext")

bind("SUPER + J", "hyprctl dispatch movetoworkspace current")
bind("SUPER + K", "hyprctl dispatch movetoworkspacesilent special:spotif")

-- =================================================
-- Special Workspaces
-- =================================================

bind("SUPER + SHIFT + I",
    "hyprctl dispatch movetoworkspace special:minimized")

bind("SUPER + I",
    "hyprctl dispatch togglespecialworkspace minimized")

-- =================================================
-- Monitor Movement
-- =================================================

-- Adjusted to current monitor configuration.
bind("SUPER + LEFT", "hyprctl dispatch movewindow mon:DP-1")
bind("SUPER + RIGHT", "hyprctl dispatch movewindow mon:HDMI-A-1")

-- =================================================
-- Audio
-- =================================================

bind("XF86AudioRaiseVolume", "pamixer -i 5")
bind("XF86AudioLowerVolume", "pamixer -d 5")
bind("XF86AudioMute", "pamixer -t")

bind("SUPER + F1", "pamixer -t")
bind("SUPER + F2", "pamixer -d 5")
bind("SUPER + F3", "pamixer -i 5")

-- =================================================
-- Media Controls
-- =================================================

bind("XF86AudioNext", "playerctl next")
bind("XF86AudioPrev", "playerctl previous")
bind("XF86AudioPlay", "playerctl play-pause")

bind("SUPER + F8", "playerctl next")
bind("SUPER + F6", "playerctl previous")
bind("SUPER + F7", "playerctl play-pause")

-- =================================================
-- Brightness
-- =================================================

bind("XF86MonBrightnessUp", "brightnessctl set +10%")
bind("XF86MonBrightnessDown", "brightnessctl set 10%-")

bind("SUPER + F9", "$HOME/scripts/brightness-ddc.sh down")
bind("SUPER + F10", "$HOME/scripts/brightness-ddc.sh up")

-- =================================================
-- Clipboard & Command Board
-- =================================================

bind("SUPER + V", "$HOME/scripts/clipboard.sh")
bind("SUPER + N", "$HOME/scripts/commandboard.sh copy")

-- =================================================
-- Monitor Menu & Theme
-- =================================================

bind("SUPER + P", "$HOME/scripts/keybinds/monitor-menu.sh")
bind("SUPER + T", "qs ipc call theme toggle")
