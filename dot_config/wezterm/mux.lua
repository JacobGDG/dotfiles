local wezterm = require("wezterm")
local mux = wezterm.mux
local M = {}

---@param config Config
function M.setup(config)
  config.unix_domains = {
    {
      name = 'unix',
    },
  }
  config.default_gui_startup_args = { 'connect', 'unix' }

  wezterm.on('gui-startup', function(cmd)
    local tab, pane, window = mux.spawn_window(cmd or {})
    window:gui_window():maximize()
  end)
end

return M
