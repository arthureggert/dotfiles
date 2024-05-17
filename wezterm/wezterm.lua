local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

require("modules.tabs").setup(config, false)

config.color_scheme = "Catppuccin Mocha"

config.disable_default_key_bindings = true
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true
config.font_size = 22.0

config.window_padding = { left = 2, right = 2, top = 2, bottom = 2 }
config.window_decorations = "RESIZE"
config.window_background_opacity = 1
config.integrated_title_button_alignment = "Right"
config.integrated_title_button_style = "Windows"
config.integrated_title_buttons = { "Hide", "Maximize", "Close" }

config.keys = {
	-- {
	-- 	key = "e",
	-- 	mods = "CMD",
	-- 	action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	-- },
	-- {
	-- 	key = "e",
	-- 	mods = "CMD|SHIFT",
	-- 	action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	-- },
	-- {
	-- 	mods = "CMD",
	-- 	key = "LeftArrow",
	-- 	action = wezterm.action.ActivatePaneDirection("Left"),
	-- },
	-- {
	-- 	key = "RightArrow",
	-- 	mods = "CMD",
	-- 	action = wezterm.action.ActivatePaneDirection("Right"),
	-- },
	-- {
	-- 	key = "UpArrow",
	-- 	mods = "CMD",
	-- 	action = wezterm.action.ActivatePaneDirection("Up"),
	-- },
	-- {
	-- 	key = "DownArrow",
	-- 	mods = "CMD",
	-- 	action = wezterm.action.ActivatePaneDirection("Down"),
	-- },
	-- { key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
	{ key = "w", mods = "CMD", action = wezterm.action({ SendString = "\x1b:bd\n" }) },
	{ key = "s", mods = "CMD", action = wezterm.action({ SendString = "\x1b:w\n" }) },
	{ key = "s", mods = "CTRL", action = wezterm.action({ SendString = "\x1b:w\n" }) },
	{ key = "s", mods = "CMD|SHIFT", action = wezterm.action({ SendString = "\x1b:wa\n" }) },
	{ key = "v", mods = "CMD", action = wezterm.action({ PasteFrom = "Clipboard" }) },
	{ key = "c", mods = "CMD", action = wezterm.action({ CopyTo = "Clipboard" }) },
	{ key = ":", mods = "CTRL|SHIFT", action = wezterm.action({ SendString = "\x02:" }) },
	{ key = "t", mods = "CMD", action = wezterm.action({ SendString = "\x02c" }) },
	{ key = "q", mods = "CMD", action = wezterm.action({ SendString = "\x02x" }) },
	{ key = "z", mods = "CMD", action = wezterm.action({ SendString = "\x02z" }) },
	{ key = "e", mods = "CMD", action = wezterm.action({ SendString = '\x02"' }) },
	{ key = "e", mods = "CMD|SHIFT", action = wezterm.action({ SendString = "\x02%" }) },
}

for i = 1, 8 do
	table.insert(config.keys, {
		key = "F" .. tostring(i),
		action = wezterm.action.ActivateTab(i - 1),
	})
end

return config
