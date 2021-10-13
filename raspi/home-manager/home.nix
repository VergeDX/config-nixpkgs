# https://github.com/nix-community/home-manager#usage
{ pkgs, home, ... }:
{
  programs.firefox.enable = true;
  programs.htop.enable = true;
  imports = [
    # ../../config/neovim.nix
  ];

  home.packages = [ pkgs.gnome.gnome-boxes ]
    ++ [ pkgs.dmenu ];
}
