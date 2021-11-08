{ pkgs, ... }:
{
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.font = "${pkgs.hack-font}/share/fonts/hack/Hack-Regular.ttf";

  # https://opensource.com/article/21/8/linux-kernel-module
  zramSwap.enable = true;

  # https://gist.github.com/manuelmazzuola/4ffa90f5f5d0ddacda96#file-configuration-nix-L22
  boot.kernel.sysctl = { "kernel.sysrq" = 1; };

  boot.kernelPackages = pkgs.linuxPackages_xanmod;

  # https://github.com/slacka/WoeUSB/issues/299
  boot.supportedFilesystems = [ "ntfs" ];

  boot.tmpOnTmpfs = true;
  boot.cleanTmpDir = true;

  boot.devSize = "32m";
  # https://forums.gentoo.org/viewtopic-t-1103400-start-0.html
  boot.devShmSize = "8192m";
}
