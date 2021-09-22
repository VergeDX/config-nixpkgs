{ ... }:
{
  # https://unix.stackexchange.com/questions/398690
  systemd.services."wpa_supplicant".serviceConfig = { "Type" = "dbus"; };
}
