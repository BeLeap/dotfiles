local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.automatically_reload_config = true

config.font = wezterm.font 'Cascadia Code'
config.font_size = 17

config.color_scheme = 'One Dark (Gogh)'
config.enable_tab_bar = false

return config
