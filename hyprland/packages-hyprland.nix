{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

  # kdePackages.kde-cli-tools xdg-utils kdePackages.ark

  wayland
  uwsm

  pipewire
  wireplumber
  pavucontrol

  waybar
  wofi
  swaybg
  grim slurp swappy
  # hyprshot

  gnome-keyring
  libsecret
  polkit
  polkit_gnome

  # Themes
  dracula-theme dracula-icon-theme

  gnome-calculator

  kdePackages.kate
  #Dolphin and required dependencies
  kdePackages.dolphin
  kdePackages.kio
  kdePackages.kdf
  kdePackages.kio-fuse
  kdePackages.kio-extras
  kdePackages.kio-admin
  kdePackages.qtwayland
  kdePackages.plasma-integration
  kdePackages.kdegraphics-thumbnailers
  kdePackages.breeze-icons
  kdePackages.qtsvg
  kdePackages.kservice
  shared-mime-info

  swaynotificationcenter

  papirus-icon-theme
  adwaita-icon-theme

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

  xdg.mime.enable = true;
  xdg.menus.enable = true;

  # Fix for empty "Open With" menu in Dolphin when running under Hyprland
  # This copies the plasma-applications.menu file from plasma-workspace to /etc/xdg/menus/applications.menu
  environment.etc."/xdg/menus/applications.menu".text = builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

}
