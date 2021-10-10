{ pkgs, ... }:
{
  # https://nixos.wiki/wiki/Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  hardware.enableAllFirmware = true;

  # https://raspberrypi.stackexchange.com/questions/40839/sap-error-on-bluetooth-service-status
  # https://github.com/NixOS/nixpkgs/issues/63703
  systemd.services.bluetooth.serviceConfig.ExecStart = [
    ""
    "${pkgs.bluez}/libexec/bluetooth/bluetoothd --noplugin=sap"
  ];

  # https://github.com/atar-axis/xpadneo/issues/259#issuecomment-918469473
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.bluetooth.settings."General" = {
    "Privacy" = "device";
    "JustWorksRepairing" = "always";
    "Class" = "0x000100";
    "FastConnectable" = "true";
  };
}
