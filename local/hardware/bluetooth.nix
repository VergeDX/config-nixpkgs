{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # https://forum.manjaro.org/t/bluez-battery-provider/85220
  hardware.bluetooth.settings = {
    "General" = {
      "Experimental" = true;
    };
  };

  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  # https://raspberrypi.stackexchange.com/questions/40839/sap-error-on-bluetooth-service-status
  # https://github.com/NixOS/nixpkgs/issues/63703
  systemd.services.bluetooth.serviceConfig.ExecStart = [
    ""
    "${pkgs.bluez}/libexec/bluetooth/bluetoothd --noplugin=sap"
  ];
}
