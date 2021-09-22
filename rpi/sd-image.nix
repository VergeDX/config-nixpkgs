{ pkgs, ... }:
{
  imports = [
    # https://github.com/NixOS/nixpkgs/tree/master/nixos/modules/installer/sd-card
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64-installer.nix>
    # https://github.com/NixOS/nixpkgs/issues/135828
    ./issuecomment-918359063.nix

    ./network.nix
  ];

  # https://unix.stackexchange.com/questions/398690
  systemd.services."wpa_supplicant".serviceConfig = { "Type" = "dbus"; };
}
