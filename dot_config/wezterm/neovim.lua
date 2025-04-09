local M = {}
local wezterm = require("wezterm")

local function is_vim(pane)
	local process_name = pane:get_title()
	return process_name == "nvim" or process_name == "vim"
end

local function bind_super_key_to_vim(key, mods, vim_action, term_action)
	return {
		key = key,
		mods = mods,
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				win:perform_action(vim_action, pane)
			else
				win:perform_action(term_action, pane)
			end
		end),
	}
end

M.bind = bind_super_key_to_vim

return M
