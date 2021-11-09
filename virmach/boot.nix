{ pkgs, inputs, system, ... }:
let pkgs-unstable = import inputs.nixos-unstable { inherit system; };
in
{
  boot.kernelPackages = pkgs-unstable.linuxPackages_xanmod;

  boot.kernel.sysctl = {
    # https://sysctl-explorer.net/net/ipv4/tcp_fastopen/
    "net.ipv4.tcp_fastopen" = 3;
  };
}
