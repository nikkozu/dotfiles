local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")

local lain                 = require("lain")
local batteryarc_widget    = require("widgets.batteryarc-widget")
local brightnessarc_widget = require("widgets.brightnessarc-widget")
local volumearc_widget     = require("widgets.volumearc-widget")

local filesize = require 'filesize'

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
        font     = "Ubuntu Mono 10",
        fg       = beautiful.fg_normal,
        bg       = beautiful.bg_normal,
        position = "top_middle"
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
        local total = net_now.sent + net_now.received

        mynet:set_markup(filesize(total * 1000) .. '/s')
        -- mynet:set_markup(net_now.sent + net_now.received .. " kB/s")
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
        mymem:set_markup(filesize(mem_now.used * 1072500))
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
-- End Create Widget }}}

-- Set wallpaper
awful.spawn.with_shell("feh --bg-scale " .. default.wallpaper)

-- build the desktop
screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    -- Define tags name
    local tags = { 
        "一", "二", "三", "四", "五",
        "六", "七", "八", "九"
    }
    awful.tag(tags, s, awful.layout.layouts[1])

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
        -- x            = s.geometry.x + 10,
        x            = s.geometry.x + 150,
        y            = s.geometry.y,
        -- width        = s.geometry.width - 24,
        width        = s.geometry.width - 304,
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
