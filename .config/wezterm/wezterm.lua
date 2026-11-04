---@diagnostic disable: undefined-field
local wezterm = require "wezterm"
local smart_splits = wezterm.plugin.require "https://github.com/smart-splits-nvim/backend-wezterm"
local config = wezterm.config_builder()

local function active_tab_idx(mux_win)
  for _, item in ipairs(mux_win:tabs_with_info()) do
    if item.is_active then
      return item.index
    end
  end
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
wezterm.on("format-tab-title", function(tab)
  local index = tonumber(tab.tab_index) + 1
  return string.format(" %s: %s ", index, tab_title(tab))
end)

-- Set window title to the current working directory
wezterm.on("format-window-title", function(tab)
  return tab_title(tab)
end)

config.default_domain = "WSL:Ubuntu-22.04"
-- Herdr's "graphite" palette
config.colors = {
  foreground = "#d2d4d9",
  background = "#17191d",
  cursor_bg = "#d2d4d9",
  cursor_fg = "#17191d",
  cursor_border = "#d2d4d9",
  selection_bg = "#394454",
  selection_fg = "#eeeeef",
  split = "#2c2e31",
  ansi = { "#45484f", "#dc8c95", "#a6bd91", "#d8be87", "#96b2d7", "#b5a2ce", "#8cbdc3", "#d2d4d9" },
  brights = { "#818793", "#f0a5ad", "#bad5a2", "#ead2a1", "#b0cbef", "#cbb7e6", "#a4d5db", "#f0f0f2" },
  tab_bar = {
    background = "#101114",
    active_tab = { bg_color = "#17191d", fg_color = "#eeeeef" },
    inactive_tab = { bg_color = "#101114", fg_color = "#98999b" },
    inactive_tab_hover = { bg_color = "#25272b", fg_color = "#d2d4d9" },
    new_tab = { bg_color = "#101114", fg_color = "#696a6d" },
    new_tab_hover = { bg_color = "#25272b", fg_color = "#d2d4d9" },
  },
}
config.font = wezterm.font("Berkeley Mono", { weight = "Bold" })
config.force_reverse_video_cursor = true
config.canonicalize_pasted_newlines = "None"
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

config.mouse_bindings = {
  {
    mods = "NONE",
    event = { Down = { streak = 1, button = "Right" } },
    action = wezterm.action.PasteFrom "Clipboard",
  },
  {
    mods = "NONE",
    event = { Down = { streak = 3, button = "Left" } },
    action = wezterm.action.SelectTextAtMouseCursor "SemanticZone",
  },
}

config.leader = { mods = "CTRL", key = "f" }
config.keys = {
  { key = "s", mods = "LEADER", action = wezterm.action.SplitPane { direction = "Down", size = { Cells = 15 } } },
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
      mux_win:spawn_tab {}
      win:perform_action(wezterm.action.MoveTab(idx + 1), pane)
    end),
  },
  {
    key = "!",
    mods = "LEADER|SHIFT",
    action = wezterm.action_callback(function(_, pane)
      pane:move_to_new_tab()
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
      action = wezterm.action_callback(function(window, _, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
}

-- Forward WEZTERM_PANE and the plugin's SMART_SPLITS_WEZTERM handshake into WSL,
-- otherwise the Neovim backend's detect() fails. WezTerm appends its TERM vars to this.
config.set_environment_variables = { WSLENV = "WEZTERM_PANE:SMART_SPLITS_WEZTERM" }

-- Owns CTRL+hjkl (move) and META+hjkl (resize), forwarding to Neovim when IS_NVIM is set.
smart_splits.apply_to_config(config, {
  direction_keys = { "h", "j", "k", "l" },
  modifiers = { move = "CTRL", resize = "META" },
  at_edge = "stop",
})

return config
