# https://github.com/nix-community/home-manager#usage
{ pkgs, home, ... }:
{
  home.packages = [
    pkgs.qv2ray
    pkgs.v2ray
  ];
}
