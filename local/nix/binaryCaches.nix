{ ... }:
{
  # sudo nixos-rebuild switch --option substituters https://cache.nixos.org/
  nix.binaryCaches = [
    "https://mirrors.bfsu.edu.cn/nix-channels/store"
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    "https://mirror.sjtu.edu.cn/nix-channels/store"

    "https://nix-community.cachix.org"
    "https://linyinfeng.cachix.org"
    "https://ilya-fedin.cachix.org"
    "https://across.cachix.org"

    "https://kdna.cachix.org/"
    "https://cache.nixos.org/"
  ];

  # warning: substituter 'xxx' does not have a valid signature for path 'xxx'.
  nix.binaryCachePublicKeys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "linyinfeng.cachix.org-1:sPYQXcNrnCf7Vr7T0YmjXz5dMZ7aOKG3EqLja0xr9MM="
    "ilya-fedin.cachix.org-1:QveU24a5ePPMh82mAFSxLk1P+w97pRxqe9rh+MJqlag="
    "across.cachix.org-1:gbHoNiu6UQBGwgEF+zAA00ovBCn5ObAER4KPqGQVI9A="

    "kdna.cachix.org-1:xAkLlelk3u0frMsevzcDLsjGe6ifqXx8q+OrPkbmetI="
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];
}
