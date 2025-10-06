{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    gnome-calculator
  ];

  # Enable the COSMIC login manager
  services.displayManager.cosmic-greeter.enable = true;

  # Enable the COSMIC desktop environment
  services.desktopManager.cosmic.enable = true;

}
