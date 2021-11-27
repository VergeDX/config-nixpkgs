{ stdenv, fetchgit, cmake, libsForQt5, callPackage, ... }:
let cutefishos = callPackage ./default.nix { }; in
stdenv.mkDerivation rec {
  pname = "dock";
  version = "0.5";

  src = fetchgit {
    url = "https://github.com/cutefishos/${pname}";
    rev = "${version}";
    hash = "sha256-SFvxDoaZNtlvHFjDbEdLXQkz2vzd7vSKqI7QrwjxIZ8=";
  };

  nativeBuildInputs = [ cmake libsForQt5.wrapQtAppsHook ];
  buildInputs = with libsForQt5; [ qtx11extras qttools qtquickcontrols2 kwindowsystem ]
    ++ [ cutefishos.fishui libsForQt5.qtgraphicaleffects ];

  # https://github.com/cutefishos/dock/blob/0.5/CMakeLists.txt#L62
  patchPhase = ''
    sed -i 's@/usr@usr@g' CMakeLists.txt
    sed -i 's@/etc@etc@g' CMakeLists.txt
  '';
}
