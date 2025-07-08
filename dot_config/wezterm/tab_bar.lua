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

local colors = {
	bg = "#282a36",
	black = "#21222c",
	red = "#ff5555",
	green = "#50fa7b",
	yellow = "#f1fa8c",
	purple = "#bd93f9",
	pink = "#ff79c6",
	blue = "#8be9fd",
	white = "#f8f8f2",
	light_black = "#6272a4",
	light_red = "#ff6e6e",
	light_green = "#69ff94",
	light_yellow = "#ffffa5",
	light_purple = "#d6acff",
	light_pink = "#ff92df",
	light_blue = "#a4ffff",
	light_white = "#ffffff",
}

local function get_config(c)
	local is_work = os.getenv("USER") == "arthur.eggert"
	local tabline_x = {}

	if is_work then
		table.insert(tabline_x, "battery")
	end

	return {
		options = {
			icons_enabled = true,
			theme = c.colors,
			tabs_enabled = true,
			theme_overrides = {
				normal_mode = {
					a = { fg = colors.black, bg = colors.green },
					b = { fg = colors.black, bg = colors.purple },
					c = { fg = colors.black, bg = colors.bg },
				},
				copy_mode = {
					a = { fg = colors.black, bg = colors.green },
					b = { fg = colors.black, bg = colors.purple },
					c = { fg = colors.black, bg = colors.bg },
				},
				search_mode = {
					a = { fg = colors.mantle, bg = colors.yellow },
					b = { fg = colors.yellow, bg = colors.surface0 },
					c = { fg = colors.text, bg = colors.mantle },
				},
				window_mode = {
					a = { fg = colors.mantle, bg = colors.green },
					b = { fg = colors.green, bg = colors.surface0 },
					c = { fg = colors.text, bg = colors.mantle },
				},
				-- Default tab colors
				tab = {
					active = { fg = colors.black, bg = colors.pink },
					inactive = { fg = colors.white, bg = colors.bg },
					inactive_hover = { fg = colors.white, bg = colors.light_black },
				},
			},
			section_separators = {
				-- left = wezterm.nerdfonts.pl_left_hard_divider,
				-- right = wezterm.nerdfonts.pl_right_hard_divider,
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
