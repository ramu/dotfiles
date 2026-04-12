local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- ==========================================================
-- Appearance
-- ==========================================================

-- Color scheme: modern dark theme
config.color_scheme = "Tokyo Night"

-- Background opacity
config.window_background_opacity = 0.85
config.macos_window_background_blur = 20

-- Window
config.native_macos_fullscreen_mode = false
config.window_decorations = "RESIZE"
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}
config.adjust_window_size_when_changing_font_size = false
config.window_close_confirmation = "NeverPrompt"

-- Tab bar
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32
config.show_new_tab_button_in_tab_bar = false

-- ==========================================================
-- Font
-- ==========================================================

config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 12.0
config.line_height = 1.2
config.cell_width = 1.0

-- Disable ligatures for monospace clarity
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }

-- ==========================================================
-- Cursor
-- ==========================================================

config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- ==========================================================
-- Scrollback & Performance
-- ==========================================================

config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.max_fps = 120
config.animation_fps = 60

-- ==========================================================
-- Key bindings
-- ==========================================================

config.keys = {
  -- Toggle fullscreen
  { key = "Enter", mods = "CMD", action = wezterm.action.ToggleFullScreen },

  -- Pane splitting (like tmux)
  { key = "d", mods = "CMD", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "d", mods = "CMD|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

  -- Pane navigation
  { key = "h", mods = "CMD|OPT", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "j", mods = "CMD|OPT", action = wezterm.action.ActivatePaneDirection("Down") },
  { key = "k", mods = "CMD|OPT", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "l", mods = "CMD|OPT", action = wezterm.action.ActivatePaneDirection("Right") },

  -- Pane resize
  { key = "h", mods = "CMD|OPT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
  { key = "j", mods = "CMD|OPT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
  { key = "k", mods = "CMD|OPT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
  { key = "l", mods = "CMD|OPT|SHIFT", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },

  -- Close pane
  { key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = true }) },

  -- Quick select mode (URL, hash, path, etc.)
  { key = "Space", mods = "CMD|SHIFT", action = wezterm.action.QuickSelect },

  -- Font size
  { key = "0", mods = "CMD", action = wezterm.action.ResetFontSize },
}

-- ==========================================================
-- Startup: fullscreen
-- ==========================================================

wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

return config
