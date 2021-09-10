let
  pkgs = import <nixpkgs> { };
  cutefish-icons = pkgs.stdenv.mkDerivation rec {
    name = "cutefish-icons";
    version = "0.4";

    src = pkgs.fetchgit {
      url = "https://github.com/cutefishos/icons";
      rev = version;
      sha256 = "sha256-SG3ivpsycY789uE/ljCRi0KsrR9WyNjqIbhWfNnjHjs=";
    };

    nativeBuildInputs = [ pkgs.cmake ];
    installPhase = ''
      sed -i 's@/var/empty@'"$out"'@g' cmake_install.cmake
      make install
    '';
  };
in
cutefish-icons
