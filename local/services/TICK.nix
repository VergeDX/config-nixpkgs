{ config, lib, ... }:
{
  # https://wiki.archlinux.org/title/TICK_stack
  services.influxdb2.enable = true;

  # https://nixos.wiki/wiki/Nginx#TLS_reverse_proxy
  services.nginx.enable = true;
  services.nginx.virtualHosts."localhost".locations = {
    "/".proxyPass = "http://127.0.0.1:8086";
    # "/server_status".extraConfig = "stub_status;";
  };

  services.telegraf.enable = true;
  services.telegraf.environmentFiles =
    [ "/run/agenix/TICK/INFLUX_TOKEN" ];

  systemd.services."telegraf".serviceConfig = {
    "ExecStart" = lib.mkForce ("${config.services.telegraf.package}/bin/telegraf" + " "
      + "--config" + " " + "http://127.0.0.1:8086/api/v2/telegrafs/08be32874d1a3000");
  };
}
