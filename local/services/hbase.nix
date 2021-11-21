{ pkgs, lib, config, inputs, ... }:
{
  disabledModules = [ "services/databases/hbase.nix" ];
  imports = [ "${inputs.nixpkgs-master}/nixos/modules/services/databases/hbase.nix" ];

  services.hbase.enable = true;
  services.hbase.package = pkgs.hbase;
  services.hbase.settings."hbase.master.info.port" = 60010;

  environment.systemPackages =
    [ config.services.hbase.package ];
}
