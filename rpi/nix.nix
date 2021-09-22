{ ... }:
{
  # https://mirrors.tuna.tsinghua.edu.cn/help/nix/
  # https://mirrors.bfsu.edu.cn/help/nix/
  nix.binaryCaches = [
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    "https://mirrors.bfsu.edu.cn/nix-channels/store"
    "https://cache.nixos.org/"
  ];
}
