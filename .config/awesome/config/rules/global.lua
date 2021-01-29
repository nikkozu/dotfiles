local beautiful = require("beautiful")

ruled.client.connect_signal("request::rules", function()
    -- Affect all clients
    ruled.client.append_rule {
        id         = "global",
        rule       = {},
        properties = {
            focus        = awful.client.focus.filter,
            raise        = true,
            screen       = awful.screen.preferred,
            placement    = awful.placement.no_overlap + awful.placement.no_offscreen,
            border_color = beautiful.border_color_active
        }
    }

    -- Clients and Dialogs titlebars
    -- Replace `titlebars_enabled` with `true` or `false`
    ruled.client.append_rule {
        id         = "titlebars",
        rule_any   = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = false }
    }

    -- Example custom rules to always map on selected tag
    -- Automaticly move to tag, change `switch_to_tags` with `true` or `false`
    -- ruled.client.append_rule {
        -- id = "",
        -- rule = {},
        -- properties {
            -- tag = screen[1].tags[2],
            -- switch_to_tags = true
        -- }
    -- }
end)
