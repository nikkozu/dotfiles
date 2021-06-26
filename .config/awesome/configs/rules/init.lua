ruled = require("ruled")
awful = require("awful")
naughty = require("naughty")

return {
    require("configs.rules.global"),
    require("configs.rules.floating"),
    require("configs.rules.notification"),
}
