let
  pkgs = import <nixpkgs> { };
  cutefish-wallpapers = pkgs.stdenv.mkDerivation rec {
    name = "cutefish-wallpapers";
    version = "0.4";

    src = pkgs.fetchgit {
      url = "https://github.com/cutefishos/wallpapers";
      rev = version;
      sha256 = "sha256-vYe7uZZRqrxevHq3fO2YhyJLQr2OSafYbwaeA4/f6vQ=";
    };

    nativeBuildInputs = [ pkgs.cmake ];
    installPhase = ''
      sed -i 's@/var/empty@'"$out"'@g' sources/cmake_install.cmake
      make install
    '';
  };
in
cutefish-wallpapers
