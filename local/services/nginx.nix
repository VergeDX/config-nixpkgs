{ ... }:
{
  # https://nixos.wiki/wiki/Nginx#TLS_reverse_proxy
  services.nginx.enable = true;
  services.nginx.recommendedProxySettings = true;
  services.nginx.recommendedTlsSettings = true;

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  services.nginx.virtualHosts."NixOS-Laptop.local" = {
    forceSSL = true;
    sslCertificate = "/run/secrets/nginx/nginx-selfsigned.crt";
    sslCertificateKey = "/run/secrets/nginx/nginx-selfsigned.key";

    locations."/".proxyPass = "https://127.0.0.1:8086";
  };
}
