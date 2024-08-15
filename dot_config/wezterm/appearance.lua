-- Import the wezterm module
local wezterm = require 'wezterm'
-- Define a lua table to hold _our_ module's functions
local module = {}

function module.set_appearance(config)
    -- https://wezfurlong.org/wezterm/colorschemes/index.html
    config.color_scheme = 'Tokyo Night'

    -- Slightly transparent and blurred background
    config.window_background_opacity = 0.8
    config.macos_window_background_blur = 2

    -- Integrates the title bar into the tab bar
    config.window_decorations = 'RESIZE|INTEGRATED_BUTTONS'

    config.native_macos_fullscreen_mode = true
end

return module
