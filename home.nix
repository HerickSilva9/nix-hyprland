{ lib, pkgs, ... }:
{

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
      PS1='\n\[\e]0;\u@\h: \w\a\]\[\e[32;1m\]\u@\h:\w\$\[\e[0m\] '
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

  home.stateVersion = "24.11";
}
