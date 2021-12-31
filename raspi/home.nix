# https://github.com/nix-community/home-manager#usage
{ pkgs, home, ... }:
{
  programs.htop.enable = true;
  home.packages = with pkgs; [ android-tools ];
}
