local wezterm = require("wezterm")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local icons = wezterm.nerdfonts

local M = {}

local function get_icon(title)
	if title == "nvim" or title == "vim" then
		return icons.custom_neovim
	elseif title == "lazygit" then
		return icons.dev_git
	elseif title == "lazydocker" then
		return icons.dev_docker
	elseif title == "atac" or title == "apis" then
		return icons.md_api
	end
	return icons.oct_terminal
end

local function tab_title(tab)
	if tab.tab_title and #tab.tab_title > 0 then
		return tab.tab_title
	end
	local active_pane_title = tab.active_pane.title
	if string.match(active_pane_title, "^~") ~= nil then
		return icons.oct_terminal
	end
	if string.match(active_pane_title, "^%.%.") ~= nil then
		return icons.oct_terminal
	end
	return get_icon(tab.active_pane.title)
end

local function process_name(tab)
	if tab.tab_title and #tab.tab_title > 0 then
		return tab.tab_title
	end
	local active_pane_title = tab.active_pane.title
	return active_pane_title
end

local function get_config(c)
	return {
		options = {
			icons_enabled = true,
			theme = c.colors,
			tabs_enabled = true,
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
			tab_active = { tab_title, " ", process_name },
			tab_inactive = { tab_title },
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

	c.show_tabs_in_tab_bar = true
end

M.apply_to_config = apply_to_config

return M
