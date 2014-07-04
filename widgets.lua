-- Widgets configuration

-- Reusable separator
separator       = widget({ type = "imagebox" })
separator.image = image(beautiful.widget_sep)

-- CPU usage and temperature
cpuicon         = widget({ type = "imagebox" })
cpuicon.image   = image(beautiful.widget_cpu)
cpugraph        = awful.widget.graph()
tzswidget       = widget({ type = "textbox" })
-- Graph properties
cpugraph:set_width(40):set_height(14)
cpugraph:set_background_color(beautiful.fg_off_widget)
cpugraph:set_gradient_angle(0):set_gradient_colors({
  beautiful.fg_end_widget, beautiful.fg_center_widget, beautiful.fg_widget
})


-- Memory usage
memicon = widget({ type = "imagebox" })
memicon.image = image(beautiful.widget_mem)
membar = awful.widget.progressbar()
-- Pogressbar properties
membar:set_vertical(true):set_ticks(true)
membar:set_height(12):set_width(8):set_ticks_size(2)
membar:set_background_color(beautiful.fg_off_widget)
membar:set_gradient_colors({
  beautiful.fg_widget, beautiful.fg_center_widget, beautiful.fg_end_widget
})

-- Network usage
dnicon        = widget({ type = "imagebox" })
upicon        = widget({ type = "imagebox" })
dnicon.image  = image(beautiful.widget_net)
upicon.image  = image(beautiful.widget_netup)
netwidget     = widget({ type = "textbox" })

-- Date and time
dateicon        = widget({ type = "imagebox" })
dateicon.image  = image(beautiful.widget_date)
datewidget      = widget({ type = "textbox" })

-- Register widgets
vicious.register(cpugraph,  vicious.widgets.cpu, "$1")
vicious.register(tzswidget, vicious.widgets.thermal, " $1°C", 1, "thermal_zone2")
vicious.register(membar, vicious.widgets.mem, "$1", 13)
vicious.register(datewidget, vicious.widgets.date, "%R", 61)
vicious.register(netwidget, vicious.widgets.net, '<span color="'
		 .. beautiful.fg_netdn_widget ..'">${enp3s0 down_kb}</span> <span color="'
		 .. beautiful.fg_netup_widget ..'">${enp3s0 up_kb}</span>', 3)

-- System tray
systray = widget({ type = "systray" })

-- moc player
function hook_moc()
  moc_info  = io.popen("mocp -i"):read("*all")
  moc_state = string.gsub(string.match(moc_info, "State: %a*"),"State: ","")
  if moc_state == "PLAY" or moc_state == "PAUSE" then
    moc_artist  = string.gsub(string.match(moc_info, "Artist: %C*"), "Artist: ","")
    moc_title   = string.gsub(string.match(moc_info, "SongTitle: %C*"), "SongTitle: ","")
    moc_artist  = string.gsub(moc_artist, "&", "&amp;")
    moc_title   = string.gsub(moc_title,  "&", "&amp;")
    moc_icon    = '<span color="#4E99E6">♫ </span>'
    if moc_artist == "" then
      moc_artist = "unknown artist"
    end
    if moc_title == "" then
      moc_title = "unknown title"
    end
    moc_string = moc_icon .. moc_artist .. " - " .. moc_title
    if moc_state == "PAUSE" then
      moc_string = " [[ " .. moc_string .. " ]]"
    end
  else
    moc_string = "" --"-- MOC not playing --"
  end
  mocwidget.text = moc_string
end

function pause_moc()
  moc_info = io.popen("mocp -i"):read("*all")
  moc_state = string.gsub(string.match(moc_info, "State: %a*"),"State: ","")
  if moc_state == "PLAY" then
    awful.util.spawn("mocp -P")
  elseif moc_state == "PAUSE" then
    awful.util.spawn("mocp -U")
  end
  return false
end

function next_moc()
  awful.util.spawn("mocp -f")
  return false
end

function prev_moc()
  awful.util.spawn("mocp -r")
  return false
end

-- Moc widget timer
mytimermoc = timer { timeout = 1 }
mytimermoc:add_signal("timeout", function() hook_moc() end)
mytimermoc:start()

-- moc widget
mocwidget = widget( { type = "textbox", name = "mocwidget", align = "right" } )
mocwidget:buttons(awful.util.table.join(
  awful.button({ }, 1, function () pause_moc()  end),
  awful.button({ }, 5, function () prev_moc()   end),
  awful.button({ }, 4, function () next_moc()   end)))
awful.widget.layout.margins[mocwidget] = { right = 9 }

-- Wibox initialisation
mywibox     = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist   = {}
mytaglist.buttons = awful.util.table.join(
  awful.button({ },        1, awful.tag.viewonly),
  awful.button({ modkey }, 1, awful.client.movetotag),
  awful.button({ },        3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, awful.client.toggletag),
  awful.button({ },        4, awful.tag.viewnext),
  awful.button({ },        5, awful.tag.viewprev
))

for s = 1, scount do
  -- Create a promptbox
  mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
  -- Create a layoutbox
  mylayoutbox[s] = awful.widget.layoutbox(s)
  mylayoutbox[s]:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.layout.inc(layouts,  1) end),
		awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
		awful.button({ }, 4, function () awful.layout.inc(layouts,  1) end),
		awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)
	))

  -- Create the taglist
  mytaglist[s] = awful.widget.taglist.new(s, awful.widget.taglist.label.all, mytaglist.buttons)

  -- Create the wibox
  mywibox[s] = awful.wibox({
    screen       = s,
    fg           = beautiful.fg_normal, height   = 12,
		bg           = beautiful.bg_normal, position = "top",
		border_color = beautiful.border_focus,
		border_width = beautiful.border_width
  })

   -- Add widgets to the wibox
   mywibox[s].widgets = {
      {   mytaglist[s], mylayoutbox[s], separator, mypromptbox[s],
      	  ["layout"] = awful.widget.layout.horizontal.leftright
      },
      s == 1 and systray or nil,
      separator, datewidget,
      separator, upicon,        netwidget, dnicon,
      separator, membar.widget, memicon,
      separator, tzswidget,     cpugraph.widget, cpuicon,
      separator, ["layout"] = awful.widget.layout.horizontal.rightleft,
      mocwidget
   }
end

shifty.taglist = mytaglist
