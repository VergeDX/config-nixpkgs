{ ... }:
{
  # https://nixos.wiki/wiki/Wpa_supplicant
  networking.wireless.enable = true;
  networking.wireless.networks = { "@Ruijie-s02C6".psk = "Jxustnc001"; };

  # https://github.com/NickCao/flakes/blob/master/nixos/rpi/configuration.nix
  networking = { useDHCP = false; useNetworkd = true; };
  systemd.network.networks."wlan0".name = "wlan0";
  systemd.network.networks."wlan0" = { enable = true; DHCP = "yes"; };
}
