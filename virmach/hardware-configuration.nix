{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  fileSystems."/" = { device = "/dev/vda1"; fsType = "btrfs"; };
  swapDevices = [{ device = "/dev/vda2"; }];
}
