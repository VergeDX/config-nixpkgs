{ ... }:
{
  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/4ff541a0-7952-4ede-a20b-6cecba4f16eb";
      fsType = "btrfs";

      # https://btrfs.wiki.kernel.org/index.php/Compression
      # https://wiki.archlinux.org/title/Btrfs_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)#%E5%8E%8B%E7%BC%A9
      # https://btrfs.wiki.kernel.org/index.php/FAQ#Performance_vs_Correctness
      options = [ "compress-force=zstd" "noatime" ];
    };

  fileSystems."/boot" = { device = "/dev/disk/by-uuid/F934-BA50"; fsType = "vfat"; };
  swapDevices = [{ device = "/dev/disk/by-uuid/1b07ef58-fa1b-4e5e-a394-7a07a9229f07"; }];
}
