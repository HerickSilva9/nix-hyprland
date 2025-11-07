{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [

  # kdePackages.kde-cli-tools xdg-utils

  wayland
  uwsm

  pipewire
  wireplumber
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
  kdePackages.ark
  shared-mime-info

  # Pacotes para suporte a dispositivos
  kdePackages.solid
  kdePackages.kded
  udisks2
  udiskie

  swaynotificationcenter

  papirus-icon-theme
  adwaita-icon-theme

  yazi
  superfile

  nautilus gnome.gvfs sushi file-roller
  xdg-desktop-portal-gtk

  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  services.gnome.gnome-keyring.enable = true;

  security.pam.services.sddm = {
    enableGnomeKeyring = true;
  };

  services.pipewire.enable = true;

  # Habilita o udisks2 para gerenciamento de dispositivos
  services.udisks2.enable = true;

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
