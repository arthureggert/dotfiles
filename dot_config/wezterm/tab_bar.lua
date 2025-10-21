local wezterm = require("wezterm")
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local icons = wezterm.nerdfonts

local M = {}

local function get_icon(title)
	if title == "nvim" or title == "vim" then
		return icons.custom_neovim
	elseif title == "lazygit" or title == "lg" then
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
		return icons.cod_home
	end
	if string.match(active_pane_title, "^%.%.") ~= nil then
		return icons.custom_folder_open
	end
	return get_icon(tab.active_pane.title)
end

local function process_name(tab)
	if tab.tab_title and #tab.tab_title > 0 then
		return tab.tab_title
	end
	local active_pane_title = tab.active_pane.title
	if string.match(active_pane_title, "^~") ~= nil then
		return active_pane_title
	end
	if string.match(active_pane_title, "^%.%.") ~= nil then
		return active_pane_title:match("([^/\\]+)[/\\]?$")
	end
	return active_pane_title
end

local function tab_active(tab)
	return tab_title(tab) .. " " .. process_name(tab)
end

local function get_config(c)
	local is_work = os.getenv("USER") == "arthur.eggert"
	local tabline_x = {}

	if is_work == true then
		table.insert(tabline_x, "battery")
	end

	return {
		options = {
			icons_enabled = true,
			tabs_enabled = true,
			colors = c.colors,
			theme_overrides = {
				normal_mode = {
					a = { fg = "#0B0D0F", bg = "#8AFF80" },
					b = { fg = "#0B0D0F", bg = "#9580FF" },
					c = { fg = "#0B0D0F", bg = "#0B0D0F" },
				},
				copy_mode = {
					a = { fg = "#0B0D0F", bg = "#FFFF99" },
					b = { fg = "#0B0D0F", bg = "#9580FF" },
					c = { fg = "#0B0D0F", bg = "#0B0D0F" },
				},
				search_mode = {
					a = { fg = "#0B0D0F", bg = "#FF99CC" },
					b = { fg = "#0B0D0F", bg = "#9580FF" },
					c = { fg = "#0B0D0F", bg = "#0B0D0F" },
				},
				window_mode = {
					a = { fg = "#0B0D0F", bg = "#99FFEE" },
					b = { fg = "#0B0D0F", bg = "#9580FF" },
					c = { fg = "#0B0D0F", bg = "#0B0D0F" },
				},
				-- Default tab colors
				tab = {
					active = { fg = "#0B0D0F", bg = "#708CA9" },
					inactive = { fg = "#F8F8F2", bg = "#0B0D0F" },
					inactive_hover = { fg = "#F8F8F2", bg = "#708CA9" },
				},
			},
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
			tab_active = { tab_active },
			tab_inactive = { tab_active },
			tabline_x = tabline_x,
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
