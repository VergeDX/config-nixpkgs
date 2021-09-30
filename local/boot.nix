{ pkgs, ... }:
{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.font = "${pkgs.hack-font}/share/fonts/hack/Hack-Regular.ttf";

  # https://nixos.wiki/wiki/Linux_kernel
  # https://wiki.archlinux.org/title/Kernel_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
  boot.kernelPackages = pkgs.linuxPackages_zen;
  # https://mnguyen.io/blog/running-nixos-in-production/
  boot.kernelModules = [ "tcp_bbr" ];
  boot.kernel.sysctl = { "net.ipv4.tcp_congestion_control" = "bbr"; };

  # https://opensource.com/article/21/8/linux-kernel-module
  zramSwap.enable = true;

  # https://gist.github.com/manuelmazzuola/4ffa90f5f5d0ddacda96#file-configuration-nix-L22
  boot.kernel.sysctl = { "kernel.sysrq" = 1; };
  # https://github.com/NickCao/flakes/blob/baaa99e3b32ca01069443aa0466c6aeefe3620a4/nixos/local/configuration.nix#L79
  boot.kernelParams = [
    "pcie_aspm.policy=performance"
    "nowatchdog"
    "systemd.unified_cgroup_hierarchy=1"
  ];
  # https://wiki.archlinux.org/title/intel_graphics
  boot.extraModprobeConfig = ''
    options i915 enable_guc=2
    options i915 enable_fbc=1
    options i915 fastboot=1
  '';

  # https://github.com/slacka/WoeUSB/issues/299
  boot.supportedFilesystems = [ "ntfs" ];

  boot.tmpOnTmpfs = true;
  boot.cleanTmpDir = true;

  boot.devSize = "32m";
  # https://forums.gentoo.org/viewtopic-t-1103400-start-0.html
  boot.devShmSize = "8192m";
}
