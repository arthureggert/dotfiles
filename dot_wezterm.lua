local wezterm = require("wezterm")
local theme = require("theme")
local neovim = require("neovim")

local config = wezterm.config_builder()

config.color_scheme = color_scheme

config.enable_tab_bar = true

config.font = wezterm.font("Hack Nerd Font")
config.disable_default_key_bindings = true
config.font_size = 20.0

config.window_frame = {
	font_size = 16.0,
}

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.2,
}

config.keys = {
	{ key = "l", mods = "SHIFT|CTRL", action = "ShowDebugOverlay" },
	{ key = "t", mods = "CMD", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
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
		mods = "CMD",
		key = "LeftArrow",
		-- action = wezterm.action({ SendString = "\x02h" }),
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "CMD",
		-- action = wezterm.action({ SendString = "\x02l" }),
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "CMD",
		-- action = wezterm.action({ SendString = "\x02j" }),
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "CMD",
		-- action = wezterm.action({ SendString = "\x02k" }),
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{ key = "v", mods = "CMD", action = wezterm.action({ PasteFrom = "Clipboard" }) },
	{ key = "c", mods = "CMD", action = wezterm.action({ CopyTo = "Clipboard" }) },
	neovim.bind_super_key_to_vim(
		"w",
		{ SendString = "\x1b:bd\n" },
		wezterm.action.CloseCurrentPane({ confirm = true })
	),
	neovim.bind_super_key_to_vim("q", { SendString = "\x1b:qa\n" }, wezterm.action.CloseCurrentTab({ confirm = true })),
	neovim.bind_super_key_to_vim("s", { SendString = "\x1b:w\n" }),
	{
		key = "k",
		mods = "CMD",
		action = wezterm.action_callback(function(window, pane)
			theme.theme_switcher(window, pane)
		end),
	},
}

for i = 1, 8 do
	table.insert(config.keys, {
		key = "F" .. tostring(i),
		action = wezterm.action.ActivateTab(i - 1),
		-- action = wezterm.action({ SendString = "\x02" .. tostring(i - 1) }),
	})
end

return config
