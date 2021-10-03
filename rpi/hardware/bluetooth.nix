{ ... }:
{
  # https://nixos.wiki/wiki/Bluetooth#Enabling_Bluetooth_support
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}
