{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "modesetting" ];
}