{ ... }:
{
  networking.firewall.allowPing = false;
  # networking.firewall.rejectPackets = true;

  networking.firewall.logRefusedUnicastsOnly = false;
  networking.firewall.logRefusedConnections = false;
}
