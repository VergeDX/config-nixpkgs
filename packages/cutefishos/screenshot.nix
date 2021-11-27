{ stdenv, fetchgit, cmake, libsForQt5, callPackage, ... }:
let cutefishos = callPackage ./default.nix { }; in
stdenv.mkDerivation rec {
  pname = "screenshot";
  version = "0.5";

  src = fetchgit {
    url = "https://github.com/cutefishos/${pname}";
    rev = "${version}";
    hash = "sha256-cHMbsvvsNdtg8yuHl2JM+eldV7Gnmh9vB0z1ImyuLd0=";
  };

  nativeBuildInputs = [ cmake libsForQt5.wrapQtAppsHook ];
  buildInputs = with libsForQt5; [ qttools ]
    ++ (with libsForQt5; [ qtquickcontrols2 cutefishos.fishui qtgraphicaleffects ]);

  # https://github.com/cutefishos/screenshot/blob/0.5/CMakeLists.txt#L40
  patchPhase = "sed -i 's@/usr/@@g' CMakeLists.txt";
}
