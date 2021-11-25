{ pkgs, ... }:
{
  home.packages = [
    (pkgs.callPackage ../packages/lirios/lirios-browser.nix { })
    (pkgs.callPackage ../packages/lirios/lirios-fluid.nix { })
  ];
}
