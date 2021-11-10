{ ... }:
{
  networking.hostName = "NixOS-Laptop"; # Define your hostname.
  networking.domain = "vanilla.local";

  # Configure network proxy if necessary
  networking.proxy.default = "http://localhost:8889";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 8080 ];
  networking.firewall.allowedUDPPorts = [ 5353 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.firewall.allowPing = false;
  # networking.firewall.rejectPackets = true;

  # https://nixos.wiki/wiki/Encrypted_DNS#Setting_nameservers
  networking.nameservers = [ "127.0.0.1" "::1" ];
  networking.networkmanager.dns = "none";
}
