{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    extraConfig = ''
      lua << EOF
      ${builtins.readFile config/options.lua}
      ${builtins.readFile config/keys.lua}

      -- plugins
      require("lazy").setup('plugins', {})
      EOF
    '';
    plugins = with pkgs.vimPlugins; [
      lazy-nvim
    ];
  
  };
  home.file.".config/nvim/lua/plugins" = {
    source = ./plugins;
    recursive = true;
  };
}
