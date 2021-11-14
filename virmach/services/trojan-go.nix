{ ... }:
{
  imports = [ ../../modules/trojan-go.nix ];

  services.trojan-go.enable = true;
  # https://p4gefau1t.github.io/trojan-go/basic/config/
  services.trojan-go.config = {
    "run_type" = "server";
    "local_addr" = "0.0.0.0";
    "local_port" = 4433;
    "remote_addr" = "127.0.0.1";
    "remote_port" = 80;
    "password" = [ "your_awesome_password" ];
    "ssl" = {
      "cert" = "/var/lib/acme/vanilla.cyunrei.moe/cert.pem";
      "key" = "/var/lib/acme/vanilla.cyunrei.moe/key.pem";
      "fallback_port" = 443;
    };

    # https://p4gefau1t.github.io/trojan-go/advance/websocket/
    "websocket" = {
      "enabled" = true;
      "path" = "/your-websocket-path";
      "host" = "vanilla.cyunrei.moe";
    };
  };

  networking.firewall.allowedTCPPorts = [ 4433 ];
  networking.firewall.allowedUDPPorts = [ 4433 ];
}
