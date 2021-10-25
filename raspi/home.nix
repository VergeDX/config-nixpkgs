# https://github.com/nix-community/home-manager#usage
{ pkgs, home, ... }:
{
  programs.chromium.enable = true;
  programs.htop.enable = true;
  imports = [
    # ../../config/neovim.nix
  ];
}
