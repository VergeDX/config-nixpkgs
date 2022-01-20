{ ... }:
{
  # https://nixos.wiki/wiki/Encrypted_DNS#Setting_nameservers
  networking.nameservers = [ "127.0.0.1" "::1" ];
  networking.networkmanager.dns = "none";

  # https://nixos.wiki/wiki/Encrypted_DNS#dnscrypt-proxy2
  services.dnscrypt-proxy2.enable = true;
  services.dnscrypt-proxy2.settings = {
    # https://github.com/DNSCrypt/dnscrypt-proxy/issues/1301
    # https://dnscrypt.info/stamps/ | https://owo.418.im/teapot
    static."@MidAutumnHotaru" = {
      "stamp" = "sdns://AgcAAAAAAAAAAAAKb3dvLjQxOC5pbQcvdGVhcG90";
    };

    # https://download.dnscrypt.info/resolvers-list/v2/public-resolvers.md
    server_names = [ "@MidAutumnHotaru" ] ++ [ "alidns-doh" "dnspod-doh" ];
  };
}
