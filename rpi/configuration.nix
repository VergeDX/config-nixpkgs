{ pkgs, ... }:
{
  imports = [
    # https://github.com/NixOS/nixpkgs/issues/135828#issuecomment-918359063
    ./patch/issuecomment-918359063.nix

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

  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
}
