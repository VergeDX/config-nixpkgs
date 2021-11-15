{ config, wget, lib, pkgs, ... }:
{
  services.telegraf.enable = true;
  services.telegraf.environmentFiles =
    [ "/run/secrets/telegraf/INFLUX_TOKEN.env" ];

  # NixOS - nixpkgs: nixos/modules/services/monitoring/telegraf.nix
  systemd.services."telegraf".serviceConfig."ExecStart" = lib.mkForce
    # https://unix.stackexchange.com/questions/216780
    ("${pkgs.bash}/bin/bash" + " " + "-c" + " " + "\"" +
      "${config.services.telegraf.package}/bin/telegraf" + " " +
      "-config" + " " + "$$(cat /run/secrets/telegraf/config_url)" + "\"");

  systemd.services."telegraf".serviceConfig."AmbientCapabilities" = [ "CAP_DAC_OVERRIDE" ];
  systemd.services."telegraf".serviceConfig."CapabilityBoundingSet" = [ "CAP_DAC_OVERRIDE" ];
}
