{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      # Função helper para criar pkgs-unstable
      mkUnstable = system: import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {

        pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./hosts/pc/drivers-nvidia.nix
            ./hosts/pc/hardware-configuration.nix
            ./nixos/desktop/hyprland/packages-hyprland.nix

            # Disponibilizar pkgs-unstable para o sistema
            {
              _module.args.pkgs-unstable = mkUnstable "x86_64-linux";
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.herick = ./home.nix;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = {
                profile = "hyprland";
                hostname = "pc";
                pkgs-unstable = mkUnstable "x86_64-linux";
              };
            }
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./hosts/laptop/drivers-intel.nix
            ./hosts/laptop/hardware-configuration.nix
            ./nixos/desktop/hyprland/packages-hyprland.nix
            ./hosts/laptop/packages-laptop.nix

            # Disponibilizar pkgs-unstable para o sistema
            {
              _module.args.pkgs-unstable = mkUnstable "x86_64-linux";
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.herick = ./home.nix;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = {
                profile = "hyprland";
                hostname = "laptop";
                pkgs-unstable = mkUnstable "x86_64-linux";
              };
            }
          ];
        };

      };
    };
}