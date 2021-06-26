ruled.client.connect_signal("request::rules", function()
    -- Floating random position clients
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
            name     = { "Event Tester" },
            role     = { "pop-up" }
        },
        properties = { floating = true }
    }

    -- Floating centered clients
    ruled.client.append_rule {
        id       = "floating-centered",
        rule_any = {
            class = {
                "Lxpolkit", "DiscordCanary", "Nemo", "Nm-connection-editor",
                "TelegramDesktop", "Xarchiver",
            },
            name  = { "Save File", "Open Files", },
        },
        properties = {
            floating  = true,
            placement = awful.placement.centered
        }
    }
end)
