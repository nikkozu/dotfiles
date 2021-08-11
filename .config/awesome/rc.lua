-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Declarative object management
local hotkeys = require("awful.hotkeys_popup.widget")

-- Touchpad Widget
-- to disable/enable touchpad when mouse is connected
local touchpad_widget = require("plugins.touchpad-widget")
touchpad_widget:new({ vendor = "Philips SPK9304" })
-- Configuration folder
require("configs")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)
-- End Error handling }}}

-- {{{ Global variables
-- Custom rounded shape
myshape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, 8)
end

-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/themes/default/theme.lua")
beautiful.font                   = "Proxima Nova Alt 10"
beautiful.menu_font              = "Noto Sans 9"
beautiful.useless_gap            = 3
beautiful.notification_icon_size = 90
beautiful.notification_shape     = myshape

-- hotkeys_popup configurations
hotkeys_popup = hotkeys.new({
    height = 650,
    width  = 800,
    shape  = myshape
})

-- modkey & altkey, or you can add your new key here.
modkey = "Mod4"
altkey = "Mod1"
-- End Global variables }}}

-- {{{ Menu
-- sub menu
myawesomemenu = {
    { "hotkeys"    , function() hotkeys_popup:show_help(nil, awful.screen.focused()) end },
    { "edit config", default.editor_cmd .. " " .. awesome.conffile },
    { "reload wm"  , awesome.restart }
}

-- confirmation menu
function confirm(method)
    return {
        { "Yes", method },
        { "No" , "false" },
    }
end

-- main menu
mymainmenu = awful.menu({
    items = {
        { "awesome"      , myawesomemenu, beautiful.awesome_icon },
        { "open terminal", default.terminal },
        { "lock screen"  , confirm(default.lock_screen) },
        { "logout"       , confirm(function() awesome.quit() end) },
        { "reboot"       , confirm("reboot") },
        { "shutdown"     , confirm("shutdown -h now") },
    }
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                      menu = mymainmenu })
-- End Menu }}}

-- {{{ Tag layouts
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.tile,
        awful.layout.suit.max,
        -- awful.layout.suit.tile.left,
        -- awful.layout.suit.tile.bottom,
        -- awful.layout.suit.tile.top,
        awful.layout.suit.floating,
        -- awful.layout.suit.spiral,
        awful.layout.suit.spiral.dwindle,
        awful.layout.suit.fair,
        -- awful.layout.suit.fair.horizontal,
        awful.layout.suit.max.fullscreen,
        -- awful.layout.suit.magnifier,
        -- awful.layout.suit.corner.nw,
    })
end)
-- End tag layouts }}}

-- Wibar
require("configs.wibar")
-- Bindings
require("configs.bindings")
-- Rules
require("configs.rules")

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)

-- {{{ Rounded client
-- when client is open
client.connect_signal("manage", function(c)
    c.shape = function(cr,w,h)
        gears.shape.rounded_rect(cr,w,h,10)
    end
end)
-- fullscreen client
client.connect_signal("property::fullscreen", function(c)
    if c.fullscreen then
        c.shape = function(cr,w,h)
            gears.shape.rectangle(cr,w,h,5)
        end
    else
        c.shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,5)
        end
    end
end)
-- End Rounded client }}}
