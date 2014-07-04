-- Mouse bindings
root.buttons(awful.util.table.join(
  awful.button({}, 4, awful.tag.viewnext),
  awful.button({}, 5, awful.tag.viewprev)
))

-- Key bindings
globalkeys = awful.util.table.join(
  -- Applications
  awful.key({ modkey }, "t", function () exec("thunar", false) end),
  awful.key({ modkey }, "f", function () exec("firefox") end),
  awful.key({ modkey }, "w", function () exec(browser) end),
  awful.key({ modkey }, "u", function () exec("urxvtc -e tmux") end),

  -- Keyboard
  awful.key({ }, "XF86AudioRaiseVolume", function ()
    awful.util.spawn("amixer set Master 9%+", false) end),
  awful.key({ }, "XF86AudioLowerVolume", function ()
    awful.util.spawn("amixer set Master 9%-", false) end),
  awful.key({ }, "XF86AudioMute", function ()
    awful.util.spawn("amixer sset Master toggle", false) end),
  awful.key({ }, "XF86AudioPrev", function () prev_moc()  end),
  awful.key({ }, "XF86AudioNext", function () next_moc()   end),
  awful.key({ }, "XF86AudioPlay", function () pause_moc()   end),

  -- Tag browsing
  awful.key({ altkey }, "n",   awful.tag.viewnext),
  awful.key({ altkey }, "p",   awful.tag.viewprev),
  awful.key({ modkey }, "Tab", awful.tag.history.restore),

  -- Prompt menus
  awful.key({ altkey }, "F2", function ()
    awful.prompt.run({ prompt = "Run: " }, mypromptbox[mouse.screen].widget,
    function (...)
      mypromptbox[mouse.screen].text = exec(unpack(arg), false)
    end,
    awful.completion.shell, awful.util.getdir("cache") .. "/history")
  end),

  awful.key({ altkey }, "F3", function ()
    awful.prompt.run({ prompt = "Web: " }, mypromptbox[mouse.screen].widget,
    function (command)
      sexec("chromium 'www.google.com/search?q="..command.."'")
      --                awful.tag.viewonly(tags[scount][3])
    end)
  end),

  awful.key({ altkey }, "F4", function ()
    awful.prompt.run({ prompt = "Lua: " }, mypromptbox[mouse.screen].widget,
    awful.util.eval, nil, awful.util.getdir("cache") .. "/history_eval")
  end),

  -- Awesome controls
  awful.key({ modkey }, "b", function ()
    mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
  end),

  awful.key({ modkey, "Shift" }, "q", awesome.quit),
  awful.key({ modkey, "Shift" }, "r", function ()
    mypromptbox[mouse.screen].text = awful.util.escape(awful.util.restart())
  end),

  -- Shifty: keybindings specific to shifty
  awful.key({modkey, "Shift"},    "d", shifty.del),       -- delete a tag
  awful.key({modkey},             "a", shifty.add),       -- create a new tag
  awful.key({modkey},             "r", shifty.rename),    -- rename a tag
  awful.key({modkey, "Shift"},    "p", shifty.send_prev), -- client to prev tag
  awful.key({modkey, "Shift"},    "n", shifty.send_next), -- client to next tag
  awful.key({modkey, "Control"},  "n", function()
    local t = awful.tag.selected()
		local s = awful.util.cycle(screen.count(), t.screen + 1)
    awful.tag.history.restore()
		t = shifty.tagtoscr(s, t)
    awful.tag.viewonly(t)
  end),

  awful.key({modkey, "Shift"},  "a", function()
    shifty.add({nopopup = true})
  end),

  awful.key({modkey,},          "j", function()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
  end),
  awful.key({modkey,},          "k", function()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
  end),

  -- Layout manipulation
  awful.key({modkey, "Shift"},    "j", function() awful.client.swap.byidx(1) end),
  awful.key({modkey, "Shift"},    "k", function() awful.client.swap.byidx(-1) end),
  awful.key({modkey, "Control"},  "j", function() awful.screen.focus(1)   end),
  awful.key({modkey, "Control"},  "k", function() awful.screen.focus(-1)  end),
  awful.key({modkey,},            "u", awful.client.urgent.jumpto),

   -- Standard program
   awful.key({modkey,           } , "l",      function() awful.tag.incmwfact(0.05)      end),
   awful.key({modkey,           } , "h",      function() awful.tag.incmwfact(-0.05)     end),
   awful.key({modkey, "Shift"   } , "h",      function() awful.tag.incnmaster(1)        end),
   awful.key({modkey, "Shift"   } , "l",      function() awful.tag.incnmaster(-1)       end),
   awful.key({modkey, "Control" } , "h",      function() awful.tag.incncol(1)           end),
   awful.key({modkey, "Control" } , "l",      function() awful.tag.incncol(-1)          end),
   awful.key({modkey,           } , "space",  function() awful.layout.inc(layouts, 1)   end),
   awful.key({modkey, "Shift"   } , "space",  function() awful.layout.inc(layouts, -1)  end)
)

-- Compute the maximum number of digit we need, limited to 9
for i = 1, (shifty.config.maxtags or 9) do
  globalkeys = awful.util.table.join(globalkeys,

  awful.key({modkey},                     i, function()
    local t =  awful.tag.viewonly(shifty.getpos(i))
  end),

  awful.key({modkey, "Control"},          i, function()
    local t = shifty.getpos(i)
    t.selected = not t.selected
  end),

  awful.key({modkey, "Control", "Shift"}, i, function()
    if client.focus then
      awful.client.toggletag(shifty.getpos(i))
    end
  end),

  -- move clients to other tags
	awful.key({modkey, "Shift"},            i, function()
    if client.focus then
      t = shifty.getpos(i)
      awful.client.movetotag(t)
      awful.tag.viewonly(t)
    end
  end)
  )
end

-- Client manipulation
clientkeys = awful.util.table.join(
  awful.key({ modkey },            "o",                 awful.client.movetoscreen),
  awful.key({ modkey },            "Next",  function () awful.client.moveresize( 20,  20, -40, -40)  end),
  awful.key({ modkey },            "Prior", function () awful.client.moveresize(-20, -20,  40,  40)  end),
  awful.key({ modkey },            "Down",  function () awful.client.moveresize(  0,  20,   0,   0)  end),
  awful.key({ modkey },            "Up",    function () awful.client.moveresize(  0, -20,   0,   0)  end),
  awful.key({ modkey },            "Left",  function () awful.client.moveresize(-20,   0,   0,   0)  end),
  awful.key({ modkey },            "Right", function () awful.client.moveresize( 20,   0,   0,   0)  end),
  awful.key({ modkey, "Control" }, "r",     function (c) c:redraw()                                  end),
  awful.key({ modkey, "Shift"   }, "0",     function (c) c.sticky = not c.sticky                     end),
  awful.key({ modkey, "Shift"   }, "m",     function (c) c:swap(awful.client.getmaster())            end),
  awful.key({ modkey, "Shift"   }, "c",     function (c) c:kill()                                    end),
  awful.key({ modkey, "Shift"   }, "f",     function (c) if awful.client.floating.get(c)
    then awful.client.floating.delete(c);    awful.titlebar.remove(c)
    else awful.client.floating.set(c, true); awful.titlebar.add(c) end
  end),
  awful.key({modkey,},           "m",	     function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c.maximized_vertical   = not c.maximized_vertical
  end)
)

-- Set keys
root.keys(globalkeys)
shifty.config.clientkeys  = clientkeys
