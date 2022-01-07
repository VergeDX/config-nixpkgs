{ ... }:
{
  networking.hostName = "NixOS-Laptop"; # Define your hostname.
  networking.domain = "vanilla.local";

  # Configure network proxy if necessary
  networking.proxy.default = "http://localhost:8889";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8082 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];

  # https://userbase.kde.org/KDEConnect#I_have_two_devices_running_KDE_Connect_on_the_same_network.2C_but_they_can.27t_see_each_other
  networking.firewall.allowedUDPPortRanges = [{ from = 1714; to = 1764; }];
  networking.firewall.allowedTCPPortRanges = [{ from = 1714; to = 1764; }];

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.firewall.allowPing = false;
  # networking.firewall.rejectPackets = true;
}
