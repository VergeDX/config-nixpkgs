{ ... }:
{
  # sudo nixos-rebuild switch --option substituters https://cache.nixos.org/
  nix.binaryCaches = [
    # "https://mirrors.bfsu.edu.cn/nix-channels/store"
    # "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    "https://mirror.sjtu.edu.cn/nix-channels/store"
    "https://nix-community.cachix.org"
    "https://cache.nixos.org/"
  ];

  # warning: substituter 'xxx' does not have a valid signature for path 'xxx'.
  nix.binaryCachePublicKeys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
  ];
}
