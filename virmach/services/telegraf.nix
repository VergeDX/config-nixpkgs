{ config, wget, lib, pkgs, ... }:
{
  services.telegraf.enable = true;

  services.telegraf.environmentFiles = [ "/run/secrets/telegraf/INFLUX_TOKEN.env" ];
  systemd.services."telegraf".serviceConfig."Environment" =
    [ "INFLUX_HOST=https://vanilla.cyunrei.moe" "INFLUX_ORG=NixOS" "INFLUX_BUCKET=default" ];
  systemd.services."telegraf".path = [ pkgs.fail2ban ];

  # NixOS - nixpkgs: nixos/modules/services/monitoring/telegraf.nix
  systemd.services."telegraf".serviceConfig."ExecStart" = lib.mkForce
    "${pkgs.telegraf}/bin/telegraf --config-directory /etc/telegraf/telegraf.d/";

  # https://github.com/influxdata/telegraf/issues/491
  system.activationScripts."Build-Telegraf-config".deps = [ "agenixRoot" ];
  system.activationScripts."Build-Telegraf-config".text = ''
    rm -rf /etc/telegraf/ && true
    mkdir -p /etc/telegraf/telegraf.d && cd "$_"

    # https://docs.influxdata.com/influxdb/cloud/security/tokens/create-token/
    export $(cat /run/secrets/telegraf/INFLUX_TOKEN.env)
    ${pkgs.curl}/bin/curl  $(cat /run/secrets/telegraf/config_url/system) \
      --header "Authorization: Token $INFLUX_TOKEN" > ../telegraf.conf
    ${pkgs.curl}/bin/curl  $(cat /run/secrets/telegraf/config_url/fail2ban) \
      --header "Authorization: Token $INFLUX_TOKEN" > fail2ban.conf
  '';

  systemd.services."telegraf".serviceConfig."AmbientCapabilities" = [ "CAP_DAC_OVERRIDE" ];
  systemd.services."telegraf".serviceConfig."CapabilityBoundingSet" = [ "CAP_DAC_OVERRIDE" ];
}
