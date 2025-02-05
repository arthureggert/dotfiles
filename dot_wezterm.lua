local wezterm = require("wezterm")

local config = wezterm.config_builder()

local function get_icon(title)
	if title == "nvim" or title == "vim" then
		return ""
	elseif title == "lazygit" then
		return ""
	elseif title == "atac" or title == "apis" then
		return "󱂛"
	end
	-- return " (" .. title .. ")"
	return ""
end

local function get_window_title(tab)
	if tab.tab_title and #tab.tab_title > 0 then
		return tab.tab_title
	end

	local active_pane_title = tab.active_pane.title

	if string.match(active_pane_title, "^~") ~= nil then
		return ""
	end

	if string.match(active_pane_title, "^%.%.") ~= nil then
		return ""
	end

	return get_icon(tab.active_pane.title)
end

local TAB_BAR_BG = "#181825"
local ACTIVE_TAB_BG = "#cba6f7"
local ACTIVE_TAB_FG = "#11111b"
local INACTIVE_TAB_BG = "#585b70"
local INACTIVE_TAB_FG = "#181825"
local HOVER_TAB_BG = "#cba6f7"
local HOVER_TAB_FG = "#2B2B2B"
local NEW_TAB_BG = INACTIVE_TAB_BG
local NEW_TAB_FG = INACTIVE_TAB_FG

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.show_new_tab_button_in_tab_bar = true
config.show_tab_index_in_tab_bar = true
config.show_tabs_in_tab_bar = true
config.switch_to_last_active_tab_when_closing_tab = false
config.tab_and_split_indices_are_zero_based = false
config.tab_bar_at_bottom = false
config.tab_max_width = 25
config.use_fancy_tab_bar = true

config.window_frame = {
	font_size = 16.0,
}

config.colors = {
	tab_bar = {
		background = TAB_BAR_BG,
		active_tab = {
			bg_color = ACTIVE_TAB_BG,
			fg_color = ACTIVE_TAB_FG,
			intensity = "Normal",
			underline = "None",
			italic = false,
			strikethrough = false,
		},
		inactive_tab = {
			bg_color = INACTIVE_TAB_BG,
			fg_color = INACTIVE_TAB_FG,
		},
		inactive_tab_hover = {
			bg_color = HOVER_TAB_BG,
			fg_color = HOVER_TAB_FG,
			italic = true,
		},
		new_tab = {
			bg_color = NEW_TAB_BG,
			fg_color = NEW_TAB_FG,
		},
		new_tab_hover = {
			bg_color = HOVER_TAB_BG,
			fg_color = HOVER_TAB_FG,
			italic = true,
		},
	},
}

wezterm.on("format-tab-title", function(tab, tabs, _, _, hover, _)
	local background = NEW_TAB_BG
	local foreground = NEW_TAB_FG

	local is_first = tab.tab_id == tabs[1].tab_id

	if tab.is_active then
		background = ACTIVE_TAB_BG
		foreground = ACTIVE_TAB_FG
	elseif hover then
		background = HOVER_TAB_BG
		foreground = HOVER_TAB_FG
	end

	local leading_bg = background
	local trailing_fg = background

	local function check_start_arrow()
		return " "
	end

	local title = get_window_title(tab)
	if is_first then
		title = title .. " "
	else
		title = " " .. title .. " "
	end

	return {
		{
			Background = {
				Color = leading_bg,
			},
		},
		{
			Foreground = {
				Color = TAB_BAR_BG,
			},
		},
		{
			Text = check_start_arrow(),
		},
		{
			Attribute = {
				Intensity = "Half",
			},
		},
		{
			Background = {
				Color = background,
			},
		},
		{
			Foreground = {
				Color = foreground,
			},
		}, -- { Text = string.format(" %s", tab.tab_index + 1) },
		{
			Attribute = {
				Intensity = "Normal",
			},
		},
		{
			Background = {
				Color = background,
			},
		},
		{
			Foreground = {
				Color = foreground,
			},
		},
		{
			Text = string.format("%s", title),
		},
		{
			Background = {
				Color = TAB_BAR_BG,
			},
		},
		{
			Foreground = {
				Color = trailing_fg,
			},
		},
		-- {
		-- 	Text = SOLID_RIGHT_ARROW,
		-- },
	}
end)

-- Inactiva Panes Have DIM
config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.2,
}

config.color_scheme = "Catppuccin Macchiato"

config.disable_default_key_bindings = true
-- config.send_composed_key_when_left_alt_is_pressed = true
-- config.send_composed_key_when_right_alt_is_pressed = true
config.font_size = 18.0

config.window_decorations = "TITLE | RESIZE"
config.window_background_opacity = 1
config.integrated_title_button_alignment = "Left"
config.integrated_title_button_style = "Windows"
config.integrated_title_buttons = { "Hide", "Maximize", "Close" }

config.keys = {
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
	{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	-- 	-- { key = "w", mods = "CMD", action = wezterm.action({ SendString = "\x1b:bd\n" }) },
	{ key = "s", mods = "CMD", action = wezterm.action({ SendString = "\x1b:w\n" }) },
	-- 	-- { key = "s", mods = "CTRL", action = wezterm.action({ SendString = "\x1b:w\n" }) },
	-- 	-- { key = "s", mods = "CMD|SHIFT", action = wezterm.action({ SendString = "\x1b:wa\n" }) },
	{ key = "v", mods = "CMD", action = wezterm.action({ PasteFrom = "Clipboard" }) },
	{ key = "c", mods = "CMD", action = wezterm.action({ CopyTo = "Clipboard" }) },
	-- 	-- { key = ":", mods = "CTRL|SHIFT", action = wezterm.action({ SendString = "\x02:" }) },
	-- 	{ key = "t", mods = "CMD", action = wezterm.action({ SendString = "\x02c" }) },
	-- 	{ key = "q", mods = "CMD", action = wezterm.action({ SendString = "\x02x" }) },
	-- 	{ key = "z", mods = "CMD", action = wezterm.action({ SendString = "\x02z" }) },
	-- 	{ key = "e", mods = "CMD|SHIFT", action = wezterm.action({ SendString = '\x02"' }) },
	-- 	{ key = "e", mods = "CMD", action = wezterm.action({ SendString = "\x02%" }) },
}

for i = 1, 8 do
	table.insert(config.keys, {
		key = "F" .. tostring(i),
		action = wezterm.action.ActivateTab(i - 1),
		-- action = wezterm.action({ SendString = "\x02" .. tostring(i - 1) }),
	})
end

return config
