{ config, pkgs, pkgs-unstable, ... }:

{

  environment.systemPackages = with pkgs; [

  git

  # Python
  python3 python3Packages.pip python3Packages.virtualenv uv

  # Rust
  rustup

  # Neovim
  neovim vim gcc wl-clipboard

  ] ++ [

  pkgs-unstable.zed-editor
  pkgs-unstable.vscode

  ];

  programs.nix-ld.enable = true;

}