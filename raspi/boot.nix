{ pkgs, ... }:
{
  # https://github.com/NixOS/nixpkgs/issues/111683#issuecomment-771986512
  # https://forums.xilinx.com/t5/Embedded-Linux/U-boot-v2019-1-ERROR-Did-not-find-a-cmdline-Flattened-Device/td-p/991415
  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.loader.generic-extlinux-compatible.enable = true;
  boot.loader.generic-extlinux-compatible.configurationLimit = 13;
}
