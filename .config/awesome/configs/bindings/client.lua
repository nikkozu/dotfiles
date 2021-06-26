-- local cyclefocus = require("widgets.awesome-cyclefocus")
local switcher = require("plugins.awesome-switcher")

-- Client key bindings
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
--         cyclefocus.key({ altkey }, "Tab", {
            -- cycle_filters = { cyclefocus.filters.same_screen, cyclefocus.filters.common_tag },
            -- keys = { "Tab", "ISO_Left_Tab" }
        -- }),

        awful.key({ altkey,           }, "Tab",
            function()
                switcher.switch( 1, altkey, "Alt_L", "Shift", "Tab")
                -- awful.client.focus.byidx( 1)
            end,
            {description = "focus next client", group = "client"}
        ),
        awful.key({ altkey, "Shift"   }, "Tab",
            function()
                switcher.switch(-1, altkey, "Alt_L", "Shift", "Tab")
                -- awful.client.focus.byidx(-1)
            end
        ),

        awful.key({ modkey,           }, "q", function(c) c:kill()              end,
            {description = "quit", group = "client"}
        ),
        awful.key({ modkey,           }, "o", function(c) c:move_to_screen()    end,
            {description = "move to screen", group = "client"}
        ),
        awful.key({ modkey,           }, "t", function(c) c.ontop = not c.ontop end,
            {description = "toggle keep on top", group = "client"}
        ),
        awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
            {description = "toggle floating", group = "client"}
        ),
        awful.key({ modkey,           }, "f",
            function(c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen", group = "client"}
        ),
        awful.key({ modkey, "Control" }, "Return",
            function(c)
                c:swap(awful.client.getmaster())
            end,
            {description = "move to master", group = "client"}
        ),
        -- awful.key({ modkey,           }, "n",
            -- function(c)
                -- -- The client currently has the input focus, so it cannot be
                -- -- minimized, since minimized clients can't have the focus.
                -- c.minimized = true
            -- end,
            -- {description = "minimize", group = "client"}
        -- ),
        awful.key({ modkey,           }, "m",
            function(c)
                c.maximized = not c.maximized
                c:raise()
            end,
            {description = "(un)maximize", group = "client"}
        ),
        awful.key({ modkey, "Control" }, "m",
            function(c)
                c.maximized_vertical = not c.maximized_vertical
                c:raise()
            end,
            {description = "(un)maximize vertically", group = "client"}
        ),
        awful.key({ modkey, "Shift"   }, "m",
            function(c)
                c.maximized_horizontal = not c.maximized_horizontal
                c:raise()
            end,
            {description = "(un)maximize horizontally", group = "client"}
        ),
        awful.key({ modkey, "Shift"   }, "y", awful.placement.centered,
            {description = "move floating client to center", group = "client"}
        ),
    })
end)
