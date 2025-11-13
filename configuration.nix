# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, config, pkgs, pkgs-unstable, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./core/bootloader-grub.nix
      ./modules/packages-hyprland.nix
      ./modules/services.nix
      ./audio
      ./virtualisation
    ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.herick = {
    isNormalUser = true;
    description = "Herick";
    extraGroups = [ "networkmanager" "wheel" "kvm" "qemu-libvirtd" "libvirtd"];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

  nano
  wget
  git
  curl
  kitty
  tree
  neofetch
  zip
  unzip
  python3 python3Packages.pip python3Packages.virtualenv uv
  nix-output-monitor
  cowsay
  bat
  htop
  btop

  neovim vim gcc xclip

  # Virtualisation
  virt-manager
  libvirt
  qemu
  freerdp
  remmina
  steam-run
  distrobox
#  wineWowPackages.stable

  home-manager

  seafile-client

  discord

  ] ++ [
  pkgs-unstable.rclone
  pkgs-unstable.libreoffice-fresh
  pkgs-unstable.google-chrome
  pkgs-unstable.firefox
  pkgs-unstable.vscode

  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

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

  # Virtualisation
  virtualisation = {
    libvirtd = {
      enable = true;
      onBoot = "start";
      onShutdown = "shutdown";
    };
    podman = {
      enable = true;
      dockerCompat = false;
    };
  };
  boot.kernelModules = [ "kvm" "kvm_amd" "ip_tables" "iptable_nat" ];
  environment.localBinInPath = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  programs.nix-ld.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Copia sua configuração do rclone para o sistema
#  environment.etc."rclone.conf" = {
#    source = lib.mkIf (builtins.pathExists "/home/herick/.config/rclone/rclone.conf") "/home/herick/.config/rclone/rclone.conf";
#    mode = "0600";  # Apenas root pode ler (segurança)
#  };

#  # Monta o OneDrive automaticamente
#  fileSystems."/home/herick/onedrive" = {
#    device = "onedrive:";
#    fsType = "rclone";
#    options = [
#      "nodev"
#      "nofail"
#      "allow_other"
#      "args2env"
#      "config=/etc/rclone.conf"
#      "cache-dir=/home/herick/.cache/rclone"
#      "vfs-cache-mode=writes"
#      "vfs-cache-max-age=1h"
#      "uid=1000"  # Seu UID (confirme com: id -u)
#      "gid=100"   # Seu GID (confirme com: id -g)
#    ];
#  };

  xdg.terminal-exec = {
      enable = true;
      settings.default = [ "kitty.desktop" ];
    };

  environment.sessionVariables = {
    TERMINAL = "kitty";
    TERM = "kitty";
  };

}
