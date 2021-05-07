local terminal = "kitty"
local editor   = os.getenv("EDITOR")

return {
    default = {
        terminal    = terminal,
        editor      = editor,
        editor_cmd  = terminal .. " -e " .. editor,
        lock_screen = "betterlockscreen -l blur",
        explorer    = "nemo",
        browser     = {
            brave   = "brave-browser-dev",
        },
        discord     = "discord-canary",
        screenshot  = {
            full     = "~/.custom-commands/screenshot-full",
            selected = "~/.custom-commands/screenshot-select",
        },
        rofi        = "~/.config/rofi/launchers/launcher.sh",
        wallpaper   = "~/Pictures/wallpapers/clay-banks-hwLAI5lRhdM-unsplash.jpg",
    },

    -- auto start apps with command
    autostart_apps = {
        "lxpolkit",
        "nm-applet",
        "picom",
        "xfce4-clipman",
        "xfce4-power-manager",
        "ibus-daemon --xim --daemonize",
    }
}
