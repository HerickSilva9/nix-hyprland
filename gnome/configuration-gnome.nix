{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [ ];

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.gnome.core-apps.enable = true;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome-maps
    geary
    epiphany
    gnome-weather
    simple-scan
    gnome-characters
    gnome-contacts
    gnome-font-viewer
    gnome-calendar
    gnome-clocks
    gnome-music
    evince
    yelp
    gnome-connections
    gnome-logs
  ];

}