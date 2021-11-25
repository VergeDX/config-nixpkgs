{ stdenv, fetchgit, cmake, callPackage, extra-cmake-modules, libsForQt5, ... }:
let lirios-cmake-shared = callPackage ./lirios-cmake-shared.nix { }; in
let lirios-fluid = callPackage ./lirios-fluid.nix { }; in
stdenv.mkDerivation rec {
  pname = "lirios-browser";
  version = "fe29ad5";

  src = fetchgit {
    url = "https://github.com/lirios/browser";
    rev = "${version}15af121c5326ce84bb968ba27b4499b30";
    hash = "sha256-S6HYcuUYPKWs0PFWrWmTan4eDLEUkJihwX0O5PUMMzg=";
  };

  nativeBuildInputs = [ cmake libsForQt5.wrapQtAppsHook ];
  buildInputs = [ lirios-cmake-shared extra-cmake-modules ]
    ++ (with libsForQt5; [ qtquickcontrols2 qtwebengine qttools ])
    ++ [ lirios-fluid libsForQt5.qtgraphicaleffects ];

  preFixup = "qtWrapperArgs+=(--prefix QML2_IMPORT_PATH : ${lirios-fluid}/lib/qml/)";
}
