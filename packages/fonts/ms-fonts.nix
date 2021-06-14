{ stdenv }:
stdenv.mkDerivation rec {
  name = "ms-fonts";

  # see https://aur.archlinux.org/packages/ttf-ms-fonts/
  # Download all the sources exe, extract them and grab .ttf
  src = ../resources/ms-fonts.tar.gz;
  installPhase = ''
    mkdir -p $out/share/fonts/${name}
    cp * $out/share/fonts/${name}
  '';
}
