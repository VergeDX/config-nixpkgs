{ nixos-unstable, lib, ... }:
{
  # NixOS - nixpkgs: nixos/modules/services/databases/influxdb2.nix
  imports = [ "${nixos-unstable}/nixos/modules/services/databases/influxdb2.nix" ];

  services.influxdb2.enable = true;
  # https://docs.influxdata.com/influxdb/v2.0/security/enable-tls/
  services.influxdb2.settings = {
    "tls-cert" = "/var/lib/acme/vanilla.cyunrei.moe/cert.pem";
    "tls-key" = "/var/lib/acme/vanilla.cyunrei.moe/key.pem";

    # https://docs.influxdata.com/influxdb/v2.1/reference/config-options/#http-bind-address
    "http-bind-address" = "127.0.0.1:8086";
  };

  # https://www.freedesktop.org/software/systemd/man/systemd.exec.html#Capabilities
  # https://unix.stackexchange.com/questions/580597
  systemd.services."influxdb2".serviceConfig = {
    "AmbientCapabilities" = [ "CAP_DAC_OVERRIDE" ];
    "CapabilityBoundingSet" = lib.mkForce "CAP_DAC_OVERRIDE";
  };
}
