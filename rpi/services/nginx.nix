{ ... }:
{
  # https://nixos.wiki/wiki/Nginx#TLS_reverse_proxy
  services.nginx.enable = true;
  services.nginx.recommendedProxySettings = true;
  services.nginx.recommendedTlsSettings = true;

  networking.firewall.allowedTCPPorts = [ 80 443 ];
  services.nginx.virtualHosts."NixOS-Raspi.local" = {
    forceSSL = true;

    # https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04
    sslCertificate = "/run/secrets/nginx/nginx-selfsigned.crt";
    sslCertificateKey = "/run/secrets/nginx/nginx-selfsigned.key";

    locations."/".proxyPass = "https://127.0.0.1:8086";
    # https://nginx.org/en/docs/http/ngx_http_stub_status_module.html
    locations."/basic_status".extraConfig = "stub_status;"
      # https://serverfault.com/questions/667798
      + "allow 127.0.0.1;" + "deny all;";
  };
}
