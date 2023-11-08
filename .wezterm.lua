-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}
-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "Dracula (Official)"

config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.disable_default_key_bindings = true

config.window_decorations = "RESIZE | TITLE"
config.window_background_opacity = 1

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 22.0

config.keys = {
	{
		key = "t",
		mods = "CMD",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "e",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "e",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
	{ key = "c", mods = "CMD", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
	{ key = "v", mods = "CMD", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "q", mods = "CMD", action = wezterm.action({ SendString = "\x1b:q\n" }) },
	{ key = "s", mods = "CMD", action = wezterm.action({ SendString = "\x1b:w\n" }) },
	{ key = "s", mods = "CTRL", action = wezterm.action({ SendString = "\x1b:w\n" }) },
	{ key = "s", mods = "CMD|SHIFT", action = wezterm.action({ SendString = "\x1b:wa\n" }) },
	-- { key = "1", mods = "CMD",action = wezterm.action({ SendString = "\x021" })},
	-- { key = ",", mods = "CMD", action = wezterm.action({ SendString = "\x02," })},
	-- { key = "m", mods = "CTRL",action = wezterm.action({ SendString = "\x02\\" })},
	-- { key = "w", mods = "CMD", action = wezterm.action({ SendString = "\x02x" }) },
	-- { key = "t", mods = "CMD", action = wezterm.action({ SendString = "\x02c" }) },
	-- { key = ":", mods = "CTRL|SHIFT", action = wezterm.action({ SendString = "\x02:" }) },
	-- { key = "e", mods = "CMD|SHIFT", action = wezterm.action({ SendString = "\x02%" }) },
	-- { key = "e", mods = "CMD", action = wezterm.action({ SendString = '\x02"' }) },
	-- { key = "z", mods = "CMD", action = wezterm.action({ SendString = "\x02z" }) },
}

for i = 1, 8 do
	-- CTRL+ALT + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CMD",
		action = wezterm.action.ActivateTab(i - 1),
	})
	-- F1 through F8 to activate that tab
	table.insert(config.keys, {
		key = "F" .. tostring(i),
		action = wezterm.action.ActivateTab(i - 1),
	})
end

-- and finally, return the configuration to wezterm
return config
