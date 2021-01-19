-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears     = require("gears")
local awful     = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox     = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty   = require("naughty")
-- Declarative object management
local ruled     = require("ruled")
local hotkeys   = require("awful.hotkeys_popup.widget")

-- Require configuration file
require("config")

-- {{{ Require wigdets
local lain                 = require("lain")
local batteryarc_widget    = require("widgets.batteryarc-widget")
local brightnessarc_widget = require("widgets.brightnessarc-widget")
local volumearc_widget     = require("widgets.volumearc-widget")
local touchpad_widget      = require("widgets.touchpad-widget")
touchpad_widget:new({
    vendor = "Razer USA, Ltd DeathAdder Essential"
})
-- }}}

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
-- }}}

-- {{{ Variable definitions
-- Custom rounded shape
myshape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, 8)
end

-- Themes define colours, icons, font and wallpapers.
beautiful.init("~/.config/awesome/themes/default/theme.lua")
beautiful.font                   = "Proxima Nova Alt 10"
beautiful.menu_font              = "Noto Sans 9"
beautiful.useless_gap            = 5
beautiful.notification_icon_size = 90
beautiful.notification_shape     = myshape

-- hotkeys_popup configurations
hotkeys_popup = hotkeys.new({ 
    height = 720,
    width  = 400,
    shape  = myshape
})

-- modkey & altkey, or you can add your new key here.
modkey = "Mod4"
altkey = "Mod1"
-- }}}

-- {{{ Menu
-- sub menu
myawesomemenu = {
    { "hotkeys"    , function() hotkeys_popup:show_help(nil, awful.screen.focused()) end },
    { "edit config", default.editor_cmd .. " " .. awesome.conffile },
    { "reload wm"  , awesome.restart }
 }

-- main menu
mymainmenu = awful.menu({
    items = {
        { "awesome"      , myawesomemenu, beautiful.awesome_icon },
        { "open terminal", default.terminal },
        { "lock screen"  , lock_screen },
        { "logout"       , function() awesome.quit() end },
        { "reboot"       , "reboot" },
        { "shutdown"     , "shutdown -h now" },
    }
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                      menu = mymainmenu })
-- }}}

-- {{{ Tag
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.max,
        awful.layout.suit.tile,
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
-- }}}

-- {{{ Wibar
-- {{{ Create Widget
-- Create a textclock widget
local JapanDay    = {
    sun = "日", mon = "月", tue = "火", wed = "水",
    thu = "木", fri = "金", sat = "土",
}
local getToday    = JapanDay[os.date("%a"):lower()]
local mytextclock = wibox.widget.textclock("%m月%d日 (" .. getToday .. "), %H:%M")

-- Create calendar widget
local mycal = lain.widget.cal {
    attach_to   = { mytextclock },
    week_number = "left",
    notification_preset = {
        font = "Ubuntu Mono 10",
        fg   = "#FFFFFF",
        bg   = "#000000"
    }
}
-- event to open expand calendar when mouse hovering the calendar
mytextclock:disconnect_signal("mouse::enter", mycal.hover_on)

-- net speed widget
-- create the widget
local mynet = wibox.widget {
    widget = wibox.widget.textbox,
    valign = "center",
    font   = beautiful.font
}
-- set the widget
lain.widget.net {
    settings = function()
        mynet:set_markup(net_now.sent + net_now.received .. " kB/s")
    end
}

-- memory widget
-- create the widget
local mymem = wibox.widget {
    widget = wibox.widget.textbox,
    valign = "center",
    font   = beautiful.font
}
-- set the widget
lain.widget.mem {
    settings = function()
        mymem:set_markup(mem_now.used .. " MiB")
    end
}

-- volume widget
local myvol = volumearc_widget {
    get_volume_cmd = "amixer sget Master",
    inc_volume_cmd = "amixer sset Master 5%+",
    dec_volume_cmd = "amixer sset Master 5%-",
    tog_volume_cmd = "amixer -D pulse sset Master toggle"
}

 -- brightness widget
local mybri = brightnessarc_widget {
    get_brightness_cmd = "xbacklight -get",
    inc_brightness_cmd = "xbacklight -inc 5",
    dec_brightness_cmd = "xbacklight -dec 5"
}

 -- battery widget
local mybat = batteryarc_widget {
    font                   = "Proxima Nova 6",
    show_notification_mode = "on_click",
    show_current_level     = true,
    warning_msg_position   = "top_right"
}
-- }}}

-- Set wallpaper
awful.spawn.with_shell("feh --bg-scale " .. default.wallpaper)

-- build the desktop
screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "一", "二", "三", "四", "五", "六", "七", "八", "九" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc(-1) end),
            awful.button({ }, 5, function () awful.layout.inc( 1) end),
        }
    }

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.noempty,
        buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                                            if client.focus then
                                                client.focus:toggle_tag(t)
                                            end
                                        end),
            awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
        },
        style = {
            disable_task_name  = true,
            shape              = myshape,
            bg_focus           = "#7F7F7F",
            shape_border_width = 1,
            shape_border_color = beautiful.border_color_active,
        },
        layout = {
            spacing        = 5,
            spacing_widget = {
                {
                    forced_width = 0,
                    shape        = myshape,
                    color        = beautiful.bg_normal,
                    widget       = wibox.widget.separator
                },
                valign = 'center',
                halign = 'center',
                widget = wibox.container.place,
            },
            layout = wibox.layout.fixed.horizontal
        },
        -- Notice that there is *NO* wibox.wibox prefix, it is a template,
        -- not a widget instance.
        widget_template = {
            {
                {
                    {
                        {
                            id     = 'icon_role',
                            widget = wibox.widget.imagebox,
                        },
                        widget  = wibox.container.margin,
                    },
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left   = 4,
                right  = 4,
                widget = wibox.container.margin,
            },
            id     = 'background_role',
            widget = wibox.container.background,
        },
    }

    -- Create the wibox
    s.mywibox = wibox({
        screen       = s,
        x            = s.geometry.x + 10,
        y            = s.geometry.y,
        width        = s.geometry.width - 24,
        height       = 26,
        shape        = myshape,
        border_width = 2,
        border_color = beautiful.border_color_active
    })
    s.mywibox.visible = true
    s.padding = { top = 25 }

    -- Splitters
    local sprtr        = wibox.widget.textbox()
    sprtr:set_text(" | ")
    local double_space = wibox.widget.textbox()
    double_space:set_text("  ")
    local single_space = wibox.widget.textbox()
    single_space:set_text(" ")

    -- Add widgets to the wibox
    s.mywibox.widget = {
        {
            layout = wibox.layout.align.horizontal,
            { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                mylauncher,
                sprtr,
                s.mytaglist,
                sprtr,
                single_space,
                s.mypromptbox,
            },
            {
                layout = wibox.layout.flex.horizontal,
                s.mytasklist, -- Middle widget
                {
                    mytextclock,
                    valign = "center",
                    halign = "center",
                    layout = wibox.layout.fixed.horizontal
                },
            },
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                sprtr,
                wibox.widget.systray(),
                sprtr,
                mynet,
                sprtr,
                mymem, -- memory widget
                sprtr,
                myvol, -- volume widget
                single_space,
                mybri, -- brighness widget
                sprtr,
                mybat, -- battery widget
                -- sprtr,
                -- mytextclock,
                sprtr,
                s.mylayoutbox,
            },
        },
        top    = 2,
        left   = 4,
        right  = 4,
        bottom = 4, -- don't forget to increase wibar height
        color  = beautiful.bg_normal,
        widget = wibox.container.margin,
    }
end)
-- }}}

-- Require bindings
require("config.bindings")

-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            focus        = awful.client.focus.filter,
            raise        = true,
            screen       = awful.screen.preferred,
            placement    = awful.placement.no_overlap+awful.placement.no_offscreen,
            border_color = beautiful.border_color_active,
        }
    }

    -- Floating clients.
    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer",
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name    = {
                "Event Tester",  -- xev.
            },
            role    = {
                "AlarmWindow",    -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    }

    -- Floating clients centered.
    ruled.client.append_rule {
      id         = "floating-centered",
      rule_any   = {
          class = {
              "Lxpolkit", "DiscordCanary", "Nemo", "Nm-connection-editor",
              "TelegramDesktop",
          },
          name  = {
              "Save File", "Open Files",
          },
      },
      properties = {
          floating  = true,
          placement = awful.placement.centered,
      } 
    }

    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule {
        id         = "titlebars",
        rule_any   = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = false     }
    }

    -- Set Kitty to always map on the tag named "2" on screen 1.
--     ruled.client.append_rule {
        -- rule       = { class = "kitty"       },
        -- properties = { 
          -- tag = screen[1].tags[2],
          -- switch_to_tags = true,
        -- }
    -- }
end)
-- }}}

-- {{{ Notifications
ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5,
        }
    }
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box { notification = n }
end)

-- }}}

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
            gears.shape.rectangle(cr,w,h,10)
        end
    else
        c.shape = function(cr,w,h)
            gears.shape.rounded_rect(cr,w,h,10)
        end
    end
end)
