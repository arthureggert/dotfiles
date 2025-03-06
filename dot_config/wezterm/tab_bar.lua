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
	return tab.active_pane.title
end

local colors = {
	rosewater = "#f5e0dc",
	flamingo = "#f2cdcd",
	pink = "#f5c2e7",
	mauve = "#cba6f7",
	red = "#f38ba8",
	maroon = "#eba0ac",
	peach = "#fab387",
	yellow = "#f9e2af",
	green = "#a6e3a1",
	teal = "#94e2d5",
	sky = "#89dceb",
	sapphire = "#74c7ec",
	blue = "#89b4fa",
	lavender = "#b4befe",
	text = "#cdd6f4",
	subtext1 = "#bac2de",
	subtext0 = "#a6adc8",
	overlay2 = "#9399b2",
	overlay1 = "#7f849c",
	overlay0 = "#6c7086",
	surface2 = "#585b70",
	surface1 = "#45475a",
	surface0 = "#313244",
	base = "#1e1e2e",
	mantle = "#181825",
	crust = "#11111b",
}

local function get_config(c)
	local is_work = os.getenv("USER") == "arthur.eggert"
	local tabline_x = { "ram", "cpu" }

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
					a = { fg = colors.mantle, bg = colors.peach },
					b = { fg = colors.blue, bg = colors.surface0 },
					c = { fg = colors.text, bg = colors.mantle },
				},
				copy_mode = {
					a = { fg = colors.mantle, bg = colors.yellow },
					b = { fg = colors.yellow, bg = colors.surface0 },
					c = { fg = colors.text, bg = colors.mantle },
				},
				search_mode = {
					a = { fg = "#181825", bg = "#a6e3a1" },
					b = { fg = "#a6e3a1", bg = "#313244" },
					c = { fg = "#cdd6f4", bg = "#181825" },
				},
				-- Defining colors for a new key table
				window_mode = {
					a = { fg = "#181825", bg = "#cba6f7" },
					b = { fg = "#cba6f7", bg = "#313244" },
					c = { fg = "#cdd6f4", bg = "#181825" },
				},
				-- Default tab colors
				tab = {
					active = { fg = colors.yellow, bg = "#313244" },
					inactive = { fg = "#cdd6f4", bg = "#181825" },
					inactive_hover = { fg = "#f5c2e7", bg = "#313244" },
				},
				-- normal_mode = {
				-- 	a = { bg = colors.peach },
				-- 	x = { fg = colors.text },
				-- 	y = { fg = colors.mauve },
				-- },
				-- tab = {
				-- 	active = { fg = colors.lavender },
				-- 	inactive = { fg = colors.overlay0 },
				-- 	inactive_hover = { fg = colors.yellow },
				-- },
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
			tab_active = { tab_title, " ", process_name },
			tab_inactive = { tab_title },
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
