{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Podman
  virtualisation.podman.enable = true;
  boot.binfmt.emulatedSystems = [ "aarch64-linux" "riscv64-linux" ];
}
