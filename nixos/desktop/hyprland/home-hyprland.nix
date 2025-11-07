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
      "text/plain" = "nvim.desktop";
      "text/x-csrc" = "nvim.desktop";
      "text/x-c++src" = "nvim.desktop";
      "text/x-python" = "nvim.desktop";
      "text/markdown" = "nvim.desktop";

      # PDF
      "application/pdf" = "google-chrome.desktop";
    };
  };

  home.sessionVariables = {
    TERMINAL = "kitty";
    TERM = "kitty";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      ${builtins.readFile ./hyprland/hyprland.conf}
      ${builtins.readFile ./hyprland/monitors/${hostname}.conf}
    '';
    systemd.variables = ["--all"];
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
