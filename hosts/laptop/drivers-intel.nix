{ config, pkgs, ... }:

{

  # Drivers
  services.xserver.videoDrivers = [ "modesetting" ];
  
  #  boot.kernelModules = [
  #    "nvidia" "nvidia_uvm" "nvidia_modeset" "nvidia_drm"
  #  ];

  hardware.graphics.enable = true;

}
