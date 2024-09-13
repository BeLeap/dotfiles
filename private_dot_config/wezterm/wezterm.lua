local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.automatically_reload_config = true

config.color_scheme = 'One Dark (Gogh)'

return config
