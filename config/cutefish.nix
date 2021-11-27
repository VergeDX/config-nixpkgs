{ pkgs, ... }:
let cutefishos = pkgs.callPackage ../packages/cutefishos { }; in
{
  home.packages = with cutefishos;
    [ calculator dock filemanager launcher terminal ];
}
