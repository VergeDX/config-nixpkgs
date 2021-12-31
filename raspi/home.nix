# https://github.com/nix-community/home-manager#usage
{ pkgs, home, ... }:
let arknights-mower = pkgs.python3Packages.callPackage ./arknights-mower { }; in
{
  programs.htop.enable = true;
  home.packages = with pkgs; [ android-tools arknights-mower ];
}
