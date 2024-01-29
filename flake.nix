{
  description = "Home Manager configuration of ack";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      user = "ack";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."${user}" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = {
          user = user;
          stateVersion = "23.11";
        };

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ self.homeModules.common ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };

      homeModules = {
        common = import ./hosts;
      };
    };
}
