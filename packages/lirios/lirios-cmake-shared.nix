{ stdenv, fetchgit, cmake, ... }:
stdenv.mkDerivation rec {
  pname = "lirios-cmake-shared";
  version = "f886cca";

  src = fetchgit {
    url = "https://github.com/lirios/cmake-shared";
    rev = "${version}1d18f5c1e8a56b9a035013f460bec38b7";
    hash = "sha256-mhnym2iL/laryrwu6DNZLz9Cxn/ioa0tGUHqmCwoXtg=";
  };

  nativeBuildInputs = [ cmake ];
}
