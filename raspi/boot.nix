{ pkgs, lib, ... }:
{
  boot.initrd.availableKernelModules = lib.mkForce [ ];
  boot.kernelPackages = pkgs.linuxPackages_rpi4;

  boot.loader.generic-extlinux-compatible.enable = true;
  boot.loader.generic-extlinux-compatible.configurationLimit = 13;
}
