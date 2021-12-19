{ pkgs, ... }:
{
  services.mysql.enable = true;
  services.mysql.package = pkgs.mysql80;
}
