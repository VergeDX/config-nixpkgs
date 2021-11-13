{ lib, pkgs, ... }:
# https://www.v2ray.com/chapter_02/01_overview.html
let config_JSON = lib.strings.toJSON {
  # https://www.v2ray.com/chapter_02/01_overview.html#logobject
  # "log"."loglevel" = "info";

  "inbounds" = [
    {
      "port" = 10000;
      "listen" = "127.0.0.1";

      "protocol" = "vmess";
      "settings" = { "clients" = [{ "id" = "@id@"; }]; };

      # https://guide.v2fly.org/advanced/wss_and_web.html
      "streamSettings" = {
        "network" = "ws";
        "wsSettings" = { "path" = "/ray"; };
      };
    }
    {
      "tag" = "tg-in";
      "port" = 4433;
      "protocol" = "mtproto";
      "settings" = { "users" = [{ "secret" = "@secret@"; }]; };
    }
  ];

  "outbounds" = [
    # https://www.4spaces.org/v2ray-google-check/
    { "protocol" = "freedom"; "settings" = { "domainStrategy" = "UseIPv4"; }; }
    { "tag" = "tg-out"; "protocol" = "mtproto"; "settings" = { }; }
  ];

  # https://www.v2ray.com/chapter_02/protocols/mtproto.html#sample
  "routing"."rules" = [{
    "type" = "field";
    "inboundTag" = [ "tg-in" ];
    "outboundTag" = "tg-out";
  }];
};
in
{
  services.v2ray.enable = true;
  services.v2ray.configFile = "/etc/v2ray/Vanilla-V2Ray.json";

  system.activationScripts."Vanilla-V2Ray.json".deps = [ "agenixRoot" ];
  system.activationScripts."Vanilla-V2Ray.json".text = ''
    rm -r /etc/v2ray && mkdir /etc/v2ray || true
    echo '${config_JSON}' > /etc/v2ray/Vanilla-V2Ray.json
    id="$(cat /run/secrets/v2ray/id)" && secret="$(cat /run/secrets/v2ray/secret)"
    ${pkgs.gnused}/bin/sed -i "s/@id@/$id/g" /etc/v2ray/Vanilla-V2Ray.json
    ${pkgs.gnused}/bin/sed -i "s/@secret@/$secret/g" /etc/v2ray/Vanilla-V2Ray.json
  '';

  networking.firewall.allowedTCPPorts = [ 4433 ];
  networking.firewall.allowedUDPPorts = [ 4433 ];
}
