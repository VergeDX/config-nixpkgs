{ nixos-unstable, lib, ... }:
{
  # NixOS - nixpkgs: nixos/modules/services/databases/influxdb2.nix
  imports = [ "${nixos-unstable}/nixos/modules/services/databases/influxdb2.nix" ];

  services.influxdb2.enable = true;
  # https://docs.influxdata.com/influxdb/v2.0/security/enable-tls/
  services.influxdb2.settings = {
    "tls-cert" = "/var/lib/acme/vanilla.cyunrei.moe/cert.pem";
    "tls-key" = "/var/lib/acme/vanilla.cyunrei.moe/key.pem";
  };

  # https://www.freedesktop.org/software/systemd/man/systemd.exec.html#Capabilities
  # https://unix.stackexchange.com/questions/580597
  systemd.services."influxdb2".serviceConfig = {
    "AmbientCapabilities" = [ "CAP_DAC_OVERRIDE" ];
    "CapabilityBoundingSet" = lib.mkForce "CAP_DAC_OVERRIDE";
  };

  networking.firewall.allowedTCPPorts = [ 8086 ];
  networking.firewall.allowedUDPPorts = [ 8086 ];
}
