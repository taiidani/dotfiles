-- Import the wezterm module
local wezterm = require 'wezterm'
-- Creates a config object which we will be adding our config to
local config = wezterm.config_builder()

-- (This is where our config will go)
local keybindings = require 'keybindings'
local appearance = require 'appearance'

appearance.set_appearance(config)

local powerline = require 'powerline'

config.set_environment_variables = {
    PATH = '/opt/homebrew/bin:' .. os.getenv('PATH')
}

keybindings.set_leader(config)
keybindings.set_key_bindings(config)

-- Returns our config to be evaluated. We must always do this at the bottom of this file
return config
