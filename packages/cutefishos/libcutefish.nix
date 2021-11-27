{ stdenv, fetchgit, cmake, libsForQt5, ... }:
stdenv.mkDerivation rec {
  pname = "libcutefish";
  version = "0.5";

  src = fetchgit {
    url = "https://github.com/cutefishos/${pname}";
    rev = "${version}";
    hash = "sha256-os47UB/qyhiNu6MIihWI7bBWYLM+n0IrSdZM85Fys1o=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = (with libsForQt5; [ qtbase qtquickcontrols qtquickcontrols2 ])
    ++ (with libsForQt5; [ bluez-qt networkmanager-qt modemmanager-qt ])
    ++ (with libsForQt5; [ libkscreen kio qtsensors ]);

  dontWrapQtApps = true;

  # https://github.com/cutefishos/libcutefish/blob/0.5/CMakeLists.txt#L25
  patchPhase = "sed -i '25,28d' CMakeLists.txt";
  cmakeFlags = [ "-DINSTALL_QMLDIR=lib/qt-${libsForQt5.qtbase.version}/qml" ];
}
