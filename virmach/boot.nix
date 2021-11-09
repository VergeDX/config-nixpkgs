{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_xanmod;
  boot.kernel.sysctl = {
    # https://sysctl-explorer.net/net/ipv4/tcp_fastopen/
    "net.ipv4.tcp_fastopen" = 3;
  };
}
