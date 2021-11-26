{ pkgs, ... }:
{
  home.packages = [
    (pkgs.callPackage ../packages/cutefish/cutefishos-dock.nix { })
    (pkgs.callPackage ../packages/cutefish/cutefishos-filemanager.nix { })
    (pkgs.callPackage ../packages/cutefish/cutefishos-calculator.nix { })
    (pkgs.callPackage ../packages/cutefish/cutefishos-launcher.nix { })
    (pkgs.callPackage ../packages/cutefish/cutefishos-terminal.nix { })
  ];
}
