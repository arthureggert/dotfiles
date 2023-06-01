-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.color_scheme = "Dracula (Official)"

config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.enable_tab_bar = false

config.window_decorations = "RESIZE"
config.window_background_opacity = 0.95

config.disable_default_key_bindings = true

config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 22.0

config.keys = {
	{
		key = "m",
		mods = "CTRL",
		action = wezterm.action({ SendString = "\x02\\" }),
	},
	{
		key = "1",
		mods = "CMD",
		action = wezterm.action({ SendString = "\x021" }),
	},
	{
		key = "2",
		mods = "CMD",
		action = wezterm.action({ SendString = "\x022" }),
	},
	{
		key = "3",
		mods = "CMD",
		action = wezterm.action({ SendString = "\x023" }),
	},
	{
		key = "4",
		mods = "CMD",
		action = wezterm.action({ SendString = "\x024" }),
	},
	{
		key = "5",
		mods = "CMD",
		action = wezterm.action({ SendString = "\x025" }),
	},
	{
		key = "6",
		mods = "CMD",
		action = wezterm.action({ SendString = "\x026" }),
	},
	{
		key = "7",
		mods = "CMD",
		action = wezterm.action({ SendString = "\x027" }),
	},
	{
		key = "8",
		mods = "CMD",
		action = wezterm.action({ SendString = "\x028" }),
	},
	{
		key = "9",
		mods = "CMD",
		action = wezterm.action({ SendString = "\x029" }),
	},
	{
		key = ",",
		mods = "CMD",
		action = wezterm.action({ SendString = "\x02," }),
	},
	{ key = "e", mods = "CMD", action = wezterm.action({ SendString = '\x02"' }) },
	{ key = "e", mods = "CMD|SHIFT", action = wezterm.action({ SendString = "\x02%" }) },
	{ key = "q", mods = "CTRL", action = wezterm.action({ SendString = "\x1b:q\n" }) },
	{ key = "s", mods = "CMD", action = wezterm.action({ SendString = "\x1b:w\n" }) },
	{ key = "s", mods = "CTRL", action = wezterm.action({ SendString = "\x1b:w\n" }) },
	{ key = "s", mods = "CMD|SHIFT", action = wezterm.action({ SendString = "\x1b:wa\n" }) },
	{ key = ":", mods = "CTRL|SHIFT", action = wezterm.action({ SendString = "\x02:" }) },
	{ key = "t", mods = "CMD", action = wezterm.action({ SendString = "\x02c" }) },
	{ key = "w", mods = "CMD", action = wezterm.action({ SendString = "\x02x" }) },
	{ key = "z", mods = "CMD", action = wezterm.action({ SendString = "\x02z" }) },
	{
		key = "c",
		mods = "CMD",
		action = wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
	},
	{ key = "v", mods = "CMD", action = wezterm.action.PasteFrom("Clipboard") },
}

-- and finally, return the configuration to wezterm
return config
