{ pkgs, ... }:
{
  programs.htop.enable = true;
  home.packages = [ pkgs.dig ];
}
