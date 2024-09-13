local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.automatically_reload_config = true

config.font = wezterm.font 'Cascadia Code'
config.font_size = 14

config.color_scheme = 'One Dark (Gogh)'

return config
