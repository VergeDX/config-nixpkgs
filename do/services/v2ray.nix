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
        "wsSettings" = { "path" = "@path@"; };
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
  # https://stackoverflow.com/questions/9366816/sed-fails-with-unknown-option-to-s-error
  system.activationScripts."Vanilla-V2Ray.json".text = ''
    mkdir -p /etc/v2ray && rm /etc/v2ray/Vanilla-V2Ray.json || true
    echo '${config_JSON}' > /etc/v2ray/Vanilla-V2Ray.json

    id="$(cat /run/agenix/v2ray/id)" && path="$(cat /run/agenix/v2ray/path)"
    ${pkgs.gnused}/bin/sed -i "s|@id@|$id|g" /etc/v2ray/Vanilla-V2Ray.json
    ${pkgs.gnused}/bin/sed -i "s|@path@|$path|g" /etc/v2ray/Vanilla-V2Ray.json
  '';
}
