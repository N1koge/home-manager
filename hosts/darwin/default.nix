{ user, stateVersion, ... }:

{
  home.username = "${user}";
  home.homeDirectory = "/Users/${user}";

  home.stateVersion = stateVersion;

  imports = [ ../modules/git/work.nix ]
}
