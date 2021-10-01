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
    ./services/influxdb2.nix
    ./services/nginx.nix
  ];

  age.secrets = {
    "influxdb2/influxdb-selfsigned.crt".file =
      ./secrets/influxdb2/influxdb-selfsigned-crt.age;
    "influxdb2/influxdb-selfsigned.key".file =
      ./secrets/influxdb2/influxdb-selfsigned-key.age;

    "nginx/nginx-selfsigned.key" = {
      owner = "nginx";
      file = ./secrets/nginx/nginx-selfsigned-key.age;
    };
    "nginx/nginx-selfsigned.crt" = {
      owner = "nginx";
      file = ./secrets/nginx/nginx-selfsigned-crt.age;
    };
  };

  # https://nixos.wiki/wiki/GNOME
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [ git ]
    ++ [ pkgs.gnome3.adwaita-icon-theme pkgs.epiphany ];

  # https://nix.dev/tutorials/installing-nixos-on-a-raspberry-pi#installing-nixos
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };
}
