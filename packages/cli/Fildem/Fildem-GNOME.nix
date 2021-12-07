{ stdenv, fetchgit, ... }:
stdenv.mkDerivation rec {
  pname = "Fildem-GNOME";
  version = "0.6.7";

  src = fetchgit {
    url = "https://github.com/gonzaarcr/Fildem";
    rev = "${version}";
    hash = "sha256-qly934EaWY9noDQ1L7X06NjGr5PFMjTIjY8esLcn0tE=";
  };

  buildPhase = "echo -n";
  patches = [ ./GNOME-41.patch ];
  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions && cd $_
    ln -s ${src}/fildemGMenu@gonza.com .
  '';
}
