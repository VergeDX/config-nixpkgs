{ stdenv, fetchgit, cmake, libsForQt5, extra-cmake-modules, ... }:
stdenv.mkDerivation rec {
  pname = "cutefishos-fishui";
  version = "0.5";

  src = fetchgit {
    url = "https://github.com/cutefishos/fishui";
    rev = "${version}";
    hash = "sha256-KyvQi0SN2KmBdEx2k6fS2NbeF+rCFwFeJLV8eSVPTc8=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = with libsForQt5; [ qtbase qtdeclarative qtquickcontrols2 qtx11extras kwindowsystem ]
    ++ [ extra-cmake-modules ];
  dontWrapQtApps = true;

  patches = [ ./no-query-qt-install-qml.patch ];
  #  https://github.com/cutefishos/fishui/blob/0.5/CMakeLists.txt#L54
  cmakeFlags = [ "-DINSTALL_QMLDIR=lib/qt-${libsForQt5.qtbase.version}/qml" ];
}
