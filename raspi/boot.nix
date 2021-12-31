{ pkgs, lib, ... }:
{
  boot.initrd.availableKernelModules = lib.mkForce [ ];
  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.loader.generic-extlinux-compatible.enable = true;
  boot.loader.generic-extlinux-compatible.configurationLimit = 13;
}
