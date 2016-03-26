-- Shifty configured tags.
shifty.config.tags = {
  term = {
    layout    = awful.layout.suit.tile,
    mwfact    = 0.60,
    exclusive = true,
    position  = 1,
    init      = true,
  },
  ed = {
    layout      = awful.layout.suit.tile,
    position    = 2,
    exclusive   = true,
    max_clients = 1
  },
  pdf = {
    layout      = awful.layout.suit.tile,
    exclusive   = true,
    position    = 2,
    max_clients = 1,
  },
  web = {
    layout      = awful.layout.suit.tile.bottom,
    max_clients = 1,
    position    = 4,
  },
  grisbi = {
    layout      = awful.layout.suit.tile,
    mwfact      = 0.55,
    exclusive   = true,
    position    = 5,
    screen      = 2,
    max_clients = 1,
  },
  mail = {
    layout      = awful.layout.suit.tile,
    mwfact      = 0.55,
    position    = 6,
    screen      = 1,
    max_clients = 1,
  },
  media         = {
    layout      = awful.layout.suit.floating,
    exclusive   = false,
    position    = 8,
  },
  dolphin       = {
    layout      = awful.layout.suit.tile,
    max_clients = 1,
  },
  office        = {
    layout      = awful.layout.suit.floating,
    position    = 9,
  },
  console       = {
    layout      = awful.layout.suit.tile,
    position    = 2,
  },
  irc           = {
    layout      = awful.layout.suit.tile,
    position    = 9,
    screen      = 2,
    spawn       = 'urxvtc',
  },
  wine          = {
    layout      = awful.layout.suit.max.fullscreen,
    position    = 1,
    screen      = 1,
  },
}

-- SHIFTY: application matching rules
-- order here matters, early rules will be applied first
shifty.config.apps = {
  {
    match = {
      "urxvt"
    },
    tag = "term"
  },
  {
    match = {
      "gvim",
      "emacs"
    },
    tag = "ed"
  },
  {
    match = {
      "evince",
      "zathura",
    },
    tag = "pdf"
  },
  {
    match = {
      "Navigator",
      "Chromium",
      "Firefox"
    },
    tag = "web"
  },
  {
    match = {
      "Developer Tools",
    },
    tag = "console"
  },
  {
    match = {
      "Thunderbird",
      "mutt"
    },
    tag = "mail"
  },
  {
    match = {
      "thunar"
    },
    tag = "media"
  },
  {
    match = {
      "*libreoffice.*"
    },
    tag = "office"
  },
  {
    match = {
      "dolphin-emu"
    },
    tag = "dolphin"
  },
  {
    match = {
      "Mplayer.*",
      "Xine",
      "Vlc",
    	"Mirage",
    	"gimp",
    	"easytag",
    },
    tag = "media",
    nopopup = true,
  },
  {
    match = {
      "Steam",
    },
    tag = "steam",
    float = true
  },
  {
    match = {
      "MPlayer",
    	"Xine",
    	"Vlc",
    	"Gnuplot",
    	"galculator",
      "thunar",
    },
    float = true,
  },
  {
    match = {
      terminal,
    },
    honorsizehints = false,
    slave = true,
  },
  {
    match = {
      "exe",
      "Flash"
    },
    tag = "web",
  },
  {
    match = {
      "Wine",
    },
    tag = "wine",
  },
  {
    match = {""},
    buttons = awful.util.table.join(
    awful.button({},        1, function (c)
      client.focus = c
      c:raise()
    end),
    awful.button({modkey},  1, function(c)
      client.focus = c
      c:raise()
      awful.mouse.client.move(c)
    end),
    awful.button({modkey},  3, awful.mouse.client.resize)
    )
  },
}

-- SHIFTY: default tag creation rules
-- parameter description
shifty.config.defaults = {
  layout = awful.layout.suit.tile.bottom,
  ncol           = 1,
  mwfact         = 0.60,
  floatBars      = true,
  guess_name     = true,
  guess_position = true,
}
