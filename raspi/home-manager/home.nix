# https://github.com/nix-community/home-manager#usage
{ pkgs, home, ... }:
{
  programs.firefox.enable = true;
  programs.htop.enable = true;
  imports = [
    # ../../config/neovim.nix
  ];

  home.packages = with pkgs; [
    virt-manager
    gnome.gnome-boxes
  ];
}
