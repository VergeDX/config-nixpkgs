{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ iperf screen ];
  networking.firewall.allowedTCPPorts = [ 5201 ];
  networking.firewall.allowedUDPPorts = [ 5201 ];
}
