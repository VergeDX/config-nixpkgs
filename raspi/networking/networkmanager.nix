{ ... }:
{
  networking.networkmanager.enable = true;
  networking.networkmanager.unmanaged = [ "wlan0" ];
}
