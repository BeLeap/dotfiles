local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.automatically_reload_config = true

config.font = wezterm.font 'Cascadia Code'
config.font_size = 17

config.color_scheme = 'OneDark (base16)'
config.enable_tab_bar = false
config.window_decorations = "RESIZE"

return config
