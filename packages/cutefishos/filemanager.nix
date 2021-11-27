{ stdenv, fetchgit, cmake, libsForQt5, callPackage, ... }:
let cutefishos-fishui = callPackage ./cutefishos-fishui.nix { }; in
stdenv.mkDerivation rec {
  pname = "cutefishos-filemanager";
  version = "0.5";

  src = fetchgit {
    url = "https://github.com/cutefishos/filemanager";
    rev = "${version}";
    hash = "sha256-zuzE+oZnRbDMF1O990UgZG1KhvTqVc2ZS+iSH9dKsqc=";
  };

  nativeBuildInputs = [ cmake libsForQt5.wrapQtAppsHook ];
  buildInputs = with libsForQt5; [ qttools kio ]
    ++ (with libsForQt5; [ qtquickcontrols2 cutefishos-fishui qtgraphicaleffects ]);

  # https://github.com/cutefishos/filemanager/blob/0.5/CMakeLists.txt#L93
  patchPhase = "sed -i 's@/usr@usr@g' CMakeLists.txt";
}
