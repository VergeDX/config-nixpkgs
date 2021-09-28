# https://github.com/nix-community/home-manager#usage
{ pkgs, home, ... }:
{
  imports = [
    ../../config/neovim.nix
  ];
}
