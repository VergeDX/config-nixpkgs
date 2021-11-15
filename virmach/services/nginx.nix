{ pkgs, ... }:
{
  services.nginx.enable = true;
  services.nginx.virtualHosts."vanilla.cyunrei.moe" = {
    # https://nixos.wiki/wiki/Nginx#Minimal_Example
    addSSL = true;

    enableACME = true;
    locations."/".proxyPass = "https://127.0.0.1:8086";

    # https://nixos.wiki/wiki/Nginx#TLS_reverse_proxy
    locations."/ray" = {
      proxyPass = "http://127.0.0.1:10000";
      proxyWebsockets = true;
    };
  };

  security.acme.email = "osu_Vanilla@126.com";
  security.acme.acceptTerms = true;

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 80 443 ];

  # NixOS - search - "services.nginx" + "recommended"
  services.nginx.recommendedOptimisation = true;
  services.nginx.recommendedTlsSettings = true;
  services.nginx.recommendedGzipSettings = true;
  services.nginx.recommendedProxySettings = true;
}
