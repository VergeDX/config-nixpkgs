# https://github.com/nix-community/home-manager#usage
{ pkgs, home, ... }:
{
  programs.htop.enable = true;
  imports = [ ./chromium.nix ];

  home.packages = [ pkgs.dmenu ];
}
