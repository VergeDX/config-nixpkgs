{ stdenv, fetchgit, cmake, libsForQt5, callPackage, ... }:
let cutefishos-fishui = callPackage ./cutefishos-fishui.nix { }; in
stdenv.mkDerivation rec {
  pname = "cutefishos-calculator";
  version = "0.4";

  src = fetchgit {
    url = "https://github.com/cutefishos/calculator";
    rev = "${version}";
    hash = "sha256-DMsRVI9QGDYLoJW99FofQHAztnIEVyJ2PT4xBOq5rbg=";
  };

  nativeBuildInputs = [ cmake libsForQt5.wrapQtAppsHook ];
  buildInputs = with libsForQt5; [ qtquickcontrols2 qttools ]
    ++ (with libsForQt5; [ qtquickcontrols cutefishos-fishui qtgraphicaleffects ])
    ++ [ libsForQt5.kwindowsystem ];

  # https://github.com/cutefishos/calculator/blob/0.4/CMakeLists.txt#L58
  patchPhase = "sed -i 's@/usr/@@g' CMakeLists.txt";
}
