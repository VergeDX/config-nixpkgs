{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;
  hardware.bluetooth.hsphfpd.enable = true;

  services.blueman.enable = true;

  # https://forum.manjaro.org/t/bluez-battery-provider/85220
  hardware.bluetooth.settings = {
    "General" = {
      "Experimental" = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;
}
