{ ... }:
{
  services.v2ray.enable = true;

  # https://www.v2ray.com/chapter_02/01_overview.html
  services.v2ray.config = {
    # https://www.v2ray.com/chapter_02/01_overview.html#logobject
    # "log"."loglevel" = "info";

    # https://developers.google.com/speed/public-dns/docs/doh
    "dns" = { "servers" = [ "https://dns.google/dns-query" ]; };

    "inbounds" = [
      {
        "port" = 10086;
        "protocol" = "vmess";
        "settings" = { "clients" = [{ "id" = "b831381d-6324-4d53-ad4f-8cda48b30811"; }]; };

        # https://github.com/v2ray/v2ray-core/issues/826
        # https://toutyrater.github.io/advanced/httpfake.html
        "streamSettings"."tcpSettings"."header"."type" = "http";
      }
      {
        "tag" = "tg-in";
        "port" = 443;
        "protocol" = "mtproto";
        "settings" = { "users" = [{ "secret" = "b0cbcef5a486d9636472ac27f8e11a9d"; }]; };
      }
    ];

    "outbounds" = [
      { "protocol" = "freedom"; "settings" = { }; }
      { "tag" = "tg-out"; "protocol" = "mtproto"; "settings" = { }; }
    ];

    # https://www.v2ray.com/chapter_02/protocols/mtproto.html#sample
    "routing"."rules" = [{
      "type" = "field";
      "inboundTag" = [ "tg-in" ];
      "outboundTag" = "tg-out";
    }];
  };

  networking.firewall.allowedTCPPorts = [ 10086 443 ];
  networking.firewall.allowedUDPPorts = [ 10086 443 ];
}
