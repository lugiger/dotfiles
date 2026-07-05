local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Appearance
config.color_scheme = "rose-pine-moon"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 15.0

-- UI chrome
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.window_padding = { left = 12, right = 12, top = 10, bottom = 10 }

-- Platform-specific opacity/blur
local os_triple = wezterm.target_triple
if os_triple:find("apple") then
    config.window_background_opacity = 0.88
    config.macos_window_background_blur = 50
elseif os_triple:find("windows") then
    -- Running on Windows (WezTerm connects to WSL)
    config.default_domain = "WSL:Ubuntu-24.04"
    config.window_background_opacity = 0.96
end

-- Key bindings
config.keys = {
    -- Split panes
    { key = "|", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "-", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
    -- Navigate panes with alt+hjkl
    { key = "h", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "l", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
    { key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
    -- Zoom current pane
    { key = "z", mods = "CTRL|SHIFT", action = wezterm.action.TogglePaneZoomState },
}

return config
