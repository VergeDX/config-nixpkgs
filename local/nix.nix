{ pkgs, lib, config, ... }:
{
  # https://nixos.wiki/wiki/Flakes
  nix.package = pkgs.nixUnstable;
  nix.extraOptions = "experimental-features = nix-command flakes";

  # https://nixos.org/manual/nixpkgs/stable/#submitting-changes-tested-with-sandbox
  nix.useSandbox = true;

  # https://github.com/NickCao/flakes/blob/baaa99e3b32ca01069443aa0466c6aeefe3620a4/nixos/local/configuration.nix#L15
  nix.autoOptimiseStore = true;

  # btrfs filesystem defragment -r -v -czstd /
  # nix.readOnlyStore = false;

  # sudo nixos-rebuild switch --option substituters https://cache.nixos.org/
  nix.binaryCaches = [
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    "https://mirrors.bfsu.edu.cn/nix-channels/store"
    "https://cache.nixos.org/"
  ];
}
