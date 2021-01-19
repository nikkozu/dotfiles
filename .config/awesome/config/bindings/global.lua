local awful = require("awful")

-- {{{ Global Key Bindings
-- Custom command keys
awful.keyboard.append_global_keybindings({
    awful.key({ altkey, "Shift"   }, "s", function()
        awful.spawn.with_shell(default.screenshot.selected) end,
        {description = "select to screenshot", group = "custom"}
    ),
    awful.key({ altkey, "Shift"   }, "l", function()
        awful.spawn(default.lock_screen) end,
        {description = "lock the screen", group = "custom"}
    ),
    awful.key({                   }, "Print", function()
        awful.spawn.with_shell(default.screenshot.full) end,
        {description = "take a full screenshot", group = "custom"}
    ),
})

-- Fn keys
awful.keyboard.append_global_keybindings({
    -- Brightness
    awful.key({ }, "XF86MonBrightnessUp",   function()
        awful.spawn("xbacklight -inc 5") end,
        {description = "increase brightness", group = "fn keys"}
    ),
    awful.key({ }, "XF86MonBrightnessDown", function()
        awful.spawn("xbacklight -dec 5") end,
        {description = "decrease brightness", group = "fn keys"}
    ),
    -- Audio keys
    awful.key({ }, "XF86AudioMute",        function()
        awful.spawn("amixer -D pulse set Master 1+ toggle", false) end,
        {description = "mute volume", group = "fn keys"}
    ),
    awful.key({ }, "XF86AudioLowerVolume", function()
        awful.spawn("amixer -q -D pulse sset Master 5%-", false)   end,
        {description = "decrease volume", group = "fn keys"}
    ),
    awful.key({ }, "XF86AudioRaiseVolume", function()
        awful.spawn("amixer -q -D pulse sset Master 5%+", false)   end,
        {description = "increase volume", group = "fn keys"}
    ),
})

-- General Awesome keys
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "s", function() hotkeys_popup:show_help() end,
        {description="show help", group="awesome"}
    ),
    awful.key({ modkey,           }, "w", function() mymainmenu:show()         end,
        {description = "show main menu", group = "awesome"}
    ),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
        {description = "reload awesome", group = "awesome"}
    ),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
        {description = "quit awesome", group = "awesome"}
    ),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Control" }, "n",
        function()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:activate { raise = true, context = "key.unminimize" }
            end 
        end,
        {description = "restore minimized", group = "client"}
    ),
    awful.key({ altkey,           }, "Tab", function() awful.client.focus.byidx( 1) end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ altkey, "Shift"   }, "Tab", function() awful.client.focus.byidx(-1) end
    ),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Shift"   }, "j", function() awful.client.swap.byidx(  1)    end,
        {description = "swap with next client by index", group = "client"}
    ),
    awful.key({ modkey, "Shift"   }, "k", function() awful.client.swap.byidx( -1)    end,
        {description = "swap with previous client by index", group = "client"}
    ),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
        {description = "jump to urgent client", group = "client"}
    ),
    awful.key({ modkey,           }, "l",     function() awful.tag.incmwfact( 0.05)          end,
        {description = "increase master width factor", group = "layout"}
    ),
    awful.key({ modkey,           }, "h",     function() awful.tag.incmwfact(-0.05)          end,
        {description = "decrease master width factor", group = "layout"}
    ),
    awful.key({ modkey, "Shift"   }, "h",     function() awful.tag.incnmaster( 1, nil, true) end,
        {description = "increase the number of master clients", group = "layout"}
    ),
    awful.key({ modkey, "Shift"   }, "l",     function() awful.tag.incnmaster(-1, nil, true) end,
        {description = "decrease the number of master clients", group = "layout"}
    ),
    awful.key({ modkey, "Control" }, "h",     function() awful.tag.incncol( 1, nil, true)    end,
        {description = "increase the number of columns", group = "layout"}
    ),
    awful.key({ modkey, "Control" }, "l",     function() awful.tag.incncol(-1, nil, true)    end,
        {description = "decrease the number of columns", group = "layout"}
    ),
    awful.key({ modkey,           }, "space", function() awful.layout.inc( 1)                end,
        {description = "select next", group = "layout"}
    ),
    awful.key({ modkey, "Shift"   }, "space", function() awful.layout.inc(-1)                end,
        {description = "select previous", group = "layout"}
    ),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
        {description = "view previous", group = "tag"}
    ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
        {description = "view next", group = "tag"}
    ),
    awful.key({ modkey            }, "Tab", awful.tag.history.restore,
        {description = "go back", group = "tag"}
    ),
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function(index)
            local screen = awful.screen.focused()
            local tag    = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control" },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function(index)
            local screen = awful.screen.focused()
            local tag    = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey, "Control", "Shift" },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numpad",
        description = "select layout directly",
        group       = "layout",
        on_press    = function(index)
            local t = awful.screen.focused().selected_tag
            if t then
                t.layout = t.layouts[index] or t.layout
            end
        end,
    },
})
-- }}}
