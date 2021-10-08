local terminal = "kitty"
local editor   = os.getenv("EDITOR")

return {
    default = {
        terminal    = terminal,
        editor      = editor,
        -- editor_cmd  = terminal .. " -e " .. editor,
        editor_cmd  = "gtk-launch knvim",
        lock_screen = "betterlockscreen -l blur",
        explorer    = "nemo",
        browser     = {
            brave   = "brave-browser-dev",
            firefox = "firefox-developer-edition"
        },
        discord     = "discord-canary",
        screenshot  = {
            full     = "~/.custom-commands/screenshot-full",
            selected = "~/.custom-commands/screenshot-select",
        },
        rofi        = "~/.config/rofi/launchers/launcher.sh",
        wallpaper   = "~/Pictures/wallpapers/clay-banks-u27Rrbs9Dwc-unsplash.jpg",
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
