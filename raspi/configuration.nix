{ pkgs, lib, ... }:
{
  sdImage.compressImage = false;
  imports = [
    # https://github.com/NixOS/nixpkgs/issues/135828#issuecomment-918359063
    ./networking/wireless.nix
    ./networking/networkmanager.nix
    ./networking/hostName-domain.nix

    ./nix/binary-caches.nix
    ./nix/flakes.nix
    ./nix/storage-optimization.nix

    ./users-immutable.nix
    ./boot.nix
    ./libvirt.nix

    ./services/openssh.nix
    ./services/xserver.nix
    ./services/lightdm.nix

    ../local/virtualisation/libvirt.nix
  ];

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
