{ pkgs, lib, ... }:
{
  boot.initrd.availableKernelModules = lib.mkForce [ ];
  # https://nixos.wiki/wiki/Linux_kernel#Pinning_a_kernel_version
  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_rpi4.override {
    argsOverride = rec {
      src = pkgs.fetchgit {
        url = "https://github.com/raspberrypi/linux";
        rev = "1.20211007";
        sha256 = "sha256-vI0OMrJl+xc9KCQDrgjQB7FG2QsdKcY7WNwXTEJnzso=";
      };

      version = "5.10.y";
      modDirVersion = "5.10.63";
    };
  });

  boot.loader.generic-extlinux-compatible.enable = true;
  boot.loader.generic-extlinux-compatible.configurationLimit = 13;
}
