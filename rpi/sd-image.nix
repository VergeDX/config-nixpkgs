{ pkgs, ... }:
{
  imports = [
    # https://github.com/NixOS/nixpkgs/tree/master/nixos/modules/installer/sd-card
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64-installer.nix>
    # https://github.com/NixOS/nixpkgs/issues/135828
    ./issuecomment-918359063.nix
  ];

  # https://nixos.wiki/wiki/Wpa_supplicant
  networking.wireless.enable = true;
  networking.wireless.networks = { "@Ruijie-s02C6".psk = "Jxustnc001"; };

  # https://github.com/NickCao/flakes/blob/master/nixos/rpi/configuration.nix
  networking = { useDHCP = false; useNetworkd = true; };
  systemd.network.networks."wlan0".name = "wlan0";
  systemd.network.networks."wlan0" = { enable = true; DHCP = "yes"; };
}
