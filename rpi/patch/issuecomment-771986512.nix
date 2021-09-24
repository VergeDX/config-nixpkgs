{ pkgs, ... }:
{
  # https://forums.xilinx.com/t5/Embedded-Linux/U-boot-v2019-1-ERROR-Did-not-find-a-cmdline-Flattened-Device/td-p/991415
  boot.kernelPackages = pkgs.linuxPackages;
}
