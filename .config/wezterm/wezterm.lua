local wezterm = require "wezterm"
local config = wezterm.config_builder()

local function is_vim(pane)
  return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

local function active_tab_idx(mux_win)
  for _, item in ipairs(mux_win:tabs_with_info()) do
    if item.is_active then
      return item.index
    end
  end
end

local function split_nav(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == "resize" and "META" or "CTRL",
    action = wezterm.action_callback(function(win, pane)
      if is_vim(pane) then
        win:perform_action({ SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" } }, pane)
      else
        if resize_or_move == "resize" then
          win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
        else
          win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
        end
      end
    end),
  }
end

local function get_current_working_dir(tab)
  local current_dir = tab.active_pane and tab.active_pane.current_working_dir or { file_path = "" }
  local HOME_DIR = string.format("file://%s", os.getenv "HOME")
  return current_dir == HOME_DIR and "." or string.gsub(current_dir.file_path, "(.*[/\\])(.*)", "%2")
end

local function tab_title(tab)
  if tab.tab_title and #tab.tab_title > 0 then
    return tab.tab_title
  end
  return get_current_working_dir(tab)
end

-- Set tab title to the current working directory
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local index = tonumber(tab.tab_index) + 1
  return string.format(" %s: %s ", index, tab_title(tab))
end)

-- Set window title to the current working directory
wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
  return tab_title(tab)
end)

-- Workaround to autoreload config on WSL environment
wezterm.on("user-var-changed", function(window, pane, name, value)
  if name == "reload_configuration" then
    wezterm.reload_configuration()
  end
end)

config.default_domain = "WSL:Ubuntu-22.04"
config.color_scheme = "Catppuccin Mocha"
config.font = wezterm.font("Berkeley Mono", { weight = "Bold" })
config.force_reverse_video_cursor = true
config.font_size = 11
config.hide_tab_bar_if_only_one_tab = true
config.audible_bell = "Disabled"
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.enable_scroll_bar = false
config.tab_max_width = 32
config.scrollback_lines = 10000
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.leader = { mods = "CTRL", key = "f" }
config.keys = {
  { key = "s", mods = "LEADER", action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
  { key = "v", mods = "LEADER", action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
  { key = "n", mods = "LEADER", action = wezterm.action { ActivateTabRelative = 1 } },
  { key = "p", mods = "LEADER", action = wezterm.action { ActivateTabRelative = -1 } },
  { key = "x", mods = "LEADER", action = wezterm.action { CloseCurrentPane = { confirm = false } } },
  { key = "{", mods = "CTRL|SHIFT", action = wezterm.action { MoveTabRelative = -1 } },
  { key = "}", mods = "CTRL|SHIFT", action = wezterm.action { MoveTabRelative = 1 } },
  { key = "J", mods = "CTRL|SHIFT", action = wezterm.action { RotatePanes = "Clockwise" } },
  { key = "K", mods = "CTRL|SHIFT", action = wezterm.action { RotatePanes = "CounterClockwise" } },
  {
    key = "c",
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      local mux_win = win:mux_window()
      local idx = active_tab_idx(mux_win)
      local tab = mux_win:spawn_tab {}
      win:perform_action(wezterm.action.MoveTab(idx + 1), pane)
    end),
  },
  {
    key = "!",
    mods = "LEADER|SHIFT",
    action = wezterm.action_callback(function(win, pane)
      local tab, window = pane:move_to_new_tab()
    end),
  },
  {
    key = "l",
    mods = "LEADER",
    action = wezterm.action.Multiple {
      wezterm.action.ClearScrollback "ScrollbackAndViewport",
      wezterm.action.SendKey { key = "L", mods = "CTRL" },
    },
  },
  {
    key = ",",
    mods = "LEADER",
    action = wezterm.action.PromptInputLine {
      description = "Enter new name for tab",
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },

  -- move between split panes
  split_nav("move", "h"),
  split_nav("move", "j"),
  split_nav("move", "k"),
  split_nav("move", "l"),

  -- resize panes
  split_nav("resize", "h"),
  split_nav("resize", "j"),
  split_nav("resize", "k"),
  split_nav("resize", "l"),
}

return config
