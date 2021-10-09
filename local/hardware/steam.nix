{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Steam#Normal_install
  programs.steam.enable = true;

  # https://github.com/NixOS/nixpkgs/issues/25957
  hardware.opengl.driSupport32Bit = true;

  # https://github.com/NixOS/nixpkgs/issues/101281
  hardware.xpadneo.enable = true;
  services.hardware.xow.enable = true;
}
