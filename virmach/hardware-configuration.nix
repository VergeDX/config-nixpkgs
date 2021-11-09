{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/4fcdb3ce-fb5c-4616-89b6-4de59538a460";
    fsType = "btrfs";
  };

  swapDevices = [{ device = "/dev/disk/by-uuid/5f467354-12d2-43c3-b0ad-95af6a734eb7"; }];
}
