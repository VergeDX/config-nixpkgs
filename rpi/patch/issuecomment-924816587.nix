{ ... }:
{
  # https://unix.stackexchange.com/questions/398690
  networking.wireless.interfaces = [ "wlan0" ];
  systemd.services."wpa_supplicant".serviceConfig = { "Type" = "dbus"; };
}
