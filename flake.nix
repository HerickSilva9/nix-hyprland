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
            ./configuration.nix
            ./hyprland/packages-hyprland.nix
            ./system/drivers-nvidia.nix
            ./system/hardware-configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.herick = ./home.nix;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { profile = "hyprland"; };
              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };

        cosmic = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./cosmic/packages-cosmic.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.herick = ./home.nix;
                backupFileExtension = "backup";
                extraSpecialArgs = { profile = "cosmic"; };
              };
              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };

        gnome = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./gnome/configuration-gnome.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.herick = ./home.nix;
                backupFileExtension = "backup";
                extraSpecialArgs = { profile = "gnome"; };
              };
              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./hyprland/packages-hyprland.nix
            ./system/drivers-intel.nix
            ./system/hardware-configuration-laptop.nix
            ./laptop/packages-laptop.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.herick = ./home.nix;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { profile = "hyprland"; };
              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };

      };
    };
}
