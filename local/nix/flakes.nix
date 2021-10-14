{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Flakes
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = "experimental-features = nix-command flakes";
}
