local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local _tab, _pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

return {
	font = wezterm.font("Caskaydia Cove Nerd Font"),
	font_size = 14.0,
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = false,
}