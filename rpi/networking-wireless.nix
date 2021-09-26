{ ... }:
{
  # https://nixos.wiki/wiki/Wpa_supplicant
  networking.wireless.enable = true;
  networking.wireless.networks = {
    "@Ruijie-s02C6" = { psk = "Jxustnc001"; priority = 0; };
    "Redmi K30" = { psk = "aaf0bc20ba13"; priority = 1; };
  };

  # https://github.com/NixOS/nixpkgs/issues/101963#issuecomment-749443985
  networking.wireless.interfaces = [ "wlan0" ];

  # https://github.com/NickCao/flakes/blob/master/nixos/rpi/configuration.nix
  networking = { useDHCP = false; useNetworkd = true; };
  networking.interfaces."wlan0".useDHCP = true;

  # https://nix.dev/tutorials/installing-nixos-on-a-raspberry-pi#installing-nixos
  networking.hostName = "NixOS-Raspi";
  networking.domain = "vanilla.local";

  # Configure network proxy if necessary
  networking.proxy.default = "http://NixOS-Laptop.local:7890";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
}
