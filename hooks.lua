-- Hook function to execute when focusing a client.
client.add_signal("focus", function(c)
  if not awful.client.ismarked(c) then
    c.border_color = beautiful.border_focus
  end
end)

-- Hook function to execute when unfocusing a client.
client.add_signal("unfocus", function(c)
  if not awful.client.ismarked(c) then
    c.border_color = beautiful.border_normal
  end
end)
