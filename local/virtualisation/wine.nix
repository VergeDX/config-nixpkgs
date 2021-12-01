{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Wine
  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
  ];
}
