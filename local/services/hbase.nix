{ pkgs, lib, ... }:
{
  services.hbase.enable = true;
  services.hbase.package = pkgs.hbase;

  systemd.services."hbase".environment = {
    # NixOS - nixpkgs: nixos/modules/services/databases/hbase.nix
    "JAVA_HOME" = lib.mkForce "${pkgs.jre8}";
  };
}
