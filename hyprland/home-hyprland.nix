{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [ ];

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  programs.wofi = {
    enable = true;
    settings = {
      allow_images = false;
      gtk-dark = true;
    };
    style = builtins.readFile ./wofi/style.css;
  };

  programs.waybar = {
    enable = true;
    style = builtins.readFile ./waybar/style.css;
  };
  xdg.configFile."waybar/config.jsonc".source = ./waybar/config.jsonc;

  xdg.configFile."swappy/config".source = ./swappy/config;

}
