{ stdenv, fetchgit }:
stdenv.mkDerivation rec {
  name = "tabnine-vim";
  version = "2.10.0";

  src = fetchgit {
    url = "https://github.com/codota/${name}";
    rev = version;
    sha256 = "sha256-/9qjUunyFZ7uWwdAZCb/p2Pyn6U5GOvjuM8yFwYNKjM=";
  };

  installPhase = ''
    mkdir -p $out/${name}
    cp -r * $out/${name}'';
}
