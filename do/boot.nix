{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  boot.kernel.sysctl."net.ipv4.tcp_fastopen" = 3;
}
