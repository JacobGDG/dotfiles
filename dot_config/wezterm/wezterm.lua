local wezterm = require("wezterm")
local config = wezterm.config_builder()
wezterm.log_info("reloading")

config.window_padding = { left = 0, right = 0, top = 0, bottom = 0}
config.color_scheme = 'GruvboxDark'

config.font_size = 10
config.font = wezterm.font("Hack Nerd Font Mono")

config.scrollback_lines = 10000

config.hide_tab_bar_if_only_one_tab = true

config.default_prog = { "tmux" }
config.default_workspace = "home"

return config
