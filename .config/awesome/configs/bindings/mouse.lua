-- Global mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    -- awful.button({ modkey }, 4, awful.tag.viewprev),
    -- awful.button({ modkey }, 5, awful.tag.viewnext),
})

-- Client mouse bindings
client.connect_signal("request::default_mousebindings",
    function()
        awful.mouse.append_client_mousebindings({
            awful.button({        }, 1, function (c)
                c:activate { context = "mouse_click" }
            end),
            -- awful.button({ modkey }, 1, function (c)
            --     c:activate { context = "mouse_click", action = "mouse_move"  }
            -- end),
            -- awful.button({ modkey }, 3, function (c)
            --     c:activate { context = "mouse_click", action = "mouse_resize"}
            -- end),

            awful.button({ modkey }, 1, awful.mouse.client.move),
            awful.button({ modkey }, 3, awful.mouse.client.resize),
        })
    end
)
