{ stdenv, fetchgit, cmake, libsForQt5, callPackage, ... }:
let cutefishos-fishui = callPackage ./cutefishos-fishui.nix { }; in
stdenv.mkDerivation rec {
  pname = "cutefishos-terminal";
  version = "0.5";

  src = fetchgit {
    url = "https://github.com/cutefishos/terminal";
    rev = "${version}";
    hash = "sha256-eJkYQY+4on+p2DcebIKbvlGngqboLdMdwEB3JFNRuRE=";
  };

  nativeBuildInputs = [ cmake libsForQt5.wrapQtAppsHook ];
  buildInputs = with libsForQt5; [ qtquickcontrols2 qttools ]
    ++ [ cutefishos-fishui libsForQt5.qtgraphicaleffects ]
    ++ [ libsForQt5.kwindowsystem ];

  # https://github.com/cutefishos/terminal/blob/0.5/CMakeLists.txt#L58
  patchPhase = ''
    sed -i 's@/usr/@@g' CMakeLists.txt
    sed -i '22,25d' CMakeLists.txt
  '';

  # https://github.com/cutefishos/terminal/blob/0.5/CMakeLists.txt#L22
  cmakeFlags = [ "-DINSTALL_QMLDIR=lib/qt-${libsForQt5.qtbase.version}/qml" ];
}
