{ stdenv, fetchgit, cmake, ... }:
stdenv.mkDerivation rec {
  pname = "wallpapers";
  version = "0.4";

  src = fetchgit {
    url = "https://github.com/cutefishos/${pname}";
    rev = "${version}";
    hash = "sha256-vYe7uZZRqrxevHq3fO2YhyJLQr2OSafYbwaeA4/f6vQ=";
  };

  nativeBuildInputs = [ cmake ];

  # https://github.com/cutefishos/wallpapers/blob/0.4/sources/CMakeLists.txt#L17
  patchPhase = "sed -i 's@/usr/@@g' sources/CMakeLists.txt";
}
