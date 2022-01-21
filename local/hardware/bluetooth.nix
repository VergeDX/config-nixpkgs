{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.hsphfpd.enable = true;

  services.blueman.enable = true;

  # https://forum.manjaro.org/t/bluez-battery-provider/85220
  hardware.bluetooth.settings = {
    "General" = {
      "Experimental" = true;

      # https://github.com/atar-axis/xpadneo/issues/259#issuecomment-921052130
      "Privacy" = "device";
      "JustWorksRepairing" = "always";
      "Class" = "0x000100";
      "FastConnectable" = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;
}
