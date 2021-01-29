ruled = require("ruled")
awful = require("awful")
naughty = require("naughty")

return {
    require("config.rules.global"),
    require("config.rules.floating"),
    require("config.rules.notification"),
}
