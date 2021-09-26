{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Flakes#NixOS
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = "experimental-features = nix-command flakes";
}
