{ pkgs, lib, ... }:
{
  sdImage.compressImage = false;
  imports = [
    # https://github.com/NixOS/nixpkgs/issues/135828#issuecomment-918359063
    ./networking/wireless.nix
    ./networking/eth0.nix
    ./networking/hostName-domain.nix

    ./nix/binary-caches.nix
    ./nix/flakes.nix
    ./nix/storage-optimization.nix

    ./users-immutable.nix
    ./boot.nix
    ./libvirt.nix

    ./services/openssh.nix
    ./services/xserver.nix
  ];

  # https://stackoverflow.com/questions/21830670
  systemd.services."telegraf".after = [ "influxdb2.service" ];
  # https://stackoverflow.com/questions/43001223
  # https://www.freedesktop.org/software/systemd/man/systemd.service.html#ExecStartPre=
  systemd.services."telegraf".serviceConfig."ExecStartPre" =
    [ "${pkgs.coreutils}/bin/sleep 30" ];

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
