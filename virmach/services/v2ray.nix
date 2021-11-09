{ ... }:
{
  services.v2ray.enable = true;
  services.v2ray.config = {
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
