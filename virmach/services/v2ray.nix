{ ... }:
{
  services.v2ray.enable = true;

  # https://www.v2ray.com/chapter_02/01_overview.html
  services.v2ray.config = {
    # https://adguard-dns.com/zh_cn/public-dns.html
    "dns" = { "servers" = [ "https://dns.adguard.com/dns-query" ]; };

    "inbounds" = [{
      "port" = 10086;
      "protocol" = "vmess";
      "settings" = { "clients" = [{ "id" = "b831381d-6324-4d53-ad4f-8cda48b30811"; }]; };
    }];

    "outbounds" = [{
      "protocol" = "freedom";
      "settings" = { };
    }];
  };

  networking.firewall.allowedTCPPorts = [ 10086 ];
  networking.firewall.allowedUDPPorts = [ 10086 ];
}
