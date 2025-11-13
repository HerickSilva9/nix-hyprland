{ config, pkgs, ...}:

{

  virtualisation.docker = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    docker-compose
  ];

  users.users.herick = {
    extraGroups = [ "docker" ];
  };

  boot.kernelModules = [ "ip_tables" "iptable_nat" ];

}