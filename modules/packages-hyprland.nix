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

  nano
  wget
  curl
  kitty
  tree
  neofetch
  zip
  unzip
  nix-output-monitor
  cowsay
  bat
  htop
  btop

  # Virtualisation
  # virt-manager
  # libvirt
  # qemu
  freerdp
  remmina
  steam-run
  distrobox

  home-manager

  seafile-client

  discord

  ] ++ [
  pkgs-unstable.rclone
  pkgs-unstable.libreoffice-fresh
  pkgs-unstable.google-chrome
  pkgs-unstable.firefox
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

  swapDevices = [{
    device = "/swapfile";
    size = 8 * 1024;
  }];

  nix.settings.download-buffer-size = 134217728;  # 128 MB

  services.xserver.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    roboto
    open-sans
    nerd-fonts.jetbrains-mono
    ubuntu_font_family
    font-awesome
    material-design-icons
  ];

  environment.localBinInPath = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  xdg.terminal-exec = {
      enable = true;
      settings.default = [ "kitty.desktop" ];
    };

  environment.sessionVariables = {
    TERMINAL = "kitty";
    TERM = "kitty";
  };

  services.gnome.gnome-keyring.enable = true;

  # Habilita o udisks2 para gerenciamento de dispositivos
  services.udisks2.enable = true;
}
