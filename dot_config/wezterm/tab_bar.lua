local wezterm = require("wezterm")

local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")

local M = {}

local function get_config(c)
	return {
		options = {
			icons_enabled = true,
			theme = c.colors,
			tabs_enabled = false,
			theme_overrides = {},
			section_separators = {
				left = wezterm.nerdfonts.pl_left_hard_divider,
				right = wezterm.nerdfonts.pl_right_hard_divider,
			},
			component_separators = {
				left = wezterm.nerdfonts.pl_left_soft_divider,
				right = wezterm.nerdfonts.pl_right_soft_divider,
			},
			tab_separators = {
				left = wezterm.nerdfonts.pl_left_hard_divider,
				right = wezterm.nerdfonts.pl_right_hard_divider,
			},
		},
		sections = {
			tabline_a = { "mode" },
			tabline_b = {},
			tabline_c = {},
			tab_active = {},
			tab_inactive = {},
			tabline_x = { "ram", "cpu" },
			tabline_y = { "datetime" },
			tabline_z = {},
		},
		extensions = {},
	}
end

local function apply_to_config(c)
	tabline.setup(get_config(c))
	tabline.apply_to_config(c)
end

M.apply_to_config = apply_to_config

return M
