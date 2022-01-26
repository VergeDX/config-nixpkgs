{ stdenv, fetchgit, automake, autoconf, SDL, ncurses, zlib, ... }:
stdenv.mkDerivation rec {
  pname = "dosbox-x";
  version = "v0.83.21";

  src = fetchgit {
    url = "https://github.com/joncampbell123/${pname}";
    rev = "${pname}-${version}";
    hash = "sha256-nbFXer+qAluH7LYm5f6IusWdoDIeYsO/28KXpVEI9N8=";
  };

  patchPhase = "patchShebangs .";
  buildPhase = "./build-debug --prefix=$out";

  nativeBuildInputs = [ automake autoconf ];
  buildInputs = [ SDL ncurses zlib ];

  patches = [
    ./remove-prefix.patch
    ./make-j-nproc.patch
  ];
}
