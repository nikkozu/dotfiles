-- Launc application keys
awful.keyboard.append_global_keybindings({
    -- spawn without shell
    awful.key({ modkey,           }, "Return", 
        function()
            awful.spawn(default.terminal, {
                floating  = true,
                placement = awful.placement.centered 
            })
        end,
        {description = "open a terminal", group = "launcher"}
    ),
    awful.key({ modkey,           }, "e", function() awful.spawn(default.explorer) end,
        {description = "open " .. default.explorer, group = "launcher"}
    ),
    awful.key({ modkey,           }, "b", function() awful.spawn(default.browser.brave) end,
        {description = "open browser", group = "launcher"}
    ),
    awful.key({ modkey, "Shift"   }, "b", function() awful.spawn(default.browser.firefox) end,
        {description = "open browser", group = "launcher"}
    ),
    awful.key({ modkey            }, "n", function() awful.spawn(default.editor_cmd) end,
        {description = "open editor", group = "launcher"}
    ),
    awful.key({ modkey, "Shift"   }, "d", function() awful.spawn(default.discord) end,
        {description = "open discord", group = "launcher"}
    ),
    awful.key({ modkey            }, "r", function() awful.screen.focused().mypromptbox:run() end,
        {description = "run prompt", group = "launcher"}
    ),

    -- spawn with shell
    awful.key({ modkey            }, "d", function() awful.spawn.with_shell(default.rofi) end,
        {description = "open rofi dmenu", group = "launcher"}
    ),
})
