{ config, pkgs, pkgs-unstable, ... }:

{

  environment.systemPackages = with pkgs; [

  wayland
  uwsm

  pavucontrol

  wofi
  swaybg
  grim slurp swappy

  libsecret
  polkit
  polkit_gnome

  # Themes
  dracula-theme dracula-icon-theme

  gnome-calculator

  kdePackages.breeze-icons
  kdePackages.qtwayland
  kdePackages.qtsvg
  shared-mime-info

  udisks2
  udiskie

  swaynotificationcenter

  papirus-icon-theme
  adwaita-icon-theme

  yazi
  superfile

  nautilus gnome.gvfs sushi file-roller
  xdg-desktop-portal-gtk

  fzf

  ] ++ [
  pkgs-unstable.zed-editor
  ];

  security.pam.services.sddm = {
    enableGnomeKeyring = true;
  };

  # Environment variables
  environment.variables = {
    GTK_THEME = "Dracula";
    ICON_THEME = "Dracula";
  };

  xdg.mime.enable = true;
  xdg.menus.enable = true;


}
