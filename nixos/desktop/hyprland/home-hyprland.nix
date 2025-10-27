{ lib, pkgs, hostname, ... }:
{
  home.packages = with pkgs; [
    obs-studio
    vlc
    ags
   ];

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      # Terminal
      "application/x-terminal-emulator" = "kitty.desktop";
      "x-scheme-handler/terminal" = "kitty.desktop";

      # Navegador (Google Chrome)
      "text/html" = "google-chrome.desktop";
      "x-scheme-handler/http" = "google-chrome.desktop";
      "x-scheme-handler/https" = "google-chrome.desktop";
      "x-scheme-handler/about" = "google-chrome.desktop";
      "x-scheme-handler/unknown" = "google-chrome.desktop";

      # Gerenciador de arquivos (Dolphin)
      "inode/directory" = "org.kde.dolphin.desktop";

      # Editor de texto (Kate)
      "text/plain" = "org.kde.kate.desktop";

      # PDF
      "application/pdf" = "google-chrome.desktp";
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      ${builtins.readFile ./hyprland/hyprland.conf}
      ${builtins.readFile ./hyprland/monitors/${hostname}.conf}
    '';
  };

  programs.wofi = {
    enable = true;
    settings = {
      allow_images = false;
      gtk-dark = true;
    };
    style = builtins.readFile ./wofi/style.css;
  };

  xdg.configFile."swappy/config".source = ./swappy/config;

  programs.hyprpanel.enable = true;

}
