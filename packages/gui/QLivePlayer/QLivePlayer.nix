{ stdenv, fetchgit, cmake, extra-cmake-modules, mpv, cargo, rustc, libsForQt5, callPackage, ... }:
let QLivePlayer-Lib = callPackage ./QLivePlayer-Lib.nix { }; in
stdenv.mkDerivation rec {
  pname = "QLivePlayer";
  version = "4.1.1";

  src = fetchgit {
    url = "https://github.com/THMonster/${pname}";
    rev = "${version}";
    hash = "sha256-qhFcUzTV4F6UVP14XuEYp4KWalQwnMBItA7J8rzyHNY=";
  };

  patches = [ ./no-cargo-build.patch ];
  patchPhase = ''
    mkdir -p src/QLivePlayer-Lib/target/release/
    ln -s ${QLivePlayer-Lib}/lib/librust.a \
      src/QLivePlayer-Lib/target/release/librust.a
  '';

  nativeBuildInputs = [ cmake cargo rustc ]
    ++ [ libsForQt5.wrapQtAppsHook ];
  buildInputs = [ extra-cmake-modules mpv ]
    ++ [ libsForQt5.qt5.qtquickcontrols2 ];
}
