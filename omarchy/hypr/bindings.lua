-- Keep only your personal keybinding overrides here. Add new bindings with
-- o.bind or replace defaults with o.rebind.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding. o.rebind takes the same arguments as o.bind.
-- This example replaces the default file manager with Flea.
-- o.rebind("SUPER + SHIFT + F", "File manager", { launch = "flea" })

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, { panel = "omarchy.emojis" })

-- ============================================================
-- AeroSpace-style bindings (matches dotfiles/aerospace/aerospace.toml)
-- ============================================================

-- alt-hjkl: focus
o.bind("ALT + H", "Focus on left window", hl.dsp.focus({ direction = "l" }))
o.bind("ALT + J", "Focus on below window", hl.dsp.focus({ direction = "d" }))
o.bind("ALT + K", "Focus on above window", hl.dsp.focus({ direction = "u" }))
o.bind("ALT + L", "Focus on right window", hl.dsp.focus({ direction = "r" }))

-- alt-shift-hjkl: move window (replaces Chromium's Alt+Shift+L "Copy URL")
o.bind("ALT + SHIFT + H", "Move window left", hl.dsp.window.swap({ direction = "l" }))
o.bind("ALT + SHIFT + J", "Move window down", hl.dsp.window.swap({ direction = "d" }))
o.bind("ALT + SHIFT + K", "Move window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("ALT + SHIFT + L", "Move window right", hl.dsp.window.swap({ direction = "r" }))

-- alt-1..0: workspace; alt-shift-1..0: send window there (without following, like AeroSpace)
for workspace = 1, 10 do
  local key = "code:" .. tostring(workspace + 9)
  o.bind("ALT + " .. key, "Switch to workspace " .. workspace, o.workspaces.focus(workspace))
  o.bind("ALT + SHIFT + " .. key, "Move window to workspace " .. workspace, o.workspaces.move_window(workspace, false))
end

-- alt-tab: back-and-forth; alt-shift-tab: move workspace to next monitor
-- (replaces Omarchy's Alt+Tab / Alt+Shift+Tab window cycling)
o.rebind("ALT + TAB", "Former workspace", hl.dsp.focus({ workspace = "previous_per_monitor" }))
o.rebind("ALT + SHIFT + TAB", "Move workspace to next monitor", o.workspaces.move_to_monitor("+1"))

-- alt-shift-f: fullscreen
o.bind("ALT + SHIFT + F", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

-- alt-slash: toggle split orientation; alt-comma: accordion (Hyprland tabbed group)
o.bind("ALT + SLASH", "Toggle window split", hl.dsp.layout("togglesplit"))
o.bind("ALT + COMMA", "Toggle window grouping (accordion)", hl.dsp.group.toggle())

-- alt-minus / alt-equal: resize smart
o.bind("ALT + MINUS", "Shrink window", hl.dsp.window.resize({ x = -50, y = -50, relative = true }))
o.bind("ALT + EQUAL", "Grow window", hl.dsp.window.resize({ x = 50, y = 50, relative = true }))

-- alt-shift-r: resize mode
o.bind("ALT + SHIFT + R", "Resize mode", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
  hl.bind("H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
  hl.bind("J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })
  hl.bind("K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
  hl.bind("L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
  hl.bind("MINUS", hl.dsp.window.resize({ x = -50, y = -50, relative = true }), { repeating = true })
  hl.bind("EQUAL", hl.dsp.window.resize({ x = 50, y = 50, relative = true }), { repeating = true })
  hl.bind("RETURN", hl.dsp.submap("reset"))
  hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- alt-shift-semicolon: service mode (f = toggle floating, esc = reload + exit)
o.bind("ALT + SHIFT + SEMICOLON", "Service mode", hl.dsp.submap("service"))
hl.define_submap("service", function()
  hl.bind("F", hl.dsp.window.float({ action = "toggle" }))
  hl.bind("F", hl.dsp.submap("reset"))
  hl.bind("ESCAPE", hl.dsp.exec_cmd("hyprctl reload"))
  hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)
