{ stdenv, fetchgit, cmake, libsForQt5, callPackage, ... }:
let cutefishos-fishui = callPackage ./cutefishos-fishui.nix { }; in
let cutefishos-libcutefish = callPackage ./cutefishos-libcutefish.nix { }; in
stdenv.mkDerivation rec {
  pname = "cutefishos-launcher";
  version = "0.5";

  src = fetchgit {
    url = "https://github.com/cutefishos/launcher";
    rev = "${version}";
    hash = "sha256-UiROAYwY3TO0vW5xrf3PN4MTx+TNng1b7zVWQYMEozo=";
  };

  nativeBuildInputs = [ cmake libsForQt5.wrapQtAppsHook ];
  buildInputs = with libsForQt5; [ qtquickcontrols2 qttools kwindowsystem ]
    ++ [ cutefishos-fishui libsForQt5.qtgraphicaleffects cutefishos-libcutefish ];

  # https://github.com/cutefishos/launcher/blob/0.5/CMakeLists.txt#L59
  patchPhase = "sed -i 's@/usr/@@g' CMakeLists.txt";
}
