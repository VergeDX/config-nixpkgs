{ pkgs, ... }:
{
  # https://github.com/NixOS/nixpkgs/issues/141937
  environment.systemPackages = [ pkgs.clapper ];
}
