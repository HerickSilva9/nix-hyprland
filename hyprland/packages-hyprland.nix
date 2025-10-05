{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

  kdePackages.dolphin
  kdePackages.kde-cli-tools
  xdg-utils
  kdePackages.ark
  kdePackages.kio
  kdePackages.kio-fuse
  kdePackages.kio-extras

  wayland
  uwsm

  pipewire
  wireplumber
  pavucontrol

  waybar
  wofi
  swaybg
  grim slurp swappy

  gnome-keyring
  libsecret
  polkit
  polkit_gnome

  # Themes
  dracula-theme
  dracula-icon-theme

  gnome-calculator

  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  services.gnome.gnome-keyring.enable = true;

  services.pipewire.enable = true;

    # Environment variables
  environment.variables = {
    GTK_THEME = "Dracula";
    ICON_THEME = "Dracula";
  };

}