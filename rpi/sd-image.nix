{ ... }: {
  imports = [
    # https://nixos.wiki/wiki/NixOS_on_ARM#Build_your_own_image
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
    ./configuration.nix
  ];
}
