{ ... }:
{
  # https://nixos.wiki/wiki/Encrypted_DNS#Setting_nameservers
  networking.nameservers = [ "127.0.0.1" "::1" ];
  networking.networkmanager.dns = "none";

  # https://nixos.wiki/wiki/Encrypted_DNS#dnscrypt-proxy2
  services.dnscrypt-proxy2.enable = true;
  services.dnscrypt-proxy2.settings = {
    # https://download.dnscrypt.info/resolvers-list/v2/public-resolvers.md
    server_names = [ "alidns-doh" ];
  };
}
