{ stdenv, fetchFromGitHub, meson, pkg-config, cmake, pacman, perl, ninja, libarchive, ... }:
stdenv.mkDerivation rec {
  pname = "expac";
  version = "10";

  src = fetchFromGitHub {
    owner = "falconindy";
    repo = "${pname}";
    rev = "${version}";
    hash = "sha256-aDO2p1R9XnCFrUvbP25flxjNFqh8bYgHznBX/ONrTC0=";
  };

  nativeBuildInputs = [ meson pkg-config cmake ninja ];
  buildInputs = [ pacman perl libarchive ];
}
