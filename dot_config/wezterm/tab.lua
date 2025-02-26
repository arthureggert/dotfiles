local M = {}

local function get_icon(title)
	if title == "nvim" or title == "vim" then
		return ""
	elseif title == "lazygit" then
		return ""
	elseif title == "lazydocker" then
		return ""
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

