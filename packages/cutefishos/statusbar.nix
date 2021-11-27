{ stdenv, fetchgit, cmake, libsForQt5, pkg-config, callPackage, ... }:
let cutefishos = callPackage ./default.nix { }; in
stdenv.mkDerivation rec {
  pname = "statusbar";
  version = "0.5";

  src = fetchgit {
    url = "https://github.com/cutefishos/${pname}";
    rev = "${version}";
    hash = "sha256-VPxyS5F32gKYdMZe8NKlzyQC64UKIbk/1bOFPYCA+ns=";
  };

  nativeBuildInputs = [ cmake libsForQt5.wrapQtAppsHook pkg-config ];
  buildInputs = with libsForQt5; [ qtx11extras qttools qtquickcontrols2 kwindowsystem ]
    ++ (with cutefishos; [ fishui libcutefish libsForQt5.qtgraphicaleffects ]);

  # https://github.com/cutefishos/statusbar/blob/0.5/CMakeLists.txt#L120
  patchPhase = "sed -i 's@/usr/@@g' CMakeLists.txt";
}
