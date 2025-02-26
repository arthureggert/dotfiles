local wezterm = require("wezterm")
local mappings = require("mappings")
local theme = require("theme")
local tab_bar = require("tab_bar")

local config = wezterm.config_builder()

config.font = wezterm.font("Hack Nerd Font")
config.disable_default_key_bindings = true
config.font_size = 20.0
config.window_background_opacity = 0.85

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.2,
}

mappings.apply_to_config(config)
theme.apply_to_config(config)
tab_bar.apply_to_config(config)

return config
