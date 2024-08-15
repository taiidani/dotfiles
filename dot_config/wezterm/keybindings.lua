-- Import the wezterm module
local wezterm = require 'wezterm'
-- Define a lua table to hold _our_ module's functions
local module = {}

function module.set_leader(config)
    -- If you're using emacs you probably wanna choose a different leader here,
    -- since we're gonna be making it a bit harder to CTRL + A for jumping to
    -- the start of a line
    config.leader = {
        key = 'a',
        mods = 'CTRL',
        timeout_milliseconds = 1000
    }
end

function module.set_key_bindings(config)
    -- Key bindings
    -- Table mapping keypresses to actions
    config.keys = { -- Sends ESC + b and ESC + f sequence, which is used
    -- for telling your shell to jump back/forward.
    {
        -- When the left arrow is pressed
        key = 'LeftArrow',
        -- With the "Option" key modifier held down
        mods = 'OPT',
        -- Perform this action, in this case - sending ESC + B
        -- to the terminal
        action = wezterm.action.SendString '\x1bb'
    }, {
        key = 'RightArrow',
        mods = 'OPT',
        action = wezterm.action.SendString '\x1bf'
    }, {
        key = ',',
        mods = 'SUPER',
        action = wezterm.action.SpawnCommandInNewTab {
            cwd = wezterm.home_dir,
            args = {'code', wezterm.config_dir}
        }
    }, {
        key = 'a',
        -- When we're in leader mode _and_ CTRL + A is pressed...
        mods = 'LEADER|CTRL',
        -- Actually send CTRL + A key to the terminal
        action = wezterm.action.SendKey {
            key = 'a',
            mods = 'CTRL'
        }
    }, {
        -- Full Screen support
        key = 'Enter',
        mods = 'SUPER',
        action = wezterm.action.ToggleFullScreen
    }, {
        key = 'k',
        mods = 'SUPER',
        action = wezterm.action.ClearScrollback 'ScrollbackAndViewport'
    }, {
        -- CMD+Down splits the pane vertically
        key = 'DownArrow',
        mods = 'SUPER',
        action = wezterm.action.SplitVertical {
            domain = 'CurrentPaneDomain'
        }
    }, {
        -- CMD+Right splits the pane horizontally
        key = 'RightArrow',
        mods = 'SUPER',
        action = wezterm.action.SplitHorizontal {
            domain = 'CurrentPaneDomain'
        }
    }}

    local function move_pane(key, direction)
        return {
            key = key,
            mods = 'LEADER',
            action = wezterm.action.ActivatePaneDirection(direction)
        }
    end

    table.insert(config.keys, move_pane('DownArrow', 'Down'))
    table.insert(config.keys, move_pane('UpArrow', 'Up'))
    table.insert(config.keys, move_pane('LeftArrow', 'Left'))
    table.insert(config.keys, move_pane('RightArrow', 'Right'))

    local function resize_pane(key, direction)
        return {
            key = key,
            action = wezterm.action.AdjustPaneSize {direction, 3}
        }
    end

    table.insert(config.keys, {
        -- When we push LEADER + R...
        key = 'r',
        mods = 'LEADER',
        -- Activate the `resize_panes` keytable
        action = wezterm.action.ActivateKeyTable {
            name = 'resize_panes',
            -- Ensures the keytable stays active after it handles its
            -- first keypress.
            one_shot = false,
            -- Deactivate the keytable after a timeout.
            timeout_milliseconds = 1000
        }
    })

    config.key_tables = {
        resize_panes = {resize_pane('DownArrow', 'Down'), resize_pane('UpArrow', 'Up'),
                        resize_pane('LeftArrow', 'Left'), resize_pane('RightArrow', 'Right')}
    }
end

return module
