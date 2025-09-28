{ lib, pkgs, ... }:
{

  home.username = "herick";
  home.homeDirectory = "/home/herick";

  home.packages = with pkgs; [ ];

  home.stateVersion = "24.11";
}
