{ pkgs, ... }:
{
  imports = [
    # https://github.com/NixOS/nixpkgs/tree/master/nixos/modules/installer/sd-card
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64-installer.nix>

    # https://github.com/NixOS/nixpkgs/issues/135828
    ./issuecomment-918359063.nix
    ./networking-wireless.nix

    ../nix.nix
  ];
}
