{ stdenvNoCC, fetchgit, ... }:
stdenvNoCC.mkDerivation rec {
  pname = "distrobox";
  version = "1.2.10";

  src = fetchgit {
    url = "https://github.com/89luca89/${pname}";
    rev = "${version}";
    hash = "sha256-qTBqFpL6qsQX/KXU3jSikRglErrPBTTC4iYKSB9xc8k=";
  };

  installPhase = ''
    mkdir -p $out/bin
    ./install -p $_
  '';
}
