local module = {}

local function get_icon(title)
	if title == "nvim" or title == "vim" then
		return ""
	elseif title == "lazygit" then
		return ""
	elseif title == "atac" or title == "apis" then
		return "󱂛"
	end
	return " (" .. title .. ")"
	-- return ""
end

module.get_window_title = function(tab)
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

	-- get the icon based on the process
	return get_icon(tab.active_pane.title)
end

return module
