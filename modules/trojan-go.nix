{ lib, config, pkgs, ... }:
let cfg = config.services.trojan-go; in
{
  options = with lib; {
    services.trojan-go = {
      enable = mkOption {
        type = types.bool;
        default = false;
      };

      config = mkOption {
        # NixOS - nixpkgs: nixos/modules/services/networking/v2ray.nix
        type = types.nullOr (types.attrsOf types.unspecified);
        default = null;
      };

      package = mkOption {
        type = types.package;
        default = pkgs.callPackage ../packages/cli/trojan-go.nix { };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [{
      assertion = cfg.config != null;
      message = "[trojan-go] Option \"config\" is required, type = object. ";
    }];

    # p4gefau1t/trojan-go - example/trojan-go.service
    systemd.services."trojan-go" = {
      description = "Trojan-Go - An unidentifiable mechanism that helps you bypass GFW";
      documentation = [ "https://p4gefau1t.github.io/trojan-go/" ];
      after = [ "network.target" "nss-lookup.target" ];

      serviceConfig = {
        # Special user nobody configured, this is not safe!
        "User" = "nobody";

        # https://man7.org/linux/man-pages/man7/capabilities.7.html
        "CapabilityBoundingSet" = [ "CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE" ] ++ [ "CAP_DAC_OVERRIDE" ];
        "AmbientCapabilities" = [ "CAP_NET_ADMIN" "CAP_NET_BIND_SERVICE" ] ++ [ "CAP_DAC_OVERRIDE" ];

        "NoNewPrivileges" = true;

        "ExecStart" = ''
          ${cfg.package}/bin/trojan-go -config \
            ${pkgs.writeTextFile { name = "trojan-go.json"; text = builtins.toJSON cfg.config; }}
        '';

        "Restart" = "on-failure";
        "RestartSec" = "10s";
        "LimitNOFILE" = "infinity";
      };

      wantedBy = [ "multi-user.target" ];
    };
  };
}
