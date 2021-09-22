{ pkgs, ... }:
{
  imports = [
    # https://github.com/NixOS/nixpkgs/tree/master/nixos/modules/installer/sd-card
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64-installer.nix>

    # https://github.com/NixOS/nixpkgs/issues/135828
    ./patch/issuecomment-918359063.nix
    # https://github.com/NixOS/nixpkgs/issues/138900
    ./patch/issuecomment-924816587.nix

    ./network.nix
  ];
}
