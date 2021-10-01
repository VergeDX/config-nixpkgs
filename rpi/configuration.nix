{ pkgs, lib, ... }:
{
  sdImage.compressImage = false;
  imports = [
    # https://github.com/NixOS/nixpkgs/issues/135828#issuecomment-918359063
    ./hardware-deviceTree.nix

    ./networking/wireless.nix
    ./networking/eth0.nix
    ./networking/hostName-domain.nix

    ./nix/binary-caches.nix
    ./nix/flakes.nix
    ./nix/storage-optimization.nix

    ./users-immutable.nix
    ./boot.nix

    ./services/openssh.nix
    ./services/xserver.nix
    ./services/avahi.nix
    # ./services/influxdb2.nix
    # ./services/nginx.nix
  ];

  age.secrets = { };

  environment.systemPackages = with pkgs; [ git ];
  # https://nix.dev/tutorials/installing-nixos-on-a-raspberry-pi#installing-nixos
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };
}
