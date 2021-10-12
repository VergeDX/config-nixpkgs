{ ... }:
{
  fileSystems."/" =
    {
      device = "/dev/disk/by-partuuid/ffaae78b-c99c-4fd2-9501-5a99f84259b4";
      fsType = "btrfs";

      # https://btrfs.wiki.kernel.org/index.php/Compression
      # https://wiki.archlinux.org/title/Btrfs_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)#%E5%8E%8B%E7%BC%A9
      # https://btrfs.wiki.kernel.org/index.php/FAQ#Performance_vs_Correctness
      options = [ "compress-force=zstd" "noatime" ];
    };

  fileSystems."/boot" = {
    device = "/dev/disk/by-partuuid/3f2a09aa-c259-4bca-846d-6cae19e5e048";
    fsType = "vfat";
  };

  swapDevices = [{
    device = "/dev/disk/by-partuuid/7be06228-8eab-403f-9a06-2b7990db2f00";
  }];

  services.btrfs.autoScrub.enable = true;
  services.btrfs.autoScrub.interval = "weekly";
  services.btrfs.autoScrub.fileSystems = [ "/" ];
}
