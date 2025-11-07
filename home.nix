{ config, lib, pkgs, profile, ... }:
{

  imports = [

  ] ++ lib.optional (profile == "hyprland") ./nixos/desktop/hyprland/home-hyprland.nix;

  home.username = "herick";
  home.homeDirectory = "/home/herick";

  home.packages = with pkgs; [ ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      # Carregar configuração personalizada de PATH
      if [ -f "$HOME/.local/bin/env" ]; then
        . "$HOME/.local/share/../bin/env"
      fi

      function set_prompt() {
        local GREEN="\[\e[32;1m\]"
        local BLUE="\[\e[34;1m\]"
        local YELLOW="\[\e[33;1m\]"
        local RESET="\[\e[0m\]"

        # reset venv
        local VENV_PROMPT=""

        if [ -n "$VIRTUAL_ENV" ]; then
          VENV_PROMPT="''${YELLOW}($(basename $VIRTUAL_ENV))''${RESET} "
        fi

        if [ -n "$IN_NIX_SHELL" ]; then
          PS1="''${VENV_PROMPT}''${BLUE}[nix-shell]''${RESET} ''${GREEN}\[\e]0;\u@\h: \w\a\]\[\e[32;1m\]\u@\h:\w\$\[\e[0m\]''${RESET} "
        else
          PS1="''${VENV_PROMPT}\[\e]0;\u@\h: \w\a\]\[\e[32;1m\]\u@\h:\w\$\[\e[0m\] "
        fi
      }

      PROMPT_COMMAND=set_prompt
    export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH
    export TERM="kitty"
    '';
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      lst = "tree -L 1 --dirsfirst";
      srpc = "sudo nixos-rebuild switch --flake .#pc";
      srlaptop = "sudo nixos-rebuild switch --flake .#laptop";
      y = "yazi";
    };
  };

  programs.kitty = {
    enable = true;
    extraConfig = ''
      ${builtins.readFile ./nixos/pkgs/kitty/kitty.conf}
      ${builtins.readFile ./nixos/pkgs/kitty/current-theme.conf}
    '';
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    # Personalizando para sua estrutura
    desktop = "${config.home.homeDirectory}/desktop";
    documents = "${config.home.homeDirectory}/documentos";
    download = "${config.home.homeDirectory}/downloads";
    music = "${config.home.homeDirectory}/music";
    pictures = "${config.home.homeDirectory}/imagens";
    publicShare = "${config.home.homeDirectory}/public";
    templates = "${config.home.homeDirectory}/modelos";
    videos = "${config.home.homeDirectory}/videos";
  };

  home.file.".wallpapers/DraculaWallpapers" = {
    source = pkgs.fetchFromGitHub {
      owner = "dracula";
      repo = "wallpaper";
      rev = "master";
      sha256 = "sha256-P0MfGkVap8wDd6eSMwmLhvQ4/7Z+pNmgY7O+qt9C1bg";
    };
  recursive = true;
  };

  home.stateVersion = "25.05";
}
