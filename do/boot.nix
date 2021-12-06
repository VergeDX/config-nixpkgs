{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = [ "tcp_bbr" ];
  boot.kernel.sysctl = { "net.ipv4.tcp_congestion_control" = "bbr"; };
}
