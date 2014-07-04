require("awful")
require("awful.autofocus")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- shifty - dynamic tagging library
require("shifty")
-- User libraries
vicious = require("vicious")
require("scratch")

-- Variable definitions
altkey = "Mod1"
modkey = "Mod4"

home   = os.getenv("HOME")
exec   = awful.util.spawn
sexec  = awful.util.spawn_with_shell
scount = screen.count()

browser    = "chromium"
mail       = "thunderbird"
terminal   = "urxvt"
editor     = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Beautiful theme
beautiful.init(home .. "/.config/awesome/zenburn.lua")

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
  awful.layout.suit.tile,
  awful.layout.suit.tile.left,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  awful.layout.suit.fair.horizontal,
  awful.layout.suit.max,
  awful.layout.suit.max.fullscreen,
  awful.layout.suit.magnifier,
  awful.layout.suit.floating
}

require('tags')
require('widgets')
require('keys')
shifty.init()
shifty.config.modkey = modkey
