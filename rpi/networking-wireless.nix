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
  systemd.network.networks."wlan0" = { name = "wlan0"; enable = true; DHCP = "yes"; };

  # https://wiki.archlinux.org/title/Systemd-networkd_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)#[Network]_%E5%B0%8F%E8%8A%82
  systemd.network.networks."wlan0".networkConfig = { "MulticastDNS" = true; };

  # https://nix.dev/tutorials/installing-nixos-on-a-raspberry-pi#installing-nixos
  networking.hostName = "nixos-rpi";
  networking.domain = "vanilla.local";
}
