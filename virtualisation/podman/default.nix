{ config, pkgs, ...}:

{
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = false;
      };
  };

  users.users.herick = {
    extraGroups = [ "podman" ];
  };

}