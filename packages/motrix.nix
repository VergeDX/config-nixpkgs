{ pkgs }:
let motrix = pkgs.stdenv.mkDerivation rec {
  name = "motrix";
  version = "1.6.11";

  src = pkgs.fetchurl {
    url = "https://github.com/agalwood/Motrix/releases/download/v1.6.11/Motrix-1.6.11.AppImage";
    sha256 = "sha256-tE2Q7NM+cQOg+vyqyfRwg05EOMQWhhggTA6S+VT+SkM=";
  };

  unpackPhase = "echo";
  installPhase = "echo";
};
in
pkgs.buildFHSUserEnv {
  name = motrix.name;
  targetPkgs = pkgs: [ pkgs.appimage-run ];
  runScript = "appimage-run ${motrix.src}";
}
