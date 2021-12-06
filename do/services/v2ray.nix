{ lib, pkgs, ... }:
let config_JSON = lib.strings.toJSON {
  "inbounds" = [
    {
      "port" = 10000;
      "listen" = "127.0.0.1";

      "protocol" = "vmess";
      "settings" = { "clients" = [{ "id" = "@id@"; }]; };

      "streamSettings" = {
        "network" = "ws";
        "wsSettings" = { "path" = "/ray"; };
      };
    }
  ];

  "outbounds" = [
    { "protocol" = "freedom"; }
  ];
};
in
{
  services.v2ray.enable = true;
  services.v2ray.configFile = "/etc/v2ray/Vanilla-V2Ray.json";

  system.activationScripts."Vanilla-V2Ray.json".deps = [ "agenixRoot" ];
  system.activationScripts."Vanilla-V2Ray.json".text = ''
    mkdir -p /etc/v2ray && rm /etc/v2ray/Vanilla-V2Ray.json || true
    echo '${config_JSON}' > /etc/v2ray/Vanilla-V2Ray.json && id="$(cat /run/agenix/v2ray/id)"
    ${pkgs.gnused}/bin/sed -i "s/@id@/$id/g" /etc/v2ray/Vanilla-V2Ray.json
  '';
}
