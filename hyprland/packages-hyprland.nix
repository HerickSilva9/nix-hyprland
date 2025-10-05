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
}