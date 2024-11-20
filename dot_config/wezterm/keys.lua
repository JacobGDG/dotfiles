local wezterm = require("wezterm") --[[@as Wezterm]]
local act = wezterm.action
local M = {}

function M.is_nvim(pane)
  return pane:get_user_vars().IS_NVIM == "true" or pane:get_foreground_process_name():find("n?vim")
end

---@param config Config
function M.setup(config)
  config.disable_default_key_bindings = true
  config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
  config.keys = {

    { mods = 'CTRL|SHIFT', key = 'v', action = act.PasteFrom 'Clipboard' },


    { mods = 'CTRL|SHIFT', key = 'l', action = act.ClearScrollback 'ScrollbackAndViewport' },
    -- VIM MODE
    {  mods = 'LEADER', key = 'Enter', action = act.ActivateCopyMode },
    {  mods = 'LEADER', key = 'Space', action = act.QuickSelect },

    -- PANES
    { mods = "LEADER", key = "h", action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { mods = "LEADER", key = "g", action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },

    { mods = 'LEADER', key = 'z', action = act.TogglePaneZoomState },

    M.split_nav("resize", "CTRL", "LeftArrow", "Right"),
    M.split_nav("resize", "CTRL", "RightArrow", "Left"),
    M.split_nav("resize", "CTRL", "UpArrow", "Up"),
    M.split_nav("resize", "CTRL", "DownArrow", "Down"),
    M.split_nav("move", "CTRL", "h", "Left"),
    M.split_nav("move", "CTRL", "j", "Down"),
    M.split_nav("move", "CTRL", "k", "Up"),
    M.split_nav("move", "CTRL", "l", "Right"),

    -- TABS
    { mods = 'LEADER', key = 'c', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(1) },
    { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(-1) },
    { key = 'w', mods = 'LEADER', action = act.ShowTabNavigator },
    { mods = 'LEADER|CTRL', key = 'd', action = act.CloseCurrentTab{ confirm = true } },

    -- WORKSPACES
    { mods = 'LEADER', key = 's', action = act.ShowLauncherArgs { flags = 'WORKSPACES' } },
  }
end

---@param resize_or_move "resize" | "move"
---@param mods string
---@param key string
---@param dir "Right" | "Left" | "Up" | "Down"
function M.split_nav(resize_or_move, mods, key, dir)
  local event = "SplitNav_" .. resize_or_move .. "_" .. dir
  wezterm.on(event, function(win, pane)
    if M.is_nvim(pane) then
      -- pass the keys through to vim/nvim
      win:perform_action({ SendKey = { key = key, mods = mods } }, pane)
    else
      if resize_or_move == "resize" then
        win:perform_action({ AdjustPaneSize = { dir, 3 } }, pane)
      else
        local panes = pane:tab():panes_with_info()
        local is_zoomed = false
        for _, p in ipairs(panes) do
          if p.is_zoomed then
            is_zoomed = true
          end
        end
        wezterm.log_info("is_zoomed: " .. tostring(is_zoomed))
        if is_zoomed then
          dir = dir == "Up" or dir == "Right" and "Next" or "Prev"
          wezterm.log_info("dir: " .. dir)
        end
        win:perform_action({ ActivatePaneDirection = dir }, pane)
        win:perform_action({ SetPaneZoomState = is_zoomed }, pane)
      end
    end
  end)
  return {
    key = key,
    mods = mods,
    action = act.EmitEvent(event),
  }
end

function M.is_nvim(pane)
  return pane:get_user_vars().IS_NVIM == "true" or pane:get_foreground_process_name():find("n?vim")
end


return M
