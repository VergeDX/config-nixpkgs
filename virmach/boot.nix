{ pkgs, ... }:
{
  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.kernel.sysctl = {
    # https://sysctl-explorer.net/net/ipv4/tcp_fastopen/
    "net.ipv4.tcp_fastopen" = 3;

    # https://sysctl-explorer.net/net/ipv4/tcp_syncookies/
    "net.ipv4.tcp_max_syn_backlog" = 128 * 8 * 8; # 8192

    # https://blog.cloudflare.com/syn-packet-handling-in-the-wild/
    "net.core.somaxconn" = 16 * 1024;

    # https://gist.github.com/xterat/cefccb42f7d4b2055368ebb00454861f
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_congestion_control" = "bbr";
  };
}
