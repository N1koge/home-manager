{
  description = "Home Manager configuration of ack";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, ... }:
    let
      user = "ack";
    in {
      homeConfigurations."${user}" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

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

      darwinConfigurations = nix-darwin.lib.darwinSystem {
        system = "aarch64_darwin";

        extraSpecialArgs = {
          user = user;
          stateVersion = "23.11";
        };

        modules = [
          self.homeModules.common
          self.homeModules.darwin
        ];
      };

      homeModules = {
        common = import ./hosts;
        darwin = import ./hosts/darwin;
      };
    };
}
