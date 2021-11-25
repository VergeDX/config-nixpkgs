{ stdenv, fetchgit, cmake, ... }:
stdenv.mkDerivation rec {
  pname = "lirios-cmake-shared";
  version = "1.1.0";

  src = fetchgit {
    url = "https://github.com/lirios/cmake-shared";
    rev = "v${version}";
    hash = "sha256-PjcoZY7oJRdvwBS5yn3ERDduF6weoevf18BRRascLes=";
  };

  nativeBuildInputs = [ cmake ];
}
