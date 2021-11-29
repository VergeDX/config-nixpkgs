{ pkgs, lib, config, ... }:
{
  services.hbase.enable = true;
  services.hbase.package = pkgs.hbase;
  services.hbase.settings."hbase.master.info.port" = 60010;

  environment.systemPackages = [
    (config.services.hbase.package.overrideAttrs (old: {
      # NixOS/nixpkgs - nixpkgs/pkgs/servers/hbase/default.nix
      installPhase = old.installPhase +
        "wrapProgram $out/bin/hbase --prefix JAVA_HOME : ${pkgs.jre8}";
    }))
  ];
}
