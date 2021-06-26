-- MODULE AUTO-START
-- Run all the apps listed in config/apps.lua as autostart_apps only once when awesome start
local awful = require("awful")
local apps  = require("configs.apps")

local function run_cmd(cmd)
    local findname   = cmd
    local firstspace = cmd:find(" ")
    if firstspace then
        findname = cmd:sub(0, firstspace - 1)
    end
    -- spawn the listed apps
    awful.spawn.with_shell(
        string.format(
            'if command -v %s && ! pgrep %s ; then %s& ; fi', findname, findname, cmd
        )
    )
end

for _, app in ipairs(apps.autostart_apps) do
    run_cmd(app)
end
