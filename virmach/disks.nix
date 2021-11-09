{ modulesPath, ... }:
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  fileSystems."/" = { device = "/dev/vda1"; fsType = "btrfs"; };
  fileSystems."/".options = [ "compress-force=zstd" ];
  swapDevices = [{ device = "/dev/vda2"; }];
}
