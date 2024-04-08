local wezterm = require("wezterm")

local module = {}

local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

local TAB_BAR_BG = "#181825"

local ACTIVE_TAB_BG = "#89b4fa"
local ACTIVE_TAB_FG = "#1e1e2e"

local INACTIVE_TAB_BG = "#313244"
local INACTIVE_TAB_FG = "#bac2de"

local HOVER_TAB_BG = "#74c7ec"
local HOVER_TAB_FG = "#2B2B2B"

local NEW_TAB_BG = INACTIVE_TAB_BG
local NEW_TAB_FG = INACTIVE_TAB_FG

function module.setup(config)
	-- Custom Tab Colors
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

	-- Custom New Plus Button
	config.tab_bar_style = {
		new_tab = wezterm.format({
			{ Background = { Color = INACTIVE_TAB_BG } },
			{ Foreground = { Color = TAB_BAR_BG } },
			{ Text = SOLID_RIGHT_ARROW },
			{ Background = { Color = INACTIVE_TAB_BG } },
			{ Foreground = { Color = INACTIVE_TAB_FG } },
			{ Text = " + " },
			{ Background = { Color = TAB_BAR_BG } },
			{ Foreground = { Color = INACTIVE_TAB_BG } },
			{ Text = SOLID_RIGHT_ARROW },
		}),
		new_tab_hover = wezterm.format({
			{ Attribute = { Italic = false } },
			{ Background = { Color = HOVER_TAB_BG } },
			{ Foreground = { Color = TAB_BAR_BG } },
			{ Text = SOLID_RIGHT_ARROW },
			{ Background = { Color = HOVER_TAB_BG } },
			{ Foreground = { Color = HOVER_TAB_FG } },
			{ Text = " + " },
			{ Background = { Color = TAB_BAR_BG } },
			{ Foreground = { Color = HOVER_TAB_BG } },
			{ Text = SOLID_RIGHT_ARROW },
		}),
	}
end

local function tab_title(tab_info)
	local title = tab_info.tab_title
	if title and #title > 0 then
		return title
	end
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, _, _, hover, max_width)
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
		if not is_first then
			return SOLID_RIGHT_ARROW
		else
			return " "
		end
	end

	local title = tab_title(tab)

	title = wezterm.truncate_right(title, max_width)

	return {
		{ Background = { Color = leading_bg } },
		{ Foreground = { Color = TAB_BAR_BG } },
		{ Text = check_start_arrow() },

		{ Attribute = { Intensity = "Half" } },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = string.format(" %s", tab.tab_index + 1) },
		{ Attribute = { Intensity = "Normal" } },

		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = " " .. title .. " " },

		{ Background = { Color = TAB_BAR_BG } },
		{ Foreground = { Color = trailing_fg } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

return module
