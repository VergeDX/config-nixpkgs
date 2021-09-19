{ pkgs, ... }:
{
  imports = [
    # https://nixos.wiki/wiki/NixOS_on_ARM#Build_your_own_image
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
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
