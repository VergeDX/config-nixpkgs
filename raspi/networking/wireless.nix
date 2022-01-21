{ ... }:
{
  # https://nixos.wiki/wiki/Wpa_supplicant
  networking.wireless.enable = true;
  networking.wireless.networks = {
    "@Ruijie-s02C6" = { psk = "Jxustnc001"; priority = 0; };
    "Redmi K30" = { psk = "aaf0bc20ba13"; priority = 1; };
    "5522is5522" = { psk = "asdfghjkl"; priority = 0; };
    "Vanilla" = { psk = "@)))!@@%"; priority = 0; };
  };

  # https://github.com/NixOS/nixpkgs/issues/101963#issuecomment-749443985
  networking.wireless.interfaces = [ "wlan0" ];
  networking.interfaces."wlan0".useDHCP = true;
}
