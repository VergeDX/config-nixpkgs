{ pkgs, ... }:
{
  services.nginx.enable = true;
  services.nginx.virtualHosts."vanilla.cyunrei.moe" = {
    # https://nixos.wiki/wiki/Nginx#Minimal_Example
    addSSL = true;

    enableACME = true;
    root = "${pkgs.nginx}/html";
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
