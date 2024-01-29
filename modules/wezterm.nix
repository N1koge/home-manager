{ ... }:

{
  programs.wezterm = {
    enable = true;

    extraConfig = ''
      -- Pull in the wezterm API
      local wezterm = require 'wezterm'

      -- This table will hold the configuration.
      local config = {}

      -- In newer versions of wezterm, use the config_builder which will
      -- help provide clearer error messages
      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      config.color_scheme = 'tokyonight_moon'
      config.font = wezterm.font 'Fira Code'
      config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
      config.keys = {
        {
          key = '+',
          mods = 'CMD|SHIFT', 
          action = wezterm.action.SplitHorizontal {
            domain = 'CurrentPaneDomain'
          }
        },
        {
          key = '_',
          mods = 'CMD|SHIFT', 
          action = wezterm.action.SplitVertical {
            domain = 'CurrentPaneDomain'
          }
        },
        {
          key = 'w',
          mods = 'CMD|SHIFT', 
          action = wezterm.action.CloseCurrentPane {
            confirm = true
          }
        },
        {
          key = '{',
          mods = 'SHIFT|ALT',
          action = wezterm.action.MoveTabRelative(-1),
        },
        {
          key = '}',
          mods = 'SHIFT|ALT',
          action = wezterm.action.MoveTabRelative(1),
        }
      }


      return config
    '';
  };
}
