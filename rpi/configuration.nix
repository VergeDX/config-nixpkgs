{ pkgs, lib, ... }:
{
  imports = [
    # https://github.com/NixOS/nixpkgs/issues/135828#issuecomment-918359063
    ./hardware-deviceTree.nix

    ./networking/wireless.nix
    ./networking/eth0.nix
    ./networking/hostName-domain.nix

    ./nix/binary-caches.nix
    ./nix/flakes.nix

    ./users-immutable.nix

    ./services/openssh.nix
    ./services/xserver.nix
    ./services/avahi.nix
  ];

  # https://github.com/NixOS/nixpkgs/issues/111683#issuecomment-771986512
  # https://forums.xilinx.com/t5/Embedded-Linux/U-boot-v2019-1-ERROR-Did-not-find-a-cmdline-Flattened-Device/td-p/991415
  boot.kernelPackages = pkgs.linuxPackages;

  boot.loader.generic-extlinux-compatible.enable = true;
  boot.loader.generic-extlinux-compatible.configurationLimit = 3;

  # code-server --bind-addr 0.0.0.0:8080
  environment.systemPackages = with pkgs; [ code-server ];
  networking.firewall.allowedTCPPorts = [ 8080 ];

  # https://nix.dev/tutorials/installing-nixos-on-a-raspberry-pi#installing-nixos
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };
}
