{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      
    ];

    username = "herick";
    homeDirectory = "/home/herick";

    stateVersion = "23.11";
  };
}
