{ config, pkgs, lib, user, stateVersion, ... }:

{
  home.username = "${user}";
  home.homeDirectory = "/home/${user}";

  home.stateVersion = stateVersion;

  home.packages = [
    pkgs.bat
    pkgs.cmake
    pkgs.gh
    pkgs.nodejs_21
    pkgs.lazygit
    pkgs.lsd
    pkgs.ripgrep
    pkgs.xclip
    pkgs.zig
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  # fonts
  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # programs
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableAutosuggestions = true;
    enableCompletion = true;
    shellAliases = {
      # l
      l = "lsd";
      ll = "l -l";
      lla = "l -la";
      lt = "l --tree";
      # fzf
      fzfc = "fzf | pbcopy";
      # others
      hme = "home-manager edit";
      hms = "home-manager switch";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.ssh = {
    enable = true;
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      username.show_always = true;
      character = {
        success_symbol = ''[\(」・ω・\)」>](bold green)'';
        error_symbol = ''[\(/・ω・\)/ >](bold red)'';
      };
      directory = {
        truncation_length = 10;
        truncation_symbol = ".../";
        truncate_to_repo = false;
      };
      git_status = {
        ahead = "↑$count";
        behind = "$count↓";
        diverged = "↕↑$ahead_count↓$behind_count";
      };
    };
  };

  imports = [
    ../modules/neovim/index.nix
    ../modules/git/private.nix
    ../modules/wezterm.nix
  ];
}
