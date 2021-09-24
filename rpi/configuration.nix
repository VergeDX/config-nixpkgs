{ pkgs, lib, ... }:
{
  imports = [
    # https://github.com/NixOS/nixos-hardware#using-channels
    <nixos-hardware/raspberry-pi/4>

    # https://github.com/NixOS/nixpkgs/issues/135828#issuecomment-918359063
    ./patch/issuecomment-918359063.nix
    # https://github.com/NixOS/nixpkgs/issues/111683#issuecomment-771986512
    ./patch/issuecomment-771986512.nix

    ./networking-wireless.nix
    ./nix-binary-caches.nix
    ./users-immutable.nix
    ./services-openssh.nix
  ];

  # https://nix.dev/tutorials/installing-nixos-on-a-raspberry-pi#installing-nixos
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };
}
