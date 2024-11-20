local wezterm = require("wezterm")
local M = {}

---@param config Config
function M.setup(config)
  config.unix_domains = {
    {
      name = 'unix',
    },
  }
end
