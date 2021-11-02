{ ... }:
{
  # https://nixos.wiki/wiki/Encrypted_DNS#dnscrypt-proxy2
  services.dnscrypt-proxy2.enable = true;
  services.dnscrypt-proxy2.settings = {
    # https://download.dnscrypt.info/resolvers-list/v2/public-resolvers.md
    server_names = [ "alidns-doh" ];
  };
}
