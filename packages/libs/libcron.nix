{ stdenv, fetchgit, cmake, ... }:
stdenv.mkDerivation rec {
  pname = "libcron";
  version = "d4679b7";

  src = fetchgit {
    url = "https://github.com/PerMalmberg/${pname}";
    rev = "${version}c3cd7b03bf3865dc1709f1d1133fb7ee1";
    hash = "sha256-Rv88F/cWK3ypoA/VVD4+DyRP1ac2bwmZrcZPo3gMpg4=";
  };

  nativeBuildInputs = [ cmake ];
}
