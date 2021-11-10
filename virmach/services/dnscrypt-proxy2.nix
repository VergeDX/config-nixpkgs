{ ... }:
{
  services.dnscrypt-proxy2.enable = true;
  services.dnscrypt-proxy2.settings.server_names = [ "google" ];
}
