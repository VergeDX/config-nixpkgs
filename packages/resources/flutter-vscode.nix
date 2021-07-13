{ pkgs }:
let flutter-override = pkgs.callPackage ../override/flutter-override.nix { };
in
pkgs.stdenv.mkDerivation rec {
  name = "flutter-vscode";
  src = flutter-override.unwrapped;

  installPhase = ''
    mkdir -p $out/opt && cd $out/opt
    cp -r --no-preserve=all ${src} . && mv * flutter
    cd flutter/bin && mv flutter flutter.bak && ln -s ${flutter-override}/bin/flutter .
  '';
}
