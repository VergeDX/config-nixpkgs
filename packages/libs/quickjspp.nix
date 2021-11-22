{ stdenv, fetchgit, cmake, ... }:
stdenv.mkDerivation rec {
  pname = "quickjspp";
  version = "b71945e";

  src = fetchgit {
    url = "https://github.com/ftk/${pname}";
    rev = "${version}0ffd585ac024bb8fc5c5523b896fd92f6";
    hash = "sha256-rQV7bnnZ9fB7YbgtzENDLo+IpP3QOdaytvovmZyRblo=";
  };

  nativeBuildInputs = [ cmake ];
}
