{ lib, pkgs, profile, ... }:
{

  imports = [

  ] ++ lib.optional (profile == "hyprland") ./hyprland/home-hyprland.nix;

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
    '';
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      lst = "tree -L 1 --dirsfirst";
    };
  };

  programs.kitty = {
    enable = true;
    extraConfig = ''
      ${builtins.readFile ./kitty/kitty.conf}
      ${builtins.readFile ./kitty/current-theme.conf}
    '';
  };

  home.stateVersion = "25.05";
}
