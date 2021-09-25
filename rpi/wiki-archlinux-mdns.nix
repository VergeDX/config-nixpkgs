{ ... }:
{
  # https://wiki.archlinux.org/title/Systemd-resolved#mDNS
  services.resolved.extraConfig = "MulticastDNS=yes";
  systemd.network.networks."40-wlan0" = {
    networkConfig = { "MulticastDNS" = true; };
    linkConfig = { "Multicast" = "yes"; };
  };

  # If you plan to use mDNS and use a firewall, make sure to open UDP port 5353.
  networking.firewall.enable = true;
  networking.firewall.allowedUDPPorts = [ 5353 ];
}
