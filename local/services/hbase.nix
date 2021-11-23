{ pkgs, lib, config, ... }:
{
  services.hbase.enable = true;
  services.hbase.package = pkgs.hbase;
  services.hbase.settings."hbase.master.info.port" = 60010;

  environment.systemPackages =
    [ config.services.hbase.package ];
}
