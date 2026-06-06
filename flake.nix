{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
    };

    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixvim, helium, ... }:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.trollface = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit helium;
      };

      modules = [
        ./configuration.nix

	nixvim.nixosModules.nixvim

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.extraSpecialArgs = {
            inherit helium;
          };

          home-manager.users.mystic = import ./home.nix;
        }
      ];
    };
  };
}
