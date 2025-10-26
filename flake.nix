{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    {
      nixosConfigurations = {

        hyprland = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./nixos/configuration.nix
            ./nixos/system/drivers-nvidia.nix
            ./nixos/system/hardware-configuration.nix
            ./hyprland/packages-hyprland.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.herick = ./nixos/home.nix;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { profile = "hyprland"; };
            }
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./nixos/configuration.nix
            ./nixos/system/drivers-intel.nix
            ./nixos/system/hardware-configuration-laptop.nix
            ./hyprland/packages-hyprland.nix
            ./laptop/packages-laptop.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.herick = ./nixos/home.nix;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { profile = "hyprland"; };
            }
          ];
        };

      };
    };
}
