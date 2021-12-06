{ ... }:
{
  services.nginx.enable = true;
  services.nginx.virtualHosts."vanilla.scp.link" = {
    addSSL = true;
    enableACME = true;

    locations."/ray" = {
      proxyPass = "http://127.0.0.1:10000";
      proxyWebsockets = true;
    };
  };

  security.acme.acceptTerms = true;
  security.acme.email = "osu_Vanilla@126.com";

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  networking.firewall.allowedUDPPorts = [ 80 443 ];
}
