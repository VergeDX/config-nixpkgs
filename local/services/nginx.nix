{ pkgs, ... }:
{
  services.nginx.enable = true;
  services.nginx.virtualHosts."NixOS-Laptop.local" = {
    root = "${pkgs.nginx}/html";
  };
}
