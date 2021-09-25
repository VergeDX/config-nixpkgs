{ ... }: {
  imports = [
    # https://nixos.wiki/wiki/NixOS_on_ARM#Build_your_own_image
    <nixpkgs/nixos/modules/installer/sd-card/sd-image-aarch64.nix>
    ./configuration.nix
  ];

  # https://github.com/NixOS/nixpkgs/blob/6845a74d4c85e0a392ee82a829d7fc8c9ecf4f08/nixos/modules/installer/sd-card/sd-image.nix#L137
  sdImage.compressImage = false;
}
