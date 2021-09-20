{ pkgs, ... }:
{
  imports = [
    # https://github.com/NixOS/nixpkgs/tree/master/nixos/modules/installer/sd-card
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64-installer.nix>
    # https://github.com/NixOS/nixpkgs/issues/135828
    ./issuecomment-918359063.nix
  ];

  ## Build
  # boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  # nix-build '<nixpkgs/nixos>' -A config.system.build.sdImage -I nixos-config=./sd-image.nix
  # --argstr system aarch64-linux

  ## Install
  # https://www.raspberrypi.org/documentation/computers/getting-started.html#installing-images-on-linux
  # sudo dd += bs=4M conv=fsync status=progress
}
