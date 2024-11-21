local wezterm = require("wezterm") --[[@as Wezterm]]
local act = wezterm.action
local M = {}

local function is_vim(pane)
  -- this is set by the smart-splits, and unset on ExitPre in Neovim
  return pane:get_user_vars().IS_NVIM == 'true'
end

local direction_keys = {
  h = 'Left',
  j = 'Down',
  k = 'Up',
  l = 'Right',
}

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == 'resize' and 'META' or 'CTRL',
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        -- pass the keys through to vim/nvim
        win:perform_action({
          SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' },
        }, pane)
      else
        if resize_or_move == 'resize' then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

---@param config Config
function M.setup(config)
  config.disable_default_key_bindings = true
  config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
  config.keys = {

    {
      mods = 'LEADER',
      key = 'Escape',
      action = wezterm.action.ActivateCommandPalette,
    },

    { mods = 'CTRL|SHIFT', key = 'v', action = act.PasteFrom 'Clipboard' },


    { mods = 'CTRL|SHIFT', key = 'l', action = act.ClearScrollback 'ScrollbackAndViewport' },
    -- VIM MODE
    {  mods = 'LEADER', key = 'Enter', action = act.ActivateCopyMode },
    {  mods = 'LEADER', key = 'Space', action = act.QuickSelect },

    -- PANES
    { mods = "LEADER", key = "h", action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { mods = "LEADER", key = "g", action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },

    { mods = 'LEADER', key = 'z', action = act.TogglePaneZoomState },

    -- move between split panes
    split_nav('move', 'h'),
    split_nav('move', 'j'),
    split_nav('move', 'k'),
    split_nav('move', 'l'),
    -- resize panes
    split_nav('resize', 'h'),
    split_nav('resize', 'j'),
    split_nav('resize', 'k'),
    split_nav('resize', 'l'),

    -- TABS
    { mods = 'LEADER', key = 'c', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'n', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(1) },
    { key = 'p', mods = 'LEADER', action = wezterm.action.ActivateTabRelative(-1) },
    { key = 'w', mods = 'LEADER', action = act.ShowTabNavigator },

    -- WORKSPACES
    { mods = 'LEADER', key = 's', action = act.ShowLauncherArgs { flags = 'WORKSPACES' } },
    {
      mods = 'LEADER',
      key = 'n',
      action = act.PromptInputLine {
        description = wezterm.format {
          { Attribute = { Intensity = 'Bold' } },
          { Foreground = { AnsiColor = 'Fuchsia' } },
          { Text = 'Enter name for new workspace' },
        },
        action = wezterm.action_callback(function(window, pane, line)
          -- line will be `nil` if they hit escape without entering anything
          -- An empty string if they just hit enter
          -- Or the actual line of text they wrote
          if line then
            window:perform_action(
              act.SwitchToWorkspace {
                name = line,
              },
              pane
            )
          end
        end),
      },
    },
    { key = 'n', mods = 'LEADER|SHIFT', action = act.SwitchWorkspaceRelative(1) },
    { key = 'p', mods = 'LEADER|SHIFT', action = act.SwitchWorkspaceRelative(-1) },
  }
end

return M
