local wezterm = require("wezterm")
local neovim = require("neovim")

-- To send a command to TMUX it needs to be prefixed with \x02
-- To send a command to NVIM it needs to be prefixed with \x1b

local open_link_action = wezterm.action.QuickSelectArgs({
	label = "open url",
	patterns = { "https?://\\S+" },
	action = wezterm.action_callback(function(window, pane)
		local url = window:get_selection_text_for_pane(pane)
		wezterm.open_with(url)
	end),
})

local M = {}

local keys = {
	{ key = "l", mods = "SHIFT|CTRL", action = "ShowDebugOverlay" },
	{ key = "x", mods = "CTRL", action = wezterm.action.ActivateCopyMode },
	{ key = "p", mods = "CTRL", action = wezterm.action.ActivateCommandPalette },
	{ key = "t", mods = "CMD", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "e", mods = "CMD", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "e", mods = "CMD|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "LeftArrow", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Left") },
	{ key = "RightArrow", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Right") },
	{ key = "UpArrow", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Up") },
	{ key = "DownArrow", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Down") },
	{ key = "v", mods = "CMD", action = wezterm.action({ PasteFrom = "Clipboard" }) },
	{ key = "c", mods = "CMD", action = wezterm.action({ CopyTo = "Clipboard" }) },
	{ key = "o", mods = "CMD", action = open_link_action },
	neovim.bind("w", { SendString = "\x1b:bd\n" }, wezterm.action.CloseCurrentPane({ confirm = false })),
	neovim.bind("q", { SendString = "\x1b:qa\n" }, wezterm.action.CloseCurrentTab({ confirm = true })),
	neovim.bind("s", { SendString = "\x1b:w\n" }),
}

local mouse_keys = {
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CMD",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
}

local function apply_to_config(c)
	c.keys = keys
	c.mouse_bindings = mouse_keys

	for i = 1, 8 do
		table.insert(c.keys, {
			key = "F" .. tostring(i),
			action = wezterm.action.ActivateTab(i - 1),
		})
	end
end

M.apply_to_config = apply_to_config

return M
