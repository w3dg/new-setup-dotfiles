-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action
local current_theme = 'dark'

local themes = {
  light = 'Tomorrow',
  dark =  'Tomorrow (dark) (terminal.sexy)',
    -- dark = 'carbonfox',
    -- light = 'dayfox',
}

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 135
config.initial_rows = 35

-- or, changing the font size and color scheme.
-- https://wezterm.org/colorschemes
config.font_size = 13
config.color_scheme = themes["dark"]


config.max_fps = 120
config.animation_fps = 1
config.window_background_opacity = 1
config.term = "xterm-256color"
config.warn_about_missing_glyphs = false
config.webgpu_power_preference = "HighPerformance"
config.prefer_egl = true
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

-- Font families with fallbacks
config.font = wezterm.font_with_fallback {
    'NotoMono Nerd Font',
    'RobotoMono Nerd Font',
    'Inconsolata Nerd Font',
    'FiraCode Nerd Font',
    'JetBrainsMono Nerd Font',
    'Noto Color Emoji'
    }

-- Scrollbar
config.enable_scroll_bar = true
config.scrollback_lines = 1000000

-- Keybinds
config.keys = {}

-- Theme toggle
wezterm.on('toggle-theme', function(window, _)
  current_theme = current_theme == 'dark' and 'light' or 'dark'
  window:set_config_overrides({
    color_scheme = themes[current_theme],
  })
end)

table.insert(config.keys, {
  key = "T",
  mods = "SHIFT|ALT",
  action = wezterm.action.EmitEvent("toggle-theme"),
})

-- Pane management
for _, v in ipairs({
  {"+", act.SplitPane{direction="Right", size={Percent=50}}},
  {"_", act.SplitPane{direction="Down", size={Percent=50}}},
}) do table.insert(config.keys, {mods="SHIFT|ALT", key=v[1], action=v[2]}) end

for _, v in ipairs({
  {"LeftArrow", act.ActivatePaneDirection'Left'},
  {"RightArrow", act.ActivatePaneDirection'Right'},
  {"UpArrow", act.ActivatePaneDirection'Up'},
  {"DownArrow", act.ActivatePaneDirection'Down'},
}) do table.insert(config.keys, {mods="ALT", key=v[1], action=v[2]}) end

for _, v in ipairs({
  {"w", act.CloseCurrentPane{confirm=false}},
}) do table.insert(config.keys, {mods="SHIFT|CTRL", key=v[1], action=v[2]}) end

-- for _, v in ipairs({
--   {"Enter", act.SplitHorizontal{domain='CurrentPaneDomain'}},
--   {"\\", act.SplitVertical{domain='CurrentPaneDomain'}},
--   {"w", act.CloseCurrentPane{confirm=true}},
--   {"t", act.SpawnTab'CurrentPaneDomain'},
--   {"q", act.CloseCurrentTab{confirm=true}},
--   {"c", act.CopyTo'ClipboardAndPrimarySelection'},
--   {"v", act.PasteFrom'Clipboard'},
--   {"+", act.IncreaseFontSize},
--   {"-", act.DecreaseFontSize},
--   {"*", act.ResetFontSize}
-- }) do table.insert(config.keys, {mods="ALT", key=v[1], action=v[2]}) end

-- Maximize on startup
-- wezterm.on('gui-startup', function(cmd)
--   local tab, pane, window = mux.spawn_window(cmd or {})
--   window:gui_window():maximize()
-- end)

-- Mouse bindings
config.mouse_bindings = {
  {event={Down={streak=1, button="Right"}}, mods="NONE", action=act.CopyTo("Clipboard")},
}

-- Finally, return the configuration to wezterm:
return config
