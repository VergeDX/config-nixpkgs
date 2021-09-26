{ pkgs, lib, ... }:
{
  imports = [
    # https://github.com/NixOS/nixpkgs/issues/135828#issuecomment-918359063
    ./hardware-deviceTree.nix
    # https://github.com/NixOS/nixos-hardware#using-channels
    <nixos-hardware/raspberry-pi/4>
    # https://nix-community.github.io/home-manager/
    <home-manager/nixos>

    ./networking-wireless.nix
    ./wiki-archlinux-mdns.nix

    ./nix-binary-caches.nix
    ./users-immutable.nix

    ./services-openssh.nix
    ./services-xserver.nix
  ];

  # https://github.com/NixOS/nixpkgs/issues/111683#issuecomment-771986512
  # https://forums.xilinx.com/t5/Embedded-Linux/U-boot-v2019-1-ERROR-Did-not-find-a-cmdline-Flattened-Device/td-p/991415
  boot.kernelPackages = pkgs.linuxPackages;

  boot.loader.generic-extlinux-compatible.enable = true;
  boot.loader.generic-extlinux-compatible.configurationLimit = 3;

  # https://nix.dev/tutorials/installing-nixos-on-a-raspberry-pi#installing-nixos
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };
}
