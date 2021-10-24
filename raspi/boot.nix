{ pkgs, lib, ... }:
let linux_rpi4 = pkgs.callPackage ./linux_rpi4.nix { };
in
{
  boot.initrd.availableKernelModules = lib.mkForce [ ];
  # https://nixos.wiki/wiki/Linux_kernel#Pinning_a_kernel_version
  boot.kernelPackages = pkgs.linuxPackagesFor linux_rpi4;

  boot.loader.generic-extlinux-compatible.enable = true;
  boot.loader.generic-extlinux-compatible.configurationLimit = 13;
}
