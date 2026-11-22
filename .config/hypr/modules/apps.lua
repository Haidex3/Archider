-- Startup applications and services.
-- Do not start hyprlock here: it is a lock command, not a startup service.

hl.on("hyprland.start", function()
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("env QML_XHR_ALLOW_FILE_READ=1 quickshell")
    hl.exec_cmd([[bash -lc 'rm -f /run/user/1000/eww-server_*; eww daemon --debug']])
    hl.exec_cmd("$HOME/scripts/init-root.sh")
    hl.exec_cmd("$HOME/scripts/app.fish")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
end)
