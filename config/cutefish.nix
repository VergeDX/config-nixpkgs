{ pkgs, ... }:
{
  home.packages = [
    (pkgs.callPackage ../packages/cutefish/cutefishos-dock.nix { })
    (pkgs.callPackage ../packages/cutefish/cutefishos-filemanager.nix { })
  ];
}
