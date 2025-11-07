{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

  ];

  services.upower.enable = true;

}
