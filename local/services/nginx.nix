{ pkgs, ... }:
{
  services.nginx.enable = true;
  services.nginx.virtualHosts."NixOS-Laptop.local" = {
    # https://nixos.wiki/wiki/Nginx#TLS_reverse_proxy
    locations."/".proxyPass = "http://127.0.0.1:9870";
  };
}
