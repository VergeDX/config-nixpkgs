{ pkgs, ... }:
let cutefishos = pkgs.callPackage ../packages/cutefishos { }; in
{
  home.packages = with cutefishos; [
    dock
    filemanager
    calculator
    launcher
    terminal
  ];
}
