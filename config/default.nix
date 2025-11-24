{ config, pkgs, ...}:

{
  imports = [
    ./development
    ./flatpak
  ];
}