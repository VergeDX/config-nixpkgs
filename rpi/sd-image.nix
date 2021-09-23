{ pkgs, ... }:
{
  imports = [
    # https://nixos.wiki/wiki/NixOS_on_ARM#Build_your_own_image
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>

    # https://github.com/NixOS/nixpkgs/issues/135828
    ./issuecomment-918359063.nix

    ./networking-wireless.nix
    ./nix-binary-caches.nix

    ./users.nix
  ];
}
